Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Barry Byford <31baz66@gmail.com>
Date: Wed, 5 Oct 2016 21:31:45 +0100
Message-ID: <CAAu3APY4HhpFyBBu9nLqPyO6SvQpC_tTj1pokSCn4DtxQQZbRg@mail.gmail.com>
Subject: Fatbeacons and 'streamed read' of a characteristic
To: Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I've been doing some experiments with Googles Physical Web Fatbeacon
https://github.com/google/physical-web/issues/784#issuecomment-251571858

The experiments have been with BlueZ 5.40 using the DBus API with
Python 3. BlueZ is advertising a connectable Eddystone beacon. When
the Physical Web Android app connects there is one service with one
characteristic that it is looking for. That characteristic contains a
string that is the HTML content.
All is working well if the web page contained in the characteristic is
nice and short.
However if I make the web page content slightly longer then I end up
getting stuck in a loop where the Physical Web app is just reading the
first part of the characteristic over and over again.

I'm assuming that it is not that uncommon for data to be larger than
can be retrieved in one read although I've not been able to find an
example. I'm a little bit at a loss as to what the ReadValue method
should look like for this characteristic.
Is anyone able to give me some pointers as to what I need to do to get
this to work?

Thanks in advance,
Barry
