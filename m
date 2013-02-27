Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20130226195629.GC10898@joana>
References: <1361731026-7428-1-git-send-email-dh.herrmann@gmail.com>
	<1361731026-7428-4-git-send-email-dh.herrmann@gmail.com>
	<20130226195629.GC10898@joana>
Date: Wed, 27 Feb 2013 12:16:57 +0100
Message-ID: <CANq1E4REp+b4VJSTrKmB2cwwYLKDhX6jV_qoa_axa8=qRNat1A@mail.gmail.com>
Subject: Re: [PATCH 03/16] Bluetooth: hidp: simplify error path in sock-init
From: David Herrmann <dh.herrmann@gmail.com>
To: Gustavo Padovan <gustavo@padovan.org>, David Herrmann <dh.herrmann@gmail.com>,
	linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo

On Tue, Feb 26, 2013 at 8:56 PM, Gustavo Padovan <gustavo@padovan.org> wrote:
> Hi David,
>
> * David Herrmann <dh.herrmann@gmail.com> [2013-02-24 19:36:53 +0100]:
>
>> We currently print errors twice when doing a "goto error;". Avoid this and
>> also use labels for each error-condition. We shouldn't mix
>> "inline-cleanup" and "goto-cleanup" in a single function. It makes
>> extending the function later just more work.
>>
>> Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
>> ---
>>  net/bluetooth/hidp/sock.c | 10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/net/bluetooth/hidp/sock.c b/net/bluetooth/hidp/sock.c
>> index 5d0f1ca..ca86436 100644
>> --- a/net/bluetooth/hidp/sock.c
>> +++ b/net/bluetooth/hidp/sock.c
>> @@ -281,22 +281,22 @@ int __init hidp_init_sockets(void)
>>       err = bt_sock_register(BTPROTO_HIDP, &hidp_sock_family_ops);
>>       if (err < 0) {
>>               BT_ERR("Can't register HIDP socket");
>> -             goto error;
>> +             goto err_proto;
>>       }
>>
>>       err = bt_procfs_init(THIS_MODULE, &init_net, "hidp", &hidp_sk_list, NULL);
>>       if (err < 0) {
>>               BT_ERR("Failed to create HIDP proc file");
>> -             bt_sock_unregister(BTPROTO_HIDP);
>> -             goto error;
>> +             goto err_sock;
>
> Actually I'm ok with mixing inline and goto clean up here, It's simpler
> than add another goto.

But it makes review harder. If there's one central place (trailing
goto's) where cleanup is done, it's much easier to review
cleanup-paths. Anyway, your decision. I will fix it up and resend.

Thanks!
David
