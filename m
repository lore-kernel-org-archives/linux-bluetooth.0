Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] GPRS /  pppd problem
From: Erwin Authried <eauth@softsys.co.at>
To: "bluez-users@lists.sourceforge.net" <bluez-users@lists.sourceforge.net>
In-Reply-To: <1103323155.28046.127.camel@pegasus>
References: <1103312469.4788.15.camel@justakiss>
	 <1103323155.28046.127.camel@pegasus>
Content-Type: multipart/mixed; boundary="=-mIODeDPJWpGJ1oIKwd4c"
Message-Id: <1103555401.28429.78.camel@justakiss>
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
Date: Mon, 20 Dec 2004 16:10:01 +0100


--=-mIODeDPJWpGJ1oIKwd4c
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Am Fre, den 17.12.2004 schrieb Marcel Holtmann um 23:39:
> Hi Erwin,
> 
> > I'm using GPRS on a Ericsson T630 over bluetooth successfully. When I
> > press a key on the phone to terminate the GPRS connection, pppd doesn't
> > recognize that, however. I did a hcidump to see what happens after the
> > key has been pressed on the phone (see below). Any ideas if there's a
> > way to signal pppd that the GPRS connection has been terminated? The
> > pppd debug log doesn't show any activity in that case.
> 
> get the full dump or run it with --psm=3 to enable RFCOMM decoding.
> 
> Regards
> 
> Marcel
> 
Hi Marcel,
the dump with "hcidump --psm=3 -X" after canceling the GPRS connection
on the phone:

Regards,
Erwin


--=-mIODeDPJWpGJ1oIKwd4c
Content-Disposition: attachment; filename=dump
Content-Type: text/plain; name=dump; charset=iso-8859-1
Content-Transfer-Encoding: 7bit


> ACL data: handle 0x0029 flags 0x02 dlen 13
    L2CAP(d): cid 0x0040 len 9 [psm 3]
      RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 0 b2 0 b3 0 len 4
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(d): cid 0x0094 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 0 b2 0 b3 1 len 2
> ACL data: handle 0x0029 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 0 fcs 0x5c credits 0
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(d): cid 0x0040 len 12 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 6 fcs 0x5c credits 0
      0000: 0d 0a 4f 4b 0d 0a  

--=-mIODeDPJWpGJ1oIKwd4c--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
