Return-Path: <maxk@qualcomm.com>
Subject: BCM2033 firmware loader [was Re: [Bluez-devel] Bluetooth kernel
	patch for 2.6.1]
From: Max Krasnyansky <maxk@qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1074193649.2629.23.camel@pegasus>
References: <1074193649.2629.23.camel@pegasus>
Content-Type: text/plain
Message-Id: <1074196213.2559.255.camel@localhost>
Mime-Version: 1.0
Date: Thu, 15 Jan 2004 11:50:13 -0800
List-ID: <bluez-devel.lists.sourceforge.net>

On Thu, 2004-01-15 at 11:07, Marcel Holtmann wrote:
> Hi Folks,
> 
> the third Bluetooth kernel patch for 2.6.1 is now available [1]. It
> fixes the inquiry after boot problem and the RFCOMM reference counting
> bug. 

Marcel,

What's wrong with BlueFW ? Why did you implement BCM FW loader in the
kernel ?
I looked in the archive and the only thing I could find was that you
don't want to keep it without an explanation why.

Max
