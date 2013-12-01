Return-Path: <cyrus@holtmann.org>
Message-ID: <1385936884.5405.3.camel@nuvo>
Subject: Re: have to re-pair mouse every few hours
From: Bastien Nocera <hadess@hadess.net>
To: "Brian J. Murrell" <brian@interlinx.bc.ca>
Cc: linux-bluetooth@vger.kernel.org
Date: Sun, 01 Dec 2013 23:28:04 +0100
In-Reply-To: <1385843856.12122.5.camel@pc.interlinx.bc.ca>
References: <1385843856.12122.5.camel@pc.interlinx.bc.ca>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hey Brian,

On Sat, 2013-11-30 at 15:37 -0500, Brian J. Murrell wrote:
> Hi,
> 
> I'm using a Microsoft Sculpt Touch Mouse on a Fedora 19 machine
> (kernel-3.11.9-200.fc19.x86_64 and bluez-4.101-9.fc19.x86_64) with a:
> 
> Bus 002 Device 019: ID 0a5c:2148 Broadcom Corp. BCM92046DG-CL1ROM Bluetooth 2.1 Adapter
> 
> bluetooth adapter.  This exact same configuration worked for months just
> fine with a Logitech bluetooth mouse.  But sadly that mouse was crap
> (second one to fail within the warranty period of one of them) so
> replaced it with this MS one.
> 
> The problem with this MS mouse is that it just goes AWOL and needs to be
> delete and re-paired with the machine every few hours.  Typically it's
> after I have gotten up from the computer and have come back to it.  But
> I have also had it just happen while using it.
> 
> When this happens, the messages log reports messages such as:
> 
> Nov 30 12:42:03 pc kernel: [2500032.028982] Bluetooth: Unexpected continuation frame (len 0)
> Nov 30 12:42:03 pc kernel: [2500032.115027] Bluetooth: Unexpected continuation frame (len 0)
> 
> Any ideas what the problem might be here?

Upstream developers don't work on BlueZ 4.x anymore. Any chance for you
to test using Fedora 20? It uses BlueZ 5.x which has a lot of fixes and
architectural changes compared to 4.x.

Cheers

