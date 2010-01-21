Return-Path: <cyrus@holtmann.org>
From: "Gunn, Brian" <bgunn@solekai.com>
To: Bastien Nocera <hadess@hadess.net>, Marcel Holtmann <marcel@holtmann.org>
CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input
	<linux-input@vger.kernel.org>, BlueZ development
	<linux-bluetooth@vger.kernel.org>, Ping <pinglinux@gmail.com>, Jiri Kosina
	<jikos@jikos.cz>
Date: Wed, 20 Jan 2010 17:08:37 -0800
Subject: RE: [PATCHes] Implement Bluetooth Wacom tablet's mode change in the
 kernel
Message-ID: <FE57175CCE23E5419899C1B0CFA26FAD101B5E591A@EXMBXSD.dm.solekai.com>
References: <1263833399.20565.2905.camel@localhost.localdomain>
	 <1263886149.5591.166.camel@localhost.localdomain>
 <1263897015.20565.3988.camel@localhost.localdomain>
In-Reply-To: <1263897015.20565.3988.camel@localhost.localdomain>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Bastien Nocera wrote:
> The patch was written by Jiri and tested by Brian. Not sure what sort of
> device Brian tested this with...

I just tested this patch with my device and it does work.  I had to slightl=
y alter the data I send (had to add 0xA2 to the front of it), but then it d=
oes work.

In my initial attempts, it does seem to work a little worse, but that is pr=
obably because of the device I'm using, which is still under development.

Brian
