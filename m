Return-Path: <steve.crane@rococosoft.com>
Subject: Re: [Bluez-devel] New Bluetooth kernel patches available
From: Stephen Crane <steve.crane@rococosoft.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1071505820.6499.80.camel@pegasus>
References: <1071505820.6499.80.camel@pegasus>
Content-Type: text/plain
Message-Id: <1071507511.26243.452.camel@baroque.rococosoft.com>
Mime-Version: 1.0
Date: 15 Dec 2003 16:58:32 +0000
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel,
2.4.18 is needed for the Sharp Zaurus (ROM 3.10) and actually using a BT
keyboard would be way cool :-)

I'd say maintain it and 2.4.23.

Regards
Steve

On Mon, 2003-12-15 at 16:30, Marcel Holtmann wrote:
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
-- 
Stephen Crane, Rococo Software Ltd. http://www.rococosoft.com
steve.crane@rococosoft.com +353-1-6601315 (ext 209)
