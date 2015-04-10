Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <55279AD0.9010305@ubnt.com>
References: <55279AD0.9010305@ubnt.com>
Date: Fri, 10 Apr 2015 17:16:20 +0300
Message-ID: <CABBYNZKs6kSmR7GJqBTdD7iEaEh4YO8ih86v6ijUX0J4k9y2tg@mail.gmail.com>
Subject: Re: D-Bus signal race condition for Gatt characteristic notification
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrejs Hanins <andrejs.hanins@ubnt.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrejs,

On Fri, Apr 10, 2015 at 12:41 PM, Andrejs Hanins
<andrejs.hanins@ubnt.com> wrote:
> Hi,
>
>         There is a race condition when Gatt-client characteristic (att attribute) is notified (or indicated) by the remote server multiple times in a row and D-Bus property change signals with notified "Value" are emitted. It happens in write_characteristic_cb(). D-Bus signal is scheduled to be emitted later (during main loop idle, for example) in g_dbus_emit_property_changed::add_pending(). As I see, there are two issues here:
>
> 1) Each property can have at most one pending notification signal. If the previous signal is not yet sent out, the new signal is discarded (see g_dbus_emit_property_changed::find_property()). It looks bad to me, because there is no guarantee that D-Bus listener will get all received notifications/indications.
>
> 2) When property change D-Bus signal is emitted, the current value of the characteristic is used which might be already overwritten since the moment of Att notify/indicate receiving.
>
> Such behavior is fatal when each notification carries some new data. If notification is lost, data is also lost.
>
> I have fixed it in a trivial way - by adding g_dbus_flush() call into the write_characteristic_cb(). So that each each Att notification synchronously triggers the sending of D-Bus property change signal and it helps in my scenario. The question - is it a good way to fix it? If yes, I can submit a patch.

We might actually do something similar but with a flag, so when we
register GattCharacteristic we flag it with something like
G_DBUS_PROPERTY_FLAG_FLUSH thus any change to it should cause
g_dbus_flush automatically, the question is if we should always flag
it or just the characteristics that have notification/indication
support.


-- 
Luiz Augusto von Dentz
