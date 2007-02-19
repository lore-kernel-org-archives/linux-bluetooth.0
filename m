Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <77958D3F4480D34A99F9D8759B56D550453ACB@deblnrd04msx.sielearn.net>
References: <77958D3F4480D34A99F9D8759B56D550453ACB@deblnrd04msx.sielearn.net>
Date: Mon, 19 Feb 2007 11:19:19 +0100
Message-Id: <1171880359.26567.12.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Bluetooth passkey and encryption
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

Hi Marco,

> I checked with hcidump and received the following message:
> 
> > HCI Event: PIN Code Request (0x16) plen 6
>     bdaddr 00:11:B1:A1:68:2B
> < HCI Command: PIN Code Request Negative Reply (0x01|0x000e) plen 6
>     bdaddr 00:11:B1:A1:68:2B
> > HCI Event: Command Complete (0x0e) plen 10
>     PIN Code Request Negative Reply (0x01|0x000e) ncmd 1
>     status 0x06 bdaddr 00:11:B1:A1:68:2B
>     Error: PIN or Key Missing
> > HCI Event: Connect Complete (0x03) plen 11
>     status 0x06 handle 7 bdaddr 00:11:B1:A1:68:2B type ACL encrypt 0x00
>     Error: PIN or Key Missing 
> 
> I set a key under the option passkey in the hcid.conf. So if that key is
> not used, where would I have to set this key?

the passkey option is only used on incoming connection and only if
security auto has been selected. For all the rest you have to run a
passkey agent. Check the mailing list archives for details.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
