Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] a2dp alsa-lib plugin
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <43378A70.3000005@xmission.com>
References: <43378A70.3000005@xmission.com>
Content-Type: text/plain
Message-Id: <1127726423.6163.12.camel@localhost.localdomain>
Mime-Version: 1.0
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
Date: Mon, 26 Sep 2005 11:20:23 +0200

Hi Brad,

> I have been looking at the plugin in bluez-utils cvs. Is it working for 
> you over rfcomm? (I don't have a headset that supports the rfcomm sbc 
> stream any more...)

this is only, because I was too lazy to cleanup the AVDTP code and
finally commit it.

> Do you want to keep rfcomm transport as an option?

It is an option, but I think it is not really needed. However it is good
for testing some stuff.

> Sadly, it looks like the dmix plugin won't give multiple apps access to 
> a plugin. The fact that it uses IPC was encouraging, so maybe it will 
> work some day.

I haven't looked at the ALSA part for some time now. So I have no clue.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
