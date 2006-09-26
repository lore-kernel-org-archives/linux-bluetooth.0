Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <45198F20.6040504@ibdcon.org.br>
Date: Tue, 26 Sep 2006 17:35:44 -0300
From: Paulo Wollny <paulo.wollny@ibdcon.org.br>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <45198820.8060701@ibdcon.org.br>
	<1159301349.800.26.camel@localhost>
In-Reply-To: <1159301349.800.26.camel@localhost>
Subject: Re: [Bluez-users] bluez-utils 3.5 and pairing
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Marcel,
the output states as follow:

HCI sniffer - Bluetooth packet analyzer ver 1.32
device: hci0 snap_len: 1028 filter: 0xffffffff
> HCI Event: Connect Request (0x04) plen 10
    bdaddr 00:05:16:5B:17:2C class 0x120110 type ACL
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
    bdaddr 00:05:16:5B:17:2C role 0x01
    Role: Slave
> HCI Event: Command Status (0x0f) plen 4
    Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
> HCI Event: PIN Code Request (0x16) plen 6
    bdaddr 00:05:16:5B:17:2C
< HCI Command: PIN Code Request Reply (0x01|0x000d) plen 23
    bdaddr 00:05:16:5B:17:2C len 5 pin 'BlueZ'
> HCI Event: Command Complete (0x0e) plen 10
    PIN Code Request Reply (0x01|0x000d) ncmd 1
    status 0x00 bdaddr 00:05:16:5B:17:2C
> HCI Event: Connect Complete (0x03) plen 11
    status 0x05 handle 41 bdaddr 00:05:16:5B:17:2C type ACL encrypt 0x00
    Error: Authentication Failure

Regards,

Paulo

Marcel Holtmann schrieb:
> Hi Paulo,
>
>   
>> i'm using Bluez Utils 3.5 and am having problems when trying to pair my
>> PDA.
>> I did fire passkey-agent --default XXXX and the PDA is not being able to
>> pair.
>>     
>
> show us the output of "hcidump -X -V" for this transaction.
>
> Regards
>
> Marcel
>
>
>
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys -- and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>
>
>   


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
