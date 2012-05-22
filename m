Return-Path: <cyrus@holtmann.org>
Date: Tue, 22 May 2012 12:47:26 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Steffen Becker <steffen.becker@tu-ilmenau.de>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Grant Access to Advanced Audio Distribution Service
Message-ID: <20120522094725.GA12593@x220>
References: <4FBB5CCF.7080003@tu-ilmenau.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4FBB5CCF.7080003@tu-ilmenau.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Steffen,

On Tue, May 22, 2012, Steffen Becker wrote:
> maybe you remember me, I wrote some mails regarding a problem with
> the connection of two Bluetooth-Dongles.
> Now I tested a little bit with a Ubuntu Live CD and there I also
> couldn't create a connection between my devices *but* when I clicked
> on a pop-up-window at the remote device named "Grant Access to the
> service 0000110D-0000-1000-8000-00805F9B34FB", the connection
> worked!
> I googled and found out that:
> 
> 0000110D-0000-1000-8000-00805F9B34FB = AdvancedAudioDistributionService.
> So I think I have to grant access to this service in my
> gentoo-settings to get my connection work.
> But I have no idea where/how I can configure this.

The "Trusted" property for each device determines whether authorization
is needed for incoming connections. IIRC gnome-bluetooth sets this
automatically for all configured devices and from the command line you
can do it with the test-device python script (that's part of the BlueZ
source tree): test-device trusted <address> yes

Johan
