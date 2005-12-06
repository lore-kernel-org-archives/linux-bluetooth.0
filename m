Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20051206015531.25270.qmail@web32002.mail.mud.yahoo.com>
From: Paul Gustilo <pgustilo@yahoo.com>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20051206014920.25823.qmail@web32007.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Subject: [Bluez-users] Can not print with sony ericson via blutooth opp the second time
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
Date: Mon, 5 Dec 2005 17:55:31 -0800 (PST)



--- Paul Gustilo <pgustilo@yahoo.com> wrote:

> Hi Marcel,
> 
> 
> Im having a problem with sony ericson S700i. I can
> send a picture using opp 
> the first time but after it I can not send anymore.
> The phone is saying 
> Bluetooth busy. I believed that the connection was
> not
> freed... Im not sure 
> about it. I need some help here.
> 
> Here is some traces from HCI dump...I just cut the
> trace, I did not include 
> the trace when the the phone is sending the image, I
> guess from that point the 
> transaction is still okay...
> 
> 
> > ACL data: handle 43 flags 0x02 dlen 339
>     L2CAP(d): cid 0x0040 len 335 [psm 3]
>       RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
> 0x46 credits 0
> > ACL data: handle 43 flags 0x02 dlen 39
>     L2CAP(d): cid 0x0040 len 35 [psm 3]
>       RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
> 0x46 credits 0
> < ACL data: handle 43 flags 0x02 dlen 11
>     L2CAP(d): cid 0x004b len 7 [psm 3]
>       RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs
> 0x80
> < ACL data: handle 43 flags 0x02 dlen 9
>     L2CAP(d): cid 0x004b len 5 [psm 3]
>       RFCOMM(d): UIH: cr 0 dlci 8 pf 1 ilen 0 fcs
> 0x9c
> credits 30
> > HCI Event: Number of Completed Packets (0x13) plen
> 5
>     handle 43 packets 1
> > ACL data: handle 43 flags 0x02 dlen 339
>     L2CAP(d): cid 0x0040 len 335 [psm 3]
>       RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
> 0x46 credits 0
> > ACL data: handle 43 flags 0x02 dlen 339
>     L2CAP(d): cid 0x0040 len 335 [psm 3]
>       RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
> 0x46 credits 0
> > ACL data: handle 43 flags 0x02 dlen 39
>     L2CAP(d): cid 0x0040 len 35 [psm 3]
>       RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
> 0x46 credits 0
> < ACL data: handle 43 flags 0x02 dlen 11
>     L2CAP(d): cid 0x004b len 7 [psm 3]
>       RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs
> 0x80
> > HCI Event: Number of Completed Packets (0x13) plen
> 5
>     handle 43 packets 1
> > ACL data: handle 43 flags 0x02 dlen 39
>     L2CAP(d): cid 0x0040 len 35 [psm 3]
>       RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
> 0x46 credits 0
> > ACL data: handle 43 flags 0x02 dlen 339
>     L2CAP(d): cid 0x0040 len 335 [psm 3]
>       RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
> 0x46 credits 1
> > ACL data: handle 43 flags 0x02 dlen 39
>     L2CAP(d): cid 0x0040 len 35 [psm 3]
>       RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
> 0x46 credits 0
> > ACL data: handle 43 flags 0x02 dlen 339
>     L2CAP(d): cid 0x0040 len 335 [psm 3]
>       RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
> 0x46 credits 1
> > ACL data: handle 43 flags 0x02 dlen 339
>     L2CAP(d): cid 0x0040 len 335 [psm 3]
>       RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
> 0x46 credits 0
> > ACL data: handle 43 flags 0x02 dlen 339
>     L2CAP(d): cid 0x0040 len 335 [psm 3]
>       RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
> 0x46 credits 0
> > ACL data: handle 43 flags 0x02 dlen 39
>     L2CAP(d): cid 0x0040 len 35 [psm 3]
>       RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
> 0x46 credits 0
> < ACL data: handle 43 flags 0x02 dlen 9
>     L2CAP(d): cid 0x004b len 5 [psm 3]
>       RFCOMM(d): UIH: cr 0 dlci 8 pf 1 ilen 0 fcs
> 0x9c
> credits 30
> > ACL data: handle 43 flags 0x02 dlen 339
>     L2CAP(d): cid 0x0040 len 335 [psm 3]
>       RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
> 0x46 credits 1
> > ACL data: handle 43 flags 0x02 dlen 339
>     L2CAP(d): cid 0x0040 len 335 [psm 3]
>       RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
> 0x46 credits 0
> > ACL data: handle 43 flags 0x02 dlen 339
>     L2CAP(d): cid 0x0040 len 335 [psm 3]
>       RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
> 0x46 credits 0
> > ACL data: handle 43 flags 0x02 dlen 39
>     L2CAP(d): cid 0x0040 len 35 [psm 3]
>       RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
> 0x46 credits 0
> < ACL data: handle 43 flags 0x02 dlen 11
>     L2CAP(d): cid 0x004b len 7 [psm 3]
>       RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs
> 0x80
> > ACL data: handle 43 flags 0x02 dlen 39
>     L2CAP(d): cid 0x0040 len 35 [psm 3]
>       RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
> 0x46 credits 0
> > ACL data: handle 43 flags 0x02 dlen 339
>     L2CAP(d): cid 0x0040 len 335 [psm 3]
>       RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
> 0x46 credits 1
> > ACL data: handle 43 flags 0x02 dlen 339
>     L2CAP(d): cid 0x0040 len 335 [psm 3]
>       RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
> 0x46 credits 0
> > ACL data: handle 43 flags 0x02 dlen 339
>     L2CAP(d): cid 0x0040 len 335 [psm 3]
>       RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
> 0x46 credits 0
> > ACL data: handle 43 flags 0x02 dlen 39
>     L2CAP(d): cid 0x0040 len 35 [psm 3]
>       RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
> 0x46 credits 0
> > HCI Event: Number of Completed Packets (0x13) plen
> 5
>     handle 43 packets 1
> > ACL data: handle 43 flags 0x02 dlen 339
>     L2CAP(d): cid 0x0040 len 335 [psm 3]
>       RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
> 0x46 credits 1
> > ACL data: handle 43 flags 0x02 dlen 39
>     L2CAP(d): cid 0x0040 len 35 [psm 3]
>       RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
> 0x46 credits 0
> > ACL data: handle 43 flags 0x02 dlen 339
>     L2CAP(d): cid 0x0040 len 335 [psm 3]
>       RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
> 0x46 credits 1
> < ACL data: handle 43 flags 0x02 dlen 9
>     L2CAP(d): cid 0x004b len 5 [psm 3]
>       RFCOMM(d): UIH: cr 0 dlci 8 pf 1 ilen 0 fcs
> 0x9c
> credits 30
> > ACL data: handle 43 flags 0x02 dlen 339
>     L2CAP(d): cid 0x0040 len 335 [psm 3]
>       RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
> 0x46 credits 0
> > ACL data: handle 43 flags 0x02 dlen 339
>     L2CAP(d): cid 0x0040 len 335 [psm 3]
>       RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
> 0x46 credits 1
> > ACL data: handle 43 flags 0x02 dlen 339
>     L2CAP(d): cid 0x0040 len 335 [psm 3]
>       RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
> 0x46 credits 0
> > ACL data: handle 43 flags 0x02 dlen 339
>     L2CAP(d): cid 0x0040 len 335 [psm 3]
>       RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
> 0x46 credits 1
> > ACL data: handle 43 flags 0x02 dlen 339
>     L2CAP(d): cid 0x0040 len 335 [psm 3]
>       RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
> 0x46 credits 0
> > ACL data: handle 43 flags 0x02 dlen 39
>     L2CAP(d): cid 0x0040 len 35 [psm 3]
>       RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
> 0x46 credits 0
> > ACL data: handle 43 flags 0x02 dlen 339
>     L2CAP(d): cid 0x0040 len 335 [psm 3]
>       RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
> 0x46 credits 1
> > ACL data: handle 43 flags 0x02 dlen 339
>     L2CAP(d): cid 0x0040 len 335 [psm 3]
>       RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
> 0x46 credits 0
> > ACL data: handle 43 flags 0x02 dlen 39
>     L2CAP(d): cid 0x0040 len 35 [psm 3]
>       RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
> 0x46 credits 0
> < ACL data: handle 43 flags 0x02 dlen 11
>     L2CAP(d): cid 0x004b len 7 [psm 3]
>       RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs
> 0x80
> > ACL data: handle 43 flags 0x02 dlen 339
>     L2CAP(d): cid 0x0040 len 335 [psm 3]
>       RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
> 0x46 credits 0
> > ACL data: handle 43 flags 0x02 dlen 39
>     L2CAP(d): cid 0x0040 len 35 [psm 3]
>       RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
> 0x46 credits 0
> > ACL data: handle 43 flags 0x02 dlen 339
>     L2CAP(d): cid 0x0040 len 335 [psm 3]
> 
=== message truncated ===



		
__________________________________________ 
Yahoo! DSL – Something to write home about. 
Just $16.99/mo. or less. 
dsl.yahoo.com 



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
