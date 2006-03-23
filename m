Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4422DA1E.6030303@runbox.com>
From: Tom K <tomk@runbox.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] btsco not working with 3Com 3CREB96 and SE HBH-602
References: <4422851C.6020900@runbox.com> <Pine.LNX.4.61.0603231619010.25910@cherokee.spacecom.si>
In-Reply-To: <Pine.LNX.4.61.0603231619010.25910@cherokee.spacecom.si>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 23 Mar 2006 17:25:50 +0000

Mitja Pufic wrote:
> Hello,
>
> This is a very old dongle, with bluecore01 and confirms with bluetooth 
> 1.0b specification. And as far as I know it has SCO mapped to PCM and not 
> HCI, so this is the reason, why your setup is not working. Check mail 
> list archive how to change this, or if it is even possible on this old 
> chip. PCMCIA version does not have this problem.
>
>   
Many thanks for your response.
It's pretty old alright, but hciconfig hci0 revision gives me

hci0:   Type: USB
        BD Address: 00:04:76:AD:12:E3 ACL MTU: 128:8 SCO MTU: 64:8
        HCI 10.3
        Chip version: BlueCore01b (ES)
        SCO mapping:  HCI

which looked promising to me. Still, if it's not the right stuff, I'll 
hunt around for another one.


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
