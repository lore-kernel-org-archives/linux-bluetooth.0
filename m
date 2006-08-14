Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <44E0F288.2000107@pracucci.com>
Date: Mon, 14 Aug 2006 22:00:40 +0000
From: Marco Pracucci <development@pracucci.com>
MIME-Version: 1.0
To: Bluez Development ML <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] hcidump-1.30 segmentation fault
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi all,

I get a segmentation fault when I dump an OBEX connection with hcidump
1.30 (I have not tried with 1.31). I have compiled hcidump with
--enable-debug and debugged it with gdb. I have got the following backtrace:

2006-08-14 21:59:11.118487 > ACL data: handle 8 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 6 pf 1 ilen 3 fcs 0x49 credits 2
        OBEX: Connect rsp(f): status 100 len 3 version 11.7 flags 136
mtu 18681
        Status 100 = Continue

(gdb) bt
#0  parse_headers (level=3, frm=0x8066e78) at parser.h:157
#1  0x080562f4 in obex_dump (level=3, frm=0x8066e78) at obex.c:323
#2  0x08052d83 in rfcomm_dump (level=2, frm=0xbf85ae50) at rfcomm.c:325
#3  0x08049285 in process_frames (dev=0, sock=6, fd=-1, flags=4864) at
parser.h:245
#4  0x0804a565 in main (argc=-1, argv=0xbf85af9c) at hcidump.c:850

The problem seems to be in obex_dump() function at row 273:

case 0x00:    /* Connect */
            version = get_u8(frm);
            flags   = get_u8(frm);
            pktlen  = get_u16(frm);
            printf(" version %d.%d flags %d mtu %d\n",
                version >> 4, version & 0xf, flags, pktlen);
            break;

Before to enter the "case" above, frm->len is set to 0... so, get_u*
calls decrease the frm->len to 4294967292 and the next call to
parse_headers() fails.


Regards,
Marco pracucci


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
