Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAu3APY4HhpFyBBu9nLqPyO6SvQpC_tTj1pokSCn4DtxQQZbRg@mail.gmail.com>
References: <CAAu3APY4HhpFyBBu9nLqPyO6SvQpC_tTj1pokSCn4DtxQQZbRg@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 6 Oct 2016 11:23:30 +0300
Message-ID: <CABBYNZ++LGPjjWSxz4DyjgjNRm2Qyq6F50bbLDfKgJAdXSVYLA@mail.gmail.com>
Subject: Re: Fatbeacons and 'streamed read' of a characteristic
To: Barry Byford <31baz66@gmail.com>
Cc: Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Barry,

On Wed, Oct 5, 2016 at 11:31 PM, Barry Byford <31baz66@gmail.com> wrote:
> Hello,
>
> I've been doing some experiments with Googles Physical Web Fatbeacon
> https://github.com/google/physical-web/issues/784#issuecomment-251571858
>
> The experiments have been with BlueZ 5.40 using the DBus API with
> Python 3. BlueZ is advertising a connectable Eddystone beacon. When
> the Physical Web Android app connects there is one service with one
> characteristic that it is looking for. That characteristic contains a
> string that is the HTML content.
> All is working well if the web page contained in the characteristic is
> nice and short.
> However if I make the web page content slightly longer then I end up
> getting stuck in a loop where the Physical Web app is just reading the
> first part of the characteristic over and over again.

How big is it? The spec actually limits the attribute contents to 512
bytes. On the other hand I remember the Android App returning
different parts of the data on every read, so it essentially doing its
own fragmentation.

> I'm assuming that it is not that uncommon for data to be larger than
> can be retrieved in one read although I've not been able to find an
> example. I'm a little bit at a loss as to what the ReadValue method
> should look like for this characteristic.
> Is anyone able to give me some pointers as to what I need to do to get
> this to work?

Check out the Android physical web application:

https://play.google.com/store/apps/details?id=physical_web.org.physicalweb&hl=en

-- 
Luiz Augusto von Dentz
