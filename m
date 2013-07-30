Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CALvrRrZxEZRuohxeeuTqU1VE9TfBHudwH9LL_1v3-oG+DNojMQ@mail.gmail.com>
References: <CALvrRrayFrDqhm7hoDRpdnbaXhpzaSq9Q7+4GoXEnqBi82KcKQ@mail.gmail.com>
	<CAJdJm_NX2YopqON=Szv3X2DuuYhrGZcRPcNrE=BjdV+NVQtEnA@mail.gmail.com>
	<CALvrRrZxEZRuohxeeuTqU1VE9TfBHudwH9LL_1v3-oG+DNojMQ@mail.gmail.com>
Date: Tue, 30 Jul 2013 19:08:45 -0400
Message-ID: <CAJdJm_NgnH5N93Xv1342XGoyUi7Fo1DYmCOr3n6kZGcJ+8kFmQ@mail.gmail.com>
Subject: Re: gatt advertising
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Dirk-Jan Binnema <djcb.bulk@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dirk,

On Tue, Jul 30, 2013 at 6:50 PM, Dirk-Jan Binnema <djcb.bulk@gmail.com> wrote:
> One other thing I've hit upon is that apparently, long-writes/reads are
> supported by ATT yet (looking at channel_handler, and seeing some
> 'Unsupported request 0x16'), although it seems Bluez can do long-writes
> itself.

If I remember correctly, indeed we only support Read/Write Long
Characteristic Values on the GATT client code. We have been working on
refactoring the attribute server, but the code is not ready yet to be
sent upstream.

> Are there plans to add long-writes/reads to ATT? Or would this be very
> easy to add? (I suppose not!).

I'm not aware of anyone working on this at the moment on the attribute
server code. Regarding complexity, I think implementing Read Blob
Request would be easy, Prepare Write / Execute Write Request may be
more difficult, as you need to keep state saved and support more than
one active client at the same time.

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
