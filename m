Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: wim delvaux <wim.delvaux@adaptiveplanet.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] panu question
References: <CF8C38B8FA1ED511A92400508BE37F0B0A961D03@exchange_corp.bhcsecurities.com>
In-Reply-To: <CF8C38B8FA1ED511A92400508BE37F0B0A961D03@exchange_corp.bhcsecurities.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200403211854.42866.wim.delvaux@adaptiveplanet.com>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sun, 21 Mar 2004 18:54:42 +0100

I would think that your w2k server does not allow the linux device to connect.  
Check if services are ON and pairing is set properly

It also just crossed my mind that the W2K detects the linux PDA not as a PDA 
but as an unrecognized device and might refuse the connection because of 
this... but I am not sure ...

W

On Sunday 21 March 2004 15:41, Rybalkin, Albert wrote:
> The NAP server is win2k box running BlueSoleil 1.4.2. PANU client is linux
> 2.4.18 with latest BlueZ kernel patches and recent userland. The client was
> trying to connect with:
>
>
>
> pand --role PANU --service NAP --connect 00:10:60:A2:CB:8E --nodetach
>
>
>
> Here's a snipset from syslog:
>
>
>
> Mar 20 22:56:26 localhost pand[10355]: PAN daemon ver 1.1
>
> Mar 20 22:56:26 localhost pand[10355]: Connecting to 00:10:60:A2:CB:8E
>
> Mar 20 22:56:34 localhost hcid[9931]: pin_code_request
> (sba=00:E0:03:7A:CA:52, dba=00:10:60:A2:CB:8E)
>
> Mar 20 22:56:34 localhost hcid[9931]: link_key_notify
> (sba=00:E0:03:7A:CA:52)
>
> Mar 20 22:56:34 localhost hcid[9931]: Replacing link key 00:E0:03:7A:CA:52
> 00:10:60:A2:CB:8E
>
> Mar 20 22:56:34 localhost pand[10355]: Connect to 00:10:60:A2:CB:8E failed.
> Connection refused(111)
>
> Mar 20 22:56:34 localhost modprobe: modprobe: Can't locate module bnep0
>
>
>
> Here's a relevant packet dump:
>
>
>
> HCIDump - HCI packet analyzer ver 1.5
>
> device: hci0 snap_len: 1028 filter: 0xffffffff
>
> 1079841480.014826 < HCI Command: Create Connection(0x01|0x0005) plen 13
>
> 1079841480.018618 > HCI Event: Command Status(0x0f) plen 4
>
> 1079841481.141376 > HCI Event: Connect Complete(0x03) plen 11
>
> 1079841481.146042 < ACL data: handle 0x0001 flags 0x02 dlen 12
>
>   L2CAP(s): Connect req: psm 15 scid 0x0040
>
> 1079841481.146135 < HCI Command: Write Link Policy Settings(0x02|0x000d)
> plen 4
>
> 1079841481.154064 > HCI Event: Max Slots Change(0x1b) plen 3
>
> 1079841481.157711 > HCI Event: Number of Completed Packets(0x13) plen 5
>
> 1079841481.159440 > HCI Event: Command Complete(0x0e) plen 6
>
> 1079841481.186978 > HCI Event: Max Slots Change(0x1b) plen 3
>
> 1079841481.190467 > ACL data: handle 0x0001 flags 0x02 dlen 16
>
>   L2CAP(s): Connect rsp: dcid 0x0044 scid 0x0040 result 1 status 1
>
> 1079841481.268379 > HCI Event: Link Key Request(0x17) plen 6
>
> 1079841481.269926 < HCI Command: Link Key Request Reply(0x01|0x000b) plen
> 22
>
>
> 1079841481.317000 > HCI Event: Command Complete(0x0e) plen 10
>
> 1079841481.374126 > ACL data: handle 0x0001 flags 0x02 dlen 16
>
>   L2CAP(s): Connect rsp: dcid 0x0044 scid 0x0040 result 1 status 2
>
> 1079841481.375454 > ACL data: handle 0x0001 flags 0x02 dlen 16
>
>   L2CAP(s): Connect rsp: dcid 0x0044 scid 0x0040 result 3 status 0
>
> 1079841483.366055 < HCI Command: Disconnect(0x01|0x0006) plen 3
>
> 1079841483.369603 > HCI Event: Command Status(0x0f) plen 4
>
> 1079841483.450023 > HCI Event: Disconn Complete(0x05) plen 4
>
>
>
> Any hints what is going wrong here?
>
>
>
> Thanks,
>
> -albertr


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
