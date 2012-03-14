Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJdJm_MA24vaSzBeT6YS5-htYMjfszNmULrAtvPQgC=1LQLj-A@mail.gmail.com>
References: <1331215032-27695-1-git-send-email-arik@wizery.com>
 <1331215032-27695-7-git-send-email-arik@wizery.com> <CAJdJm_MA24vaSzBeT6YS5-htYMjfszNmULrAtvPQgC=1LQLj-A@mail.gmail.com>
From: Arik Nemtsov <arik@wizery.com>
Date: Wed, 14 Mar 2012 22:54:40 +0200
Message-ID: <CA+XVXfe+63UzYnutGFK7ARBOR6Zmu+Qcz=O=hrjThTYYU4=jDQ@mail.gmail.com>
Subject: Re: [PATCH 6/8] proximity: link loss: implement link loss server
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hey Anderson,

On Wed, Mar 14, 2012 at 15:09, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
>> +       lladapter->watch = g_dbus_add_signal_watch(lladapter->conn,
>> +                               BLUEZ_SERVICE, NULL, DEVICE_INTERFACE,
>> +                               "DisconnectRequested", handle_local_disconnect,
>> +                               lladapter, NULL);
>
> Does this also work if the device is removed locally with:
>
> * test-device remove ?
> * when bluez is shutting down?
> * user disables the adapter locally?

test-device should work - it uses Device.Disconnect(), which is
precisely the function that emits this signal.
When bluez or the adapter is shutdown the unregister_link_loss()
function is called, where we clear everything anyway.

>
> Also, listening to a d-bus signal of the process itself looks strange.
> Did you try the device_add_disconnect_watch() call instead?

Actually I wasn't aware of device_add_disconnect_watch() at the time.
It does look cleaner. I'll rewrite this part.

Thanks,
Arik
