Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1443763138-23207-1-git-send-email-jpawlowski@google.com>
References: <1443763138-23207-1-git-send-email-jpawlowski@google.com>
Date: Wed, 7 Oct 2015 13:42:48 -0700
Message-ID: <CAD0=r8xfT=rBigX+fX3r0UgdTGwLyT8HixysEcB4Bnpe0vPOWQ@mail.gmail.com>
Subject: Re: [PATCH] core/device: Fix disconnect for connect attempt
From: Jakub Pawlowski <jpawlowski@google.com>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Cc: Jakub Pawlowski <jpawlowski@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Ping ?

On Thu, Oct 1, 2015 at 10:18 PM, Jakub Pawlowski <jpawlowski@google.com> wrote:
> Right now calling Disconnect from DBus on device that's not advertising
> or out of sight will not stop the connect attempt in kernel. This patch
> fixes that by making sure that att_io is properly cleaned up on
> disconnect.
> ---
>  src/device.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/src/device.c b/src/device.c
> index 5ec8780..fd177f4 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -1355,6 +1355,12 @@ void device_request_disconnect(struct btd_device *device, DBusMessage *msg)
>         if (device->browse)
>                 browse_request_cancel(device->browse);
>
> +       if (device->att_io) {
> +               g_io_channel_shutdown(device->att_io, FALSE, NULL);
> +               g_io_channel_unref(device->att_io);
> +               device->att_io = NULL;
> +       }
> +
>         if (device->connect) {
>                 DBusMessage *reply = btd_error_failed(device->connect,
>                                                                 "Cancelled");
> --
> 2.5.0
>
