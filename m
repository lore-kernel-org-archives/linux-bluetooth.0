Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] DBT-120 firmware upgrade
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <41AB1AF5.3030901@csr.com>
References: <200411261152.29925.pavouk@pavouk.org>
	 <200411271655.27322.pavouk@pavouk.org> <1101579731.27074.8.camel@pegasus>
	 <200411272130.44783.pavouk@pavouk.org> <1101588637.27074.22.camel@pegasus>
	 <41AB14DD.3010807@csr.com> <1101731638.10115.0.camel@pegasus>
	  <41AB1AF5.3030901@csr.com>
Content-Type: text/plain
Message-Id: <1101749410.7562.21.camel@pegasus>
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
Date: Mon, 29 Nov 2004 18:30:10 +0100

Hi Steven,

> > do you have the full build information for my web page?
> 
> Oops, I should have enclosed that:
> 
>   0x632 1586 bc02x_8unified_fl_bt1.2_18_0408131143_encr128 2004-08-13

thanks for this one, but actually I have another one:

# hciconfig hci0 revision
hci0:   Type: USB
        BD Address: 00:C0:DF:xx:xx:xx ACL MTU: 192:8  SCO MTU: 64:8
        Build 1354
        Chip version: BlueCore02
        Max key size: 56 bit
        SCO mapping:  HCI

I assume that this is also a HCI 18.2, right?

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
