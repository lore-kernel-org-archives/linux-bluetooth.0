Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Robert Siemer <Robert.Siemer@backsla.sh>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Re: Jumpy cursor with Wacom Graphire Bluetooth
Message-ID: <20051127231320.GH15156@polar.elf12.net>
References: <20051008132533.GA954@polar.elf12.net> <20051127174209.GB15156@polar.elf12.net> <1133115990.13629.1.camel@blade> <20051127184902.GD15156@polar.elf12.net> <1133119580.13629.13.camel@blade> <20051127213835.GF15156@polar.elf12.net> <1133128569.13629.28.camel@blade> <20051127230444.GG15156@polar.elf12.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20051127230444.GG15156@polar.elf12.net>
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
Date: Mon, 28 Nov 2005 00:13:20 +0100

Re!

>  panorama:/etc/udev# sdptool browse --raw 00:13:C2:00:11:2C

(which shows nothing)

I have an hcidump for that example:

panorama:/home/siemer# hcidump  -X -V
HCI sniffer - Bluetooth packet analyzer ver 1.23
device: hci0 snap_len: 1028 filter: 0xffffffff
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0042
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0044 scid 0x0042 result 1 status 2
      Connection pending - Authorization pending
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0044 scid 0x0042 result 0 status 0
      Connection successful
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0044 flags 0x00 clen 0
> HCI Event: Mode Change (0x14) plen 6
    status 0x00 handle 42 mode 0x00 interval 0
    Mode: Active
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> HCI Event: Mode Change (0x14) plen 6
    status 0x00 handle 42 mode 0x02 interval 16
    Mode: Sniff
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0042 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0042 flags 0x00 clen 4
      MTU 48 
< ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0044 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 42 flags 0x02 dlen 24
    L2CAP(d): cid 0x0044 len 20 [psm 1]
        SDP SSA Req: tid 0x0 len 0xf
          pat uuid-16 0x1002 (PubBrwsGrp)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(d): cid 0x0042 len 10 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x5
          count 2
          cont 00
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0044 scid 0x0042
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0044 scid 0x0042




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
