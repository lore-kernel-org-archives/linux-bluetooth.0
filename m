Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1327060466-17978-2-git-send-email-smriti.gupta@stericsson.com>
References: <1327060466-17978-1-git-send-email-smriti.gupta@stericsson.com>
	<1327060466-17978-2-git-send-email-smriti.gupta@stericsson.com>
Date: Thu, 2 Feb 2012 16:22:24 -0300
Message-ID: <CAKT1EBfkE3R3rmMfPovUxgLp8mEO64NYa6_oAvGmosA2W6urrA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 1/1] Add provision for terminating an ATT connection
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Smriti Gupta <smriti.gupta@stericsson.com>
Cc: linux-bluetooth@vger.kernel.org, naresh.gupta@stericsson.com,
	smritigupta2008@gmail.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Smriti Gupta,

On Fri, Jan 20, 2012 at 8:54 AM, Smriti Gupta
<smriti.gupta@stericsson.com> wrote:
> In order to terminate any existing ATT connection from the client side
> existing function device_request_disconnect has been updated.
> ---
>  src/device.c |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)
>
> diff --git a/src/device.c b/src/device.c
> index 16855b1..7b5107b 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -781,6 +781,7 @@ static void bonding_request_cancel(struct bonding_req *bonding)
>  void device_request_disconnect(struct btd_device *device, DBusMessage *msg)
>  {
>        DBusConnection *conn = get_dbus_connection();
> +       GIOChannel *io;
>
>        if (device->bonding)
>                bonding_request_cancel(device->bonding);
> @@ -790,6 +791,14 @@ void device_request_disconnect(struct btd_device *device, DBusMessage *msg)
>                browse_request_cancel(device->browse);
>        }
>
> +       if (device->attrib) {
> +               io = g_attrib_get_channel(device->attrib);
> +               if (io) {
> +                       g_io_channel_shutdown(io, FALSE, NULL);
> +                       g_io_channel_unref(io);
> +               }
> +       }
> +
>        if (msg)
>                device->disconnects = g_slist_append(device->disconnects,
>                                                dbus_message_ref(msg));
> --
> 1.7.0.4
>

Ack.

Tested with simple-agent and test-device over BLE.

BR,
Claudio
