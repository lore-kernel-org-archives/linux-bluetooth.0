Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Multi-Thread Problem with BlueZ
From: Marcel Holtmann <marcel@holtmann.org>
To: Dave Dev <alwaysgone@seznam.cz>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <44283.131711-31853-1185610467-1091794793@email.seznam.cz>
References: <44283.131711-31853-1185610467-1091794793@email.seznam.cz>
Content-Type: text/plain
Message-Id: <1091796874.20839.107.camel@pegasus>
Mime-Version: 1.0
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
Date: Fri, 06 Aug 2004 14:54:34 +0200

Hi Dave,

> < What kind of USB Bluetooth dongles did you tried? Actually a CSR based
> < with at least HCI 16.4 or HCI 16.14 firmware should work fine. This is
> < not about the RFCOMM connections. This is about the ACL links and the
> < problems with scatternets. Check with "hcitool info" the features of
> < your mobile phones. If they don't support hold or rswitch that can be of
> < course troubles.
> 
> We used first the TDK USB BT -- upgraded firmware to 16.4 ... things improved, but still didn't work.  Now have one of those i-tecs that we sent to you and some older Epox -- I guess we need to get some new TDKs (they're deployed in a live environment now) ... any other USB devices work well and let you upgrade firmware?  Most other USB dongles suck....

I can't think of any disadvantage with the BlueCore01b based TDK dongle,
but maybe there are some. The Anycom USB-100 is BC02 based and there
exists an update to HCI 16.14. I haven't checked the differences between
these two firmware version, but as I know they are the only two official
releases from the HCI 16.x branch.

The Broadcom based dongles were always problematic if it comes to
scatternet and role switch support. Don't even try to get there any
further unless you have a protocol analyser at hand and a good contact
to Broadcom.

The D-Link DBT-120 Rev. B3 can be updated with the firmware file from
Apple to HCI 18.1 which then is also Bluetooth 1.2 capable. However I
think the latest official firmware release from CSR is HCI 18.2, but
actually I haven't seen any dongles so far.

> Will let you know the results ... thanks -- if we can get this working on your advice, you'll get some Czech beer ;-)

:)

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
