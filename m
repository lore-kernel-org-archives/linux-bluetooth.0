Return-Path: <cyrus@holtmann.org>
Date: Wed, 29 Aug 2012 13:58:27 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: "Vellemans, Noel" <Noel.Vellemans@visionBMS.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Which software is responsible for bringing the devices (hci0 ..
 hcix) up ?
Message-ID: <20120829105819.GA3745@aemeltch-MOBL1>
References: <1531E53627F1F749B4FE809BF2A4EB67036F2F97@WETMEX10.loepfe.com>
 <20120829070853.GA3937@aemeltch-MOBL1>
 <1531E53627F1F749B4FE809BF2A4EB67036F2FAC@WETMEX10.loepfe.com>
 <20120829071455.GB3937@aemeltch-MOBL1>
 <1531E53627F1F749B4FE809BF2A4EB67036F2FB2@WETMEX10.loepfe.com>
 <20120829073733.GC3937@aemeltch-MOBL1>
 <1531E53627F1F749B4FE809BF2A4EB67036F2FD3@WETMEX10.loepfe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1531E53627F1F749B4FE809BF2A4EB67036F2FD3@WETMEX10.loepfe.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Aug 29, 2012 at 09:49:14AM +0200, Vellemans, Noel wrote:
> Hi,
> 
> >> Do you have bluetoothd running?
> 
> OK : You've got it.. I think.
> 
> When looking into the process-list with ps , I don't see bluetoothd.
> 
> When starting Bluetoothd on the command line .. . before plugging in the
> device .. 
> the the device is 'UP' like it should be... (you are guiding/pointing me
> in the GOOD direction, thankx) 
> 
> 
> Next question (Sorry) ? Isn't bluetoothd supposed to be launched by udev
> ?
> 
> Or I'm I missing some startup-script  (/etc/init.d/... ) ?
> 
> I just wonder is there somewhere a description on how bleuz (bluetooth)
> is started at boot ?

This depends on your distro, I personally run it manually. I think you
need to enable it via some bluetooth-applet.

Best regards 
Andrei Emeltchenko 

