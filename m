Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJdJm_NgnH5N93Xv1342XGoyUi7Fo1DYmCOr3n6kZGcJ+8kFmQ@mail.gmail.com>
References: <CALvrRrayFrDqhm7hoDRpdnbaXhpzaSq9Q7+4GoXEnqBi82KcKQ@mail.gmail.com>
	<CAJdJm_NX2YopqON=Szv3X2DuuYhrGZcRPcNrE=BjdV+NVQtEnA@mail.gmail.com>
	<CALvrRrZxEZRuohxeeuTqU1VE9TfBHudwH9LL_1v3-oG+DNojMQ@mail.gmail.com>
	<CAJdJm_NgnH5N93Xv1342XGoyUi7Fo1DYmCOr3n6kZGcJ+8kFmQ@mail.gmail.com>
Date: Wed, 31 Jul 2013 13:18:33 -0700
Message-ID: <CALvrRrYBb643mVuRP0i_9PCYTUWqyP0XjzMk0wEFndCzovyKtA@mail.gmail.com>
Subject: Re: gatt advertising
From: Dirk-Jan Binnema <djcb.bulk@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Thanks again for your insights!

anderson.lizardo@openbossa.org writes:

> If I remember correctly, indeed we only support Read/Write Long
> Characteristic Values on the GATT client code. We have been working on
> refactoring the attribute server, but the code is not ready yet to be
> sent upstream.

Okay, would you expect this feature to be available in the new attribute
server?

>> Are there plans to add long-writes/reads to ATT? Or would this be very
>> easy to add? (I suppose not!).
>
> I'm not aware of anyone working on this at the moment on the attribute
> server code. Regarding complexity, I think implementing Read Blob
> Request would be easy, Prepare Write / Execute Write Request may be
> more difficult, as you need to keep state saved and support more than
> one active client at the same time.

Okay, I can take a look...

A related thing are notifications -- I'm trying to send notifications of
changed characteristics to connected clients (I'm trying to use Bluez as
a peripheral for some mobile devices); I roughly follow the approach in
alert/server.c; however, I never get the callback from
btd_device_add_attio_callback, since device's attrib == NULL,  and so I
never get the chance to send the notification.

Any hint on what I could do?

(Frankly, I was expecting framework to take care of notifications, but
it seems I need to do so by hand. Or?)

Thanks in advance!
Dirk.


--
Dirk-Jan C. Binnema                  Helsinki, Finland
e:djcb@djcbsoftware.nl           w:www.djcbsoftware.nl
pgp: D09C E664 897D 7D39 5047 A178 E96A C7A1 017D DA3C

On Tue, Jul 30, 2013 at 4:08 PM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> Hi Dirk,
>
> On Tue, Jul 30, 2013 at 6:50 PM, Dirk-Jan Binnema <djcb.bulk@gmail.com> wrote:
>> One other thing I've hit upon is that apparently, long-writes/reads are
>> supported by ATT yet (looking at channel_handler, and seeing some
>> 'Unsupported request 0x16'), although it seems Bluez can do long-writes
>> itself.
>
> If I remember correctly, indeed we only support Read/Write Long
> Characteristic Values on the GATT client code. We have been working on
> refactoring the attribute server, but the code is not ready yet to be
> sent upstream.
>
>> Are there plans to add long-writes/reads to ATT? Or would this be very
>> easy to add? (I suppose not!).
>
> I'm not aware of anyone working on this at the moment on the attribute
> server code. Regarding complexity, I think implementing Read Blob
> Request would be easy, Prepare Write / Execute Write Request may be
> more difficult, as you need to keep state saved and support more than
> one active client at the same time.
>
> Best Regards,
> --
> Anderson Lizardo
> Instituto Nokia de Tecnologia - INdT
> Manaus - Brazil
