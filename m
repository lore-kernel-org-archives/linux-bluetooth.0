Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Read out the security level from an
	active	connection
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <5902.1131607172@www66.gmx.net>
References: <1131550388.5544.95.camel@blade> <5902.1131607172@www66.gmx.net>
Content-Type: text/plain
Message-Id: <1131615893.25312.11.camel@blade>
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
Date: Thu, 10 Nov 2005 10:44:52 +0100

Hi Nox,

> thanks for the fast replay. But can you please show me how I can see if it
> is used Security level 3 in the hcidump ? Maybe you can post some line where
> I can search for ? 

if you see a pin code or a link key request before the connect complete
event, then at least one device is in security mode 3.

> And the other question is why there is no differnec between Level 1 and 2 ?
> I thought in level 2 there must be an authentication before starting an
> active communication ? maybe I am wrong ?

For devices in security mode 2, the service (profile) decides when to
requests authentication (pairing). If you have an OBEX push profile
running which normally doesn't needs authentication, then what is the
difference compared to security mode 1?

Forget about the crappy security modes, because they are useless. The
only important thing is mode 1. It says that both sides must support it
and that you must authenticate before you can start encryption.

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
