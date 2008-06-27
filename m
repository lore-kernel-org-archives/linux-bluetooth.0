Return-Path: <cyrus@holtmann.org>
To: bluez-devel@lists.sourceforge.net
From: Jui-Hao Chiang <windtracekimo@gmail.com>
Date: Fri, 27 Jun 2008 16:02:28 +0000 (UTC)
Message-ID: <loom.20080627T154758-999@post.gmane.org>
References: <loom.20080627T113221-342@post.gmane.org>
	<1214568439.9706.8.camel@greatbear>
	<loom.20080627T135650-469@post.gmane.org>
	<1214578723.9706.19.camel@greatbear>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] =?utf-8?q?Questions_about_SCO_support_hci=5Fusb?=
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

> > But it doesn't do anything with HandsFree Profile in my cell phone.
> I read your earlier post. I am a bit confused on what are u trying to
> achieve. BlueZ only supports AG(audio Gateway) role at the moment. Also
> most phones support only AG role, so in your case which device acts as
> the Hands Free device? 

Sorry for let you misunderstand.
In my project, cell phone is used as Audio Gateway.
What I am trying to do is to run the Asterisk (Soft PBX) on my PC.
As the following scenario shows, my goal is to let each dongle to support 3
phone calls via 3 cell phones.
Soft VoIP phone -- Asterisk (PC) ----bluetooth usb dongle-- cell phone1, cell
phone 2, cell phone 3.

So, first I need to figure out how much concurrent SCO can one usb dongle
support in bluez (as you suggested the btsco. I will try it right now)
The second thing is to test the voice call via the cell phone, that's why I want
to write some short program to test 2 voice connections to 2 cell phones.

Best, 
Jui-Hao


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
