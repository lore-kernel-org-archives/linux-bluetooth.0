Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Andreas Beck <becka-bzdvl@bedatec.de>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] caching A2DP/alsa connection
Message-ID: <20050920001133.GA5818@uni-duesseldorf.de>
References: <432CE905.6050006@xmission.com> <20050918114545.GA5175@uni-duesseldorf.de> <432E0AFB.4050800@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <432E0AFB.4050800@xmission.com>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 20 Sep 2005 02:11:33 +0200

Brad Midgley <bmidgley@xmission.com> wrote:
> I want to avoid a sound server that is tied to a specific desktop. What 
> about alsa's dmix? it seems to do what we want and at a lower level 
> where it would work for everyone... 
> http://alsa.opensrc.org/index.php?page=DmixPlugin

Have you seen 
http://www.alsa-project.org/alsa-doc/doc-php/asoundrc.php?company=Generic&card=Generic&chip=Generic&module=Generic#virmulti
?

Looks like it basically _is_, what we want. However I am unable to get
the "multi"-example working. I don't quite get the syntax and am unsure 
if it will do what I am trying to accomplish.

I tried to hack it to push the same sound stream to both the
headset-device and the soundcard. However alsaplayer segfaults at
startup after some not really meaningful error messages.

Maybe you can get that working? I think I need some sleep now.

It doesn't look, if it is designed to be reconfigureable dynamically,
but I'll think about that, when I have it working statically.

Do we have a contact to the alsa developers already? Someone who can
shed some light on how it is supposed to work, and if it can be tweaked 
to serve our purposes?


CU, Andy

-- 
= Andreas Beck                    |  Email :  <becka-sig@bedatec.de>         =


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
