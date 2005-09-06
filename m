Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] I have a question about the bdaddr utility
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <431DC228.7030309@infomatrix.com>
References: <431DC228.7030309@infomatrix.com>
Content-Type: text/plain
Message-Id: <1126026222.4645.53.camel@blade>
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
Date: Tue, 06 Sep 2005 19:03:42 +0200

Hi Ben,

> Maybe this should be directed at bluez-devel, but I'll ask anyway.
> I have a question about the bdaddr utility, with reference to a CSR 
> chipset, connected via internal USB on a Sony Vaio
> According to the list, this utility is able to change the bluetooth 
> address of a particular device.
> 
> My question is, is this change permanently written to the chip, or is it 
> merely a volatile change as far as the running kernel is concerned?

the change is permanent.

> The reason I ask is that I am having trouble with dual-booting between 
> Windows XP and Linux. I have to repair each time I swap operating 
> systems and it is a pain.

Once you paired with Linux you can store the link key on the Bluetooth
chip and you don't need to repair with Windows. Check the hciconfig for
the correct command.

Regards

Marcel




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
