Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] SDP problem w/ WM 5 PDA BT stack
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <4B7168B4A1DDAE4C97D38B93A8450A188DD203@WEXMBGBWI001001.corp.internal.symbol.com>
References: 
	 <4B7168B4A1DDAE4C97D38B93A8450A188DD203@WEXMBGBWI001001.corp.internal.symbol.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <1136201246.22810.6.camel@localhost>
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
Date: Mon, 02 Jan 2006 12:27:26 +0100

Hi,

> We have a problem when trying to connect a certain WM 5 PDA to a Linux
> box (RedHat 9, kernel 2.4.20, properly patched) using the ad-hoc RPMs.
>=20
> This PDA uses SS1 (Stone Street 1) BT stack instead of MS=E2=80=99s.
>=20
> Linux box properly initiates all of the daemons and modules, then SP
> (Serial Port) is added (=E2=80=9Csdptool add SP=E2=80=9D), since PDA sh=
ould detect
> this service.
>
> > ACL data: handle 0x0029 flags 0x02 dlen 36
>=20
>     L2CAP(d): cid 0x40 len 32 [psm 1]
>         SDP SSA Req: tid 0x0 len 0x1b
>           pat uuid-16 0x0100 (L2CAP)
>           max 0x7e8
>           aid(s) 0x0001 (SrvClassIDList) 0x0004 (ProtocolDescList)
> 0x0009 (BTProfileDescList) 0x000d (IconURL) 0x0100 - 0xffff
>           cont 00=20

I have seen this problem before, when I helped debugging the Blooover II
application. This stack combines a list of attributes and a range of
attributes in the same request. This is valid transaction, but we simply
don't handle this correctly.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
