Return-Path: <cyrus@holtmann.org>
Date: Mon, 9 Jun 2014 12:49:52 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vinod Rayapudi <vinod.rayapudi@tcs.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-bluetooth-owner@vger.kernel.org, autoanswer@vger.kernel.org
Subject: Re: SPP profile in Bluez
Message-ID: <20140609094952.GA23710@t440s.lan>
References: <OF3D8FCC47.DCEA4A21-ON65257CF2.00332791-65257CF2.00332795@tcs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <OF3D8FCC47.DCEA4A21-ON65257CF2.00332791-65257CF2.00332795@tcs.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinod,

On Mon, Jun 09, 2014, Vinod Rayapudi wrote:
> I want to use SPP in Bluez stack.
> 
> Can anyone help me, from which versions of Bluez SPP is available ?

SPP has always been available with BlueZ. The only thing that has kept
changing a bit is the preferred way to implement it. The RFCOMM socket
interface would be an option that's available regardless of BlueZ
version, however it may not be the most convenient one if you can
restrict yourself to newer BlueZ versions.

> I would like to use SPP Connect, Disconnect, Read and Write functionalities.

With BlueZ 5 the simplest way is probably to use the Profile interface
(see doc/profile-api.txt and test/test-profile). If you implement that
interface you will get the new SPP connection (RFCOMM socket) handed
over to you over D-Bus once successfully connected. Connecting as client
would happen by issuing a ConnectProfile("spp") D-Bus method call.

Johan
