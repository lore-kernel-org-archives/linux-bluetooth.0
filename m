Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Has anyone seen these problems with the CSR
	BlueCore and BlueZ before ?
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <4239B037.4020803@csr.com>
References: <E1DBv62-0004qg-Ld@sc8-sf-mx1.sourceforge.net>
	 <4239B037.4020803@csr.com>
Content-Type: text/plain
Message-Id: <1111078208.9741.2.camel@pegasus>
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
Date: Thu, 17 Mar 2005 17:50:08 +0100

Hi Steven,

> would it be a good idea to add reading of the panic and
> fault codes to the CSR specific section of hcitool revision? Or,
> get BlueZ to read the panic code when the inerface is brought up. If
> it's non-zero and < 0x0100 write it to an event log and then zero it.

the kernel code should be complete vendor independent and thus adding
this to "hciconfig hci0 revsion" is the only option.

Are both variables UINT16? If yes, then it will be quite easy to add
this information to the hciconfig command. What document should I read
for more information about the panic/fault code meanings?

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
