Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Nokia 7610 file transfer to computer
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1102438800.21032.3.camel@nephlim.homenet>
References: <1102381335.13235.8.camel@nephlim.homenet>
	 <1102406104.8447.15.camel@pegasus>
	 <1102438800.21032.3.camel@nephlim.homenet>
Content-Type: text/plain
Message-Id: <1102478181.8447.52.camel@pegasus>
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
Date: Wed, 08 Dec 2004 04:56:21 +0100

Hi Stefan,

> sorry for bad news...
> But your solution only fixed one problem. Now I can pair the device but
> I cannot send more than one request to the computer.
> 
> After send a file, a business card or pairing I can't send anything to
> computer until either the computer or the mobile phone is rebooted.
> 
> Is there another way to solve it?

is the ACL link still open? Check with "hcitool con". Run "hcidump -X"
as root as I told you.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
