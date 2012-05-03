Return-Path: <cyrus@holtmann.org>
Date: Thu, 3 May 2012 12:44:29 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Steffen Becker <steffen.becker@tu-ilmenau.de>
Cc: Gustavo Padovan <gustavo@padovan.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: Can't connect Bluetooth Devices
Message-ID: <20120503094429.GA6226@x220>
References: <4F968FF7.7060303@tu-ilmenau.de>
 <4FA1BB1C.6060409@tu-ilmenau.de>
 <20120502225815.GE16030@joana>
 <4FA23B93.8090204@tu-ilmenau.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4FA23B93.8090204@tu-ilmenau.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Steffen,

On Thu, May 03, 2012, Steffen Becker wrote:
> >A linkkey is created during the pairing procedure, just pair your
> >devices and you will be done.
> >And let only bluetoothd touch the /var/lib/bluetooth
> >directory, don't touch there yourself.
> >
> >	Gustavo
> 
> Thanks for your fast reply, but that's exactly what I don't know:
> How can I pair my devices?

You pair using the CreatePairedDevice D-Bus method that BlueZ provides.
There are various front-ends that you can use to call this method. If
you've got GNOME installed then a pairing wizard should be just a few
mouse clicks away through the Bluetooth icon in the upper right-hand
corner. If you've only got the command line you can use e.g. the
simple-agent python script (under the test subdirectory):

	test/simple-agent hci0 <remote address>

Btw, is there something that the network plugin (which you can operate
using e.g. test/test-network) doesn't provide but pand does? We'll
probably remove pand from the source tree along with BlueZ 5.0 so it'd
be good to know any deficiencies it has.

Johan
