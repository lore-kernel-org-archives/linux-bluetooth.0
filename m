Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20140609094952.GA23710@t440s.lan>
References: <20140609094952.GA23710@t440s.lan>,
	<OF3D8FCC47.DCEA4A21-ON65257CF2.00332791-65257CF2.00332795@tcs.com>
Subject: Re: SPP profile in Bluez
From: Vinod Rayapudi <vinod.rayapudi@tcs.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-bluetooth-owner@vger.kernel.org, autoanswer@vger.kernel.org
Message-ID: <OFCB7E0C57.B1D6416B-ON65257CF2.0046FA0F-65257CF2.0046FA12@tcs.com>
Date: Mon, 9 Jun 2014 18:25:15 +0530
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,
Thanks for your reply and suggestion too.

I want to know, Is the same available with Bluez 4.101 version.
I have been working with Bluez 4.x series.
Can I work with SPP on Bluez 4.101 ?

Can you share some inputs, If possible.


Thanks & Regards,
Vinod.


-----Johan Hedberg <johan.hedberg@gmail.com> wrote: -----
To: Vinod Rayapudi <vinod.rayapudi@tcs.com>
From: Johan Hedberg <johan.hedberg@gmail.com>
Date: 06/09/2014 03:20PM
Cc: linux-bluetooth@vger.kernel.org, linux-bluetooth-owner@vger.kernel.org, autoanswer@vger.kernel.org
Subject: Re: SPP profile in Bluez

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
=====-----=====-----=====
Notice: The information contained in this e-mail
message and/or attachments to it may contain 
confidential or privileged information. If you are 
not the intended recipient, any dissemination, use, 
review, distribution, printing or copying of the 
information contained in this e-mail message 
and/or attachments to it are strictly prohibited. If 
you have received this communication in error, 
please notify us by reply e-mail or telephone and 
immediately and permanently delete the message 
and any attachments. Thank you



