Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <BLU127-W5086F7E6B9F25F84000E5688300@phx.gbl>
References: <BLU127-W5086F7E6B9F25F84000E5688300@phx.gbl>
Date: Wed, 15 Oct 2008 17:23:34 +0200
Message-Id: <1224084214.4764.14.camel@californication>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Is "HCI_Read_Rssi" is the only option to get	RSSI
	value from "Non-discoverable" Device?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi,

>          I am trying to develop bluetooth positioning system. I am at the point of successfully getting the RSSI value using the Inquiry_result_with_rssi with no problem.
> However, as the security is concerned, I do not want leave the other Bluetooth device in discoverable mode. Therefore, sending inquiry_result_with_rssi will not work any more due to, in non-discoverable mode, the other Bluetooth will not reply to my inquiry.

the RSSI value you get from Inquiry_Result_With_RSSI and from Read_RSSI
are _not_ the same.

Regards

Marcel



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
