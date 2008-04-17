Return-Path: <cyrus@holtmann.org>
Message-Id: <6B304E64-DFCE-412F-AB4C-7D923E1606D9@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <2d5a2c100804171117r3101afddgeb31e9735f71c0b6@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Date: Thu, 17 Apr 2008 20:26:54 +0200
References: <48075B6A.2060308@access-company.com>
	<2d5a2c100804171117r3101afddgeb31e9735f71c0b6@mail.gmail.com>
Subject: Re: [Bluez-devel] [patch] BNEP/PAN Qualification issues
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

Hi Luiz,

> pand is deprecated so it should be good if you can take a look in
> network plugin and see if it surfer from the same problems.

both share the kernel layer. So we have to fix that part first.

Regards

Marcel


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
