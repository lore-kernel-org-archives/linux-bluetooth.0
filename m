Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Nokia 7610 file transfer to computer
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1102611131.7584.1.camel@nephlim.homenet>
References: <1102381335.13235.8.camel@nephlim.homenet>
	 <1102406104.8447.15.camel@pegasus>
	 <1102438800.21032.3.camel@nephlim.homenet>
	 <1102478181.8447.52.camel@pegasus>
	 <1102553068.22127.5.camel@nephlim.homenet>
	 <1102577073.9988.92.camel@pegasus>
	 <1102590679.24852.3.camel@nephlim.homenet>
	 <1102591469.9988.128.camel@pegasus>
	 <1102611131.7584.1.camel@nephlim.homenet>
Content-Type: text/plain
Message-Id: <1102620720.9988.241.camel@pegasus>
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
Date: Thu, 09 Dec 2004 20:32:00 +0100

Hi Stefan,

> > Actually I meant its chip information (use "hcitool info ..."), because
> > we need to figure out which Bluetooth chip is the bad one that makes
> > sending out the ACL data packets before the connection complete event. I
> > believe your dongle is the problematic part and if you exchange it with
> > a CSR based one all troubles will be gone.
> 
> That was it! :)

I am still interested in the "hcitool info" output.

> With a new BT dongle it now works fine! So much trouble and such a easy
> solution... :/

The more bad dongles or better Bluetooth chips/modules I see on the
market, I think we really need some qualification testing for HCI.

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
