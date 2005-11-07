Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Periodic noise on microphone with bt_sco
	(BTA-6030 Dongle, Motorola H500 Headset)
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <436F6FEA.4030207@csr.com>
References: <436F1C3B.5020002@web.de> <436F4D85.4030404@csr.com>
	 <436F5602.1040105@web.de> <436F5B5C.7070506@csr.com>
	 <436F608D.4020407@web.de>  <436F6FEA.4030207@csr.com>
Content-Type: text/plain
Message-Id: <1131376874.5824.127.camel@blade>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 07 Nov 2005 16:21:14 +0100

Hi Steven,

> > When I record "silence" from the microphone (as silent as possible) then
> > there is clearly the noise with about -40db power.
> > Is there a way to record the digital from the headset directly, before
> > it is processed in alsa? Similar to the way hcidump works, maybe?
> 
> In theory, if you use hcidump and extract all the SCO data, you should
> just have raw samples which you can stitch together into a file.
> 
> You should be able to see the two directions independently and see
> where the noise is being introduced.
> 
> I don't know if there's a speific tool, but use hcidump -w to make a
> raw log and then use hcidump -x -r to read the log back later. A little
> bit of perl and a pass through sox should get the data into a playable
> format.

I never fully tested it, but you can extract the SCO stream with -A in
the latest hcidump version. It was one of my fast and ugly hacks for
some security auditing of headsets at the last UnPlugFest, but we never
actually came around in using it seriously.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
