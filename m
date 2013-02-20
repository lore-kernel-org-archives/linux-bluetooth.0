Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1361197622.4983.2.camel@dellpc>
References: <1361197622.4983.2.camel@dellpc>
Date: Wed, 20 Feb 2013 16:29:07 +0100
Message-ID: <CANq1E4QD1O64iZuN3pToOddQMp8kF57BGUcD5hDPmm7MYPwJ7w@mail.gmail.com>
Subject: Re: Resend [PATCH] hidp: Make hidp_get_raw_report abort if the
 session is terminating
From: David Herrmann <dh.herrmann@gmail.com>
To: Karl Relton <karllinuxtest.relton@ntlworld.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Karl

One minor nitpick below:

On Mon, Feb 18, 2013 at 3:27 PM, Karl Relton
<karllinuxtest.relton@ntlworld.com> wrote:
> From: Karl Relton <karllinuxtest.relton@ntlworld.com>
>
> After linux 3.2 the hid_destroy_device call in hidp_session cleaning up
> invokes a hook to the power_supply code which in turn tries to read the
> battery capacity. This read will trigger a call to hidp_get_raw_report
> which is bound to fail because the device is being taken away - so rather
> than wait for the 5 second timeout failure this change enables it to fail
> straight away.
>
> Signed-off-by: Karl Relton <karllinuxtest.relton@ntlworld.com>
> ---
>  net/bluetooth/hidp/core.c |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
> index b2bcbe2..a4c1bb0 100644
> --- a/net/bluetooth/hidp/core.c
> +++ b/net/bluetooth/hidp/core.c
> @@ -311,6 +311,9 @@ static int hidp_get_raw_report(struct hid_device *hid,
>         int numbered_reports = hid->report_enum[report_type].numbered;
>         int ret;
>
> +       if (atomic_read(&session->terminate))
> +               return -EIO;
> +
>         switch (report_type) {
>         case HID_FEATURE_REPORT:
>                 report_type = HIDP_TRANS_GET_REPORT | HIDP_DATA_RTYPE_FEATURE;
> @@ -695,8 +698,10 @@ static int hidp_session(void *arg)
>         set_current_state(TASK_INTERRUPTIBLE);
>         while (!atomic_read(&session->terminate)) {
>                 if (ctrl_sk->sk_state != BT_CONNECTED ||
> -                               intr_sk->sk_state != BT_CONNECTED)
> +                               intr_sk->sk_state != BT_CONNECTED) {
> +                       atomic_inc(&session->terminate);

Lets move this atomic_inc() directly below the while() loop. This
guarantees that we won't trap into this again if we add other "break;"
conditions.

Other than that the patch looks fine. Feel free to add a:
  Reviewed-by: David Herrmann <dh.herrmann@gmail.com>

Thanks
David

>                         break;
> +               }
>
>                 while ((skb = skb_dequeue(&intr_sk->sk_receive_queue))) {
>                         skb_orphan(skb);
> --
> 1.7.9.5
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
