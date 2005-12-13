Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] problem adding 1284 ID SDP attribute
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20051213020124.42762.qmail@web50501.mail.yahoo.com>
References: <20051213020124.42762.qmail@web50501.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1134452133.29210.3.camel@blade>
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
Date: Tue, 13 Dec 2005 06:35:33 +0100

Hi,

> I'm still having problems with the 1248 id. I already
> used the bluez-lib-2.23 function
> sdp_data_alloc_with_length for this. Im seeing nothing
> still in my 1248 id. 
> 
> Her is the hcidump:
> 
> > ACL data: handle 41 flags 0x02 dlen 17
>     L2CAP(d): cid 0x0040 len 13 [psm 1]
>         SDP SS Req: tid 0x1 len 0x8
>           pat uuid-16 0x1118
>           max 65535
>           cont 00
> < ACL data: handle 41 flags 0x02 dlen 18
>     L2CAP(d): cid 0x0072 len 14 [psm 1]
>         SDP SS Rsp: tid 0x1 len 0x9
>           count 1
>           handle 0x10001
>           cont 00
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 41 packets 1
> > ACL data: handle 41 flags 0x02 dlen 33
>     L2CAP(d): cid 0x0040 len 29 [psm 1]
>         SDP SA Req: tid 0x2 len 0x18
>           handle 0x10001
>           max 1024
>           aid(s) 0x0004 (ProtocolDescList) 0x000d
> (IconURL) 0x0350 (unknown) 0x0358 (unknown) 0x035a
> (unknown)
>           cont 00
> < ACL data: handle 41 flags 0x02 dlen 192
> < ACL data: handle 41 flags 0x01 dlen 45
>     L2CAP(d): cid 0x0072 len 233 [psm 1]
>         SDP SA Rsp: tid 0x2 len 0xe4
>           count 225
>           aid 0x0004 (ProtocolDescList)
>              < < uuid-16 0x0100 (L2CAP) > <
>              uuid-16 0x0003 (RFCOMM) uint 0x2 > <
>              uuid-16 0x0008 (OBEX) > >
>           aid 0x000d (IconURL)
>              < < uuid-16 0x0100 (L2CAP) > < uuid-16
> 0x0003 (RFCOMM) uint 0x3 > < uuid-16 0x0008 (OBEX) > >
>           aid 0x0350 (unknown)
>              str
> "application/vnd.pwg-xhtml-print+xml:0.95,application/vnd.pwg-multiplexed"
>           aid 0x0358 (unknown)
>              str ""
>           aid 0x035a (unknown)
>              str "My-Bluetooth"
>           cont 00
> _________
> As seen in the trace --  aid 0x0358 (unknown) is blank
> or data is nothing. Do you have any idea whats the
> problem? How do I solve this problem? 

I might haven't fixed the parts in hcidump to deal with binary strings.

Add the 1284 ID with your tool and then run "sdptool browse --raw local"
to see what has been added to the SDP server.

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
