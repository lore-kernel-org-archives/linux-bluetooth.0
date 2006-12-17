Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.62.0612151804360.28430@megatron.therowes.net>
References: <Pine.LNX.4.62.0612151804360.28430@megatron.therowes.net>
Date: Sun, 17 Dec 2006 13:38:53 +0100
Message-Id: <1166359133.6557.28.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Verizon vx8100 Bluetooth DUN (Dial-Up) Problem
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Mark,

> I've been (unsuccessfully) trying to get tethering to my Verizon LG vx8100 
> (version 7 firmware) working over bluetooth for dial-up to PPP since I 
> purchased the phone a couple months ago. The same chatscript works 
> correctly over a USB data cable.
> 
> I enabled the BT DUN profile for the phone and since have been able to 
> pair with it through a Airnet ABT201 BT adapter with the following OSs:
> 
> Windows XP Home (MS bluetooh drivers)
> Windows XP Home (BlueSoliel drivers)
> Debian amd64 (2.6.16.2 custom compiled kernel)
> Ubuntu Edgy Desktop (2.6.17-10-generic stock kernel, bluez-utils 3.7-1ubuntu4)
> 
> The serial profile works correctly for BitPim and I can dial out over the 
> DUN one without any problems (both OSs), but after my the PPP server 
> displays the banner and presents the username prompt, I can proceed no 
> further and the connection eventually times out. A ppp0 device does 
> breifly get created, but is never assigned any IP address. I remember 
> occasionally being able to send and have an 'm' (from my username) 
> displayed.
> 
> Trying to eliminate the different variables, I tried a different dial-up 
> service I have an account with, the #777 Verizon service, picked up a 
> D-Link DBT-120 adapter, tried Windows & tried another laptop - but had no 
> luck with any of those attempts. I've iterated through some different flow 
> control, port speed and parity combinations, but am by no means a modem 
> expert.
> 
> Eventually I ended up eBaying a holster for the phone, and got a USB data 
> cable along with it. Much to my surprise, dial-up worked correctly through 
> the cable with the same chatscript after changing just the device. DUN 
> works when paired with a co-worker's Verizon Razr, but I tried a different 
> vx8100 & saw failure the same failures as well.
> 
> After taking a look at the PPP RFC, I'm starting to think that the problem 
> is that the the initial LCP config request(s) are either not being sent or 
> aren't being answered by the PPP server - the number of LCP config 
> requests sent is always equal to the value specified for 
> 'lcp-max-configure', unless I increase it high enough to the point where 
> the remote ppp server hangs up on me.
> 
> If the requests aren't making it to the PPP server, I'm not sure where in 
> the setup the problem might be occuring (bluetooh, ppp, phone, Verizon).
> 
> I've seen multiple posts on howardforums of folks successfully using their 
> own ISP or the Verizon #777 service for dialup through BT DUN. Normally 
> just the USB cable would be sufficient, but the main reason I picked up a 
> vx8100 was to use my PDA BT connection with it so I could just take my 
> Zaurus PDA with me to a sporting event or outdoors and be able to ssh in 
> and respond to pages for work.

I really think that is has to do something with the PPP settings or the
phone is simply plain broken when using Bluetooth. I have no real clue
here. Sometimes you might have to play with some extra LCP settings for
your provider, but sometimes it is plain luck.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
