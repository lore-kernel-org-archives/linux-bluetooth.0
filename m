Return-Path: <aklish1@urbana.css.mot.com>
Date: Thu, 18 Dec 2003 08:57:57 -0600 (CST)
From: Aaron Klish <aklish1@urbana.css.mot.com>
To: Marcel Holtmann <marcel@holtmann.org>
cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] New Bluetooth kernel patches available
In-Reply-To: <1071505820.6499.80.camel@pegasus>
Message-ID: <Pine.GSO.4.20.0312180855340.12853-100000@wombat.urbana.css.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel,
  Motorola will use the 2.4.20 patches for sometime.  We'd appreciate it
if you could continue to maintain that line.  Thanks. 

Aaron

------------
Aaron Klish
Bluetooth Software Engineer
Motorola PCS
PH# (217) 384-8598
FX# (217) 384-8550

[X]  Motorola General Business Information
[ ]  Motorola Internal Use Only
[ ]  Motorola Confidential Proprietary

On Mon, 15 Dec 2003, Marcel Holtmann wrote:

> Hi Folks,
> 
> I spent most time of the weekend to get out a new series of patches for
> the 2.4 kernel. Actually there are six supported kernels and the latest
> version of each patch also touches the input subsystem and parts of the
> CAPI implementation. People who plan to play with the Bluetooth HID
> support should enable CONFIG_INPUT_UINPUT. The changelog and the patches
> themself can be found here
> 
> 	http://www.holtmann.org/linux/kernel/
> 
> It seems that the acceptance of these patches is very high, because the
> top 10 downloads are these
> 
> 	   2531  patch-2.4.22-mh1
> 	   1651  patch-2.4.20-mh12
> 	   1063  patch-2.4.21-mh2
> 	    868  patch-2.4.21-mh3
> 	    852  patch-2.4.20-mh10
> 	    788  patch-2.4.20-mh11
> 	    759  patch-2.4.21-mh4
> 	    560  patch-2.4.18-mh9
> 	    456  patch-2.4.20-mh6
> 	    418  patch-2.4.19-mh12
> 
> Even with my set of build and test scripts the job in putting out a new
> series of patches and backporting features to the older kernels consumes
> too much of my time. I personally don't use these patches anymore, but
> it seems that some people or companies still use them. At the moment I
> am thinking of cutting the maintenance for these kernels. Who has urgent
> needs that an older kernel version is still supported?
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: SF.net Giveback Program.
> Does SourceForge.net help you be more productive?  Does it
> help you create better code?  SHARE THE LOVE, and help us help
> YOU!  Click Here: http://sourceforge.net/donate/
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
> 
