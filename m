Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Tue, 03 Apr 2007 07:30:26 +1200
To: bluez-devel <bluez-devel@lists.sourceforge.net>
From: "Jasper Mackenzie" <jasper@treshna.com>
MIME-Version: 1.0
Message-ID: <op.tp58g0h8mz9ilx@rayleigh>
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


Cheers Brad,
> it sounds like you didn't see this one
> http://bluetooth-alsa.sourceforge.net/build.html

The I did see this, but it left me with a few questions that I couldnt  
resolve:
  "If you base your .asoundrc on the example alsa-plugins/asound.conf from  
cvs,
   you can edit it and add your SCO headset address. Then change the alsa d
   evice in xmms to headset and run /usr/bin/headsetd.
   You should be able to use the headset at this point"

I dont have the .asoundrc from cvs, just the example provided with the  
bluetooth-alsa source,
  and looking at the file i wasn't sure where to add the headset adress,
also
I started /usr/bin/headsetd but what then?
Do i need to connect the headset with hcitool cc <addr>, i did this with  
no success
Is the idea that headsetd, like with hidd, connects automatically when it  
sees the headset?
  Sorry Ime not sure how to connect once headsetd is running.

Are there any diagnostics that i can run to get an idea where the process  
is failing?

> also, the sco flowcontrol patch should be applied even if you are using
the btsco method.

I did, it didnt make too much difference.

Thank you.

Jasper

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
