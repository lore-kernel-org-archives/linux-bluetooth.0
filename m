Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <402E014C.807@handgranat.org>
From: Sunnan <sunnan@handgranat.org>
MIME-Version: 1.0
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] apple wireless mouse on apple ibook (g4, builtin
 usb)
References: <402D07B8.8030504@handgranat.org>	 <1076694675.2671.191.camel@pegasus>  <402D1E8C.6020301@handgranat.org>	 <1076702197.18588.11.camel@pegasus>  <402D381D.1000306@handgranat.org>	 <1076709007.18588.39.camel@pegasus>  <402D4959.10704@handgranat.org>	 <1076711341.18588.57.camel@pegasus>  <402D5592.3060907@handgranat.org>	 <1076714464.18588.95.camel@pegasus>  <402D5EB0.3090601@handgranat.org> <1076720052.18588.147.camel@pegasus>
In-Reply-To: <1076720052.18588.147.camel@pegasus>
Content-Type: multipart/mixed;
 boundary="------------060700080105090105040506"
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sat, 14 Feb 2004 12:06:52 +0100

This is a multi-part message in MIME format.
--------------060700080105090105040506
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Marcel Holtmann wrote:
> is the script executable? Do you restarted hcid?

slowstorm/home/sunnan% pin-helper.sh
PIN:0000
slowstorm/home/sunnan% ps aux|grep hcid
root      1668  0.0  0.2  1708  628 ?        S    Feb13   0:00 hcid: 
processing events
root      3763  0.0  0.1  1724  456 pts/3    S    11:51   0:00 hcidump 
-w thirddata
sunnan    3957  0.0  0.2  1656  528 pts/5    R    11:57   0:00 grep hcid
slowstorm/home/sunnan%

And yeah, I've restarted it, both from the /etc/init.d/ scripts and also 
rebooted.

> We really need a full binary hcidump to see what is going on.

I've sent several to the list but I'm unsure of how large they are 
supposed to get before I C-c. I'm attaching one larger now (still only 4 
k... they just don't get very large.). (Are my attachment's getting 
through? Maybe they are stripped somewhere.)

There's been some progress since the last mail. I've run "hcitool scan" 
a couple of times, and _one_ of the times it showed:
slowstorm/home/sunnan% hcitool scan
Scanning ...
         00:0A:95:01:5F:57       sunnan???s mouse

Argh! Why did I give it a name with an apostrophe! Oh, Mac OS, thou 
tempted me to many strange filenames, some even including spaces!
(Note the hexadecimal device number is different from my local device, 
which is 00:0D:93:04:19:15.)

All the other times it just exited after writing "Scanning ...". I've 
been unable to find it again.

As usual, bthid is just quitting after a while without saying so in 
/var/log/daemon.log.

--------------060700080105090105040506
Content-Type: application/octet-stream;
 name="thirddata"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="thirddata"

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
BAQAAQBY/y1AavENAAQBAQA=
--------------060700080105090105040506--


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
