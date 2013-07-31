Return-Path: <cyrus@holtmann.org>
Date: Wed, 31 Jul 2013 10:57:51 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] core: Use proper header for S_IRUSR/S_IWUSR
Message-ID: <20130731075751.GA13668@x220.p-661hnu-f1>
References: <1373355600-12674-1-git-send-email-szymon.janc@tieto.com>
 <1668276.7oGYD4Lvyj@uw000953>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1668276.7oGYD4Lvyj@uw000953>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Wed, Jul 31, 2013, Szymon Janc wrote:
> On Tuesday 09 of July 2013 09:40:00 Szymon Janc wrote:
> > According to open() manual one should include <sys/stat.h>.
> > This fix build with bionic library:
> > 
> > target thumb C: libbluetoothd <= external/bluetooth/bluez/src/attrib-server.c
> > external/bluetooth/bluez/src/attrib-server.c: In function 'write_value':
> > external/bluetooth/bluez/src/attrib-server.c:922:26: error: 'S_IRUSR'
> > 	 undeclared (first use in this function)
> > external/bluetooth/bluez/src/attrib-server.c:922:26: note: each undeclared
> > 	identifier is reported only once for each function it appears in
> > external/bluetooth/bluez/src/attrib-server.c:922:36: error: 'S_IWUSR'
> > 	undeclared (first use in this function)
> 
> ping

This was applied already a few weeks ago (July 15th) and I even sent the
usual "applied" email about it.

Johan
