Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Read out the security level from an active
	connection
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <6410.1131549190@www43.gmx.net>
References: <6410.1131549190@www43.gmx.net>
Content-Type: text/plain
Message-Id: <1131550388.5544.95.camel@blade>
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
Date: Wed, 09 Nov 2005 16:33:08 +0100

Hi Nox,

> I checked the archiv to answer my questions but unfortunally i didn't find
> anything which helps me, so please don't be irritated if tjis questions
> already was asked.
> 
> My question is regarding the Bluetooth Security Levels 1, 2 and 3.
> 
> How can I see which one is actually used by an active connection ? With
> hcidump maybe ? But what for I have to search than ?
> 
> So I want to read out the actually security level and also I want to change
> it to see how my peer device will react.

the is no difference between the security mode 1 and 2 and the presence
security mode 3 is only visible with hcidump. However don't care about
the security modes. They are an abstract definition for pairing and when
authentication/encryption should be requested.

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
