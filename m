Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <42E61FB0.1090902@csr.com>
From: Steven Singer <steven.singer@csr.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] How can I set CSR module as PCM master?
References: 
    <Pine.LNX.4.33.0507261224230.7555-100000@redbean.intranet.gw-instruments.de>
In-Reply-To: 
    <Pine.LNX.4.33.0507261224230.7555-100000@redbean.intranet.gw-instruments.de>
Content-Type: text/plain; charset=UTF-8
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
Date: Tue, 26 Jul 2005 12:34:08 +0100

Peter Wippich wrote:
> you have to set PSKEY PCM_CONFIG32. It is described in the CSR data
> sheets.

And the default is PCM master.

In fact, the default PS key settings are for a Motorola MC145483 codec -
precisely the code you're using - as that's what we use on the Casira
motherboards. You shouldn't need to change any of the detailed settings.

> On Tue, 26 Jul 2005, 宁 宁 wrote:
>> $ pskey -i hci0 mapsco 0
>> $ hciconfig hci0 revision
>> hci0:   Type: UART
>>         BD Address: 4A:49:4E:00:15:2F ACL MTU: 384:4
>> SCO                          MTU: 64:8
>>         Build 705
>>         Chip version: BlueCore02-External
>>         Max key size: 56 bit
>>         SCO mapping:  HCI

Surely you want SCO mapping: PCM. I'm guessing that means using pskey
to set mapsco 1 (strictly, you want to set PSKEY_HOSTIO_MAP_SCO_PCM to
1) and rebooting (PS key changes take effect only at reboot).

These sorts of detailed technical questions about CSR products
specifically might be best asked on our technical newsgroups at
news.csr.com. See http://www.csr.com/forum.htm for details.

	- Steven
-- 


**********************************************************************
This email and any files transmitted with it are confidential and
intended solely for the use of the individual or entity to whom they
are addressed. If you have received this email in error please notify
the system manager.

**********************************************************************



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
