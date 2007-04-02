Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <46116CA8.20008@xmission.com>
Date: Mon, 02 Apr 2007 14:50:48 -0600
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <op.tp58g0h8mz9ilx@rayleigh>
In-Reply-To: <op.tp58g0h8mz9ilx@rayleigh>
Subject: Re: [Bluez-devel] Help getting Plugz going
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Jasper

> The I did see this, but it left me with a few questions that I couldnt  
> resolve:
>   "If you base your .asoundrc on the example alsa-plugins/asound.conf from  
> cvs,
>    you can edit it and add your SCO headset address. Then change the alsa d
>    evice in xmms to headset and run /usr/bin/headsetd.
>    You should be able to use the headset at this point"
> 
> I dont have the .asoundrc from cvs, just the example provided with the  
> bluetooth-alsa source,
>   and looking at the file i wasn't sure where to add the headset adress,
> also
> I started /usr/bin/headsetd but what then?

fwiw, I made some improvements and put a line in the asound.conf that 
should help you see where to put the address.

> Do i need to connect the headset with hcitool cc <addr>, i did this with  
> no success
> Is the idea that headsetd, like with hidd, connects automatically when it  
> sees the headset?
>   Sorry Ime not sure how to connect once headsetd is running.

headsetd will connect on demand when you use the audio device.

after your address is in .asoundrc, you can launch an alsa client and 
set the alsa device to "headset" and try to use it. see the build page. 
most clients don't let you easily choose this device.

> Are there any diagnostics that i can run to get an idea where the process  
> is failing?

hcidump -X -V will have a lot of output, but in the dump you'll find the 
occasional gem to figure out what is happening. I run it, try to do the 
operation that is failing, then stop the dump and examine its output.

brad

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
