Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <20070430050627.1445.qmail@web37915.mail.mud.yahoo.com>
Date: Sun, 29 Apr 2007 22:06:27 -0700 (PDT)
From: Anand Karimpuzha <fanofanne@yahoo.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] Sony PS3 remote on PS3
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2071607798=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============2071607798==
Content-Type: multipart/alternative; boundary="0-1014503239-1177909587=:1049"

--0-1014503239-1177909587=:1049
Content-Type: text/plain; charset=ascii

Hi,

I have been trying to get the Sony PS3 remote working with bluetooth and evdev, and so far I have been successful in getting it paired. Unfortunately, trying to run evtest gives me the following


evtest /dev/input/event2
Input driver version is 1.0.0
Input device ID: bus 0x5 vendor 0x54c product 0x306 version 0x100
Input device name: "Sony Computer Entertainment Inc BD Remote Control"
Supported events:
  Event type 0 (Sync)
Testing ... (interrupt to exit)

hcidump -X seems to be telling me that there is something coming through 

root@garuda:/tmp# hcidump -X
HCI sniffer - Bluetooth packet analyzer ver 1.33
device: hci0 snap_len: 1028 filter: 0xffffffff
> ACL data: handle 43 flags 0x02 dlen 17
    L2CAP(d): cid 0x0041 len 13 [psm 0]
      0000: a1 01 00 00 08 0b ff ff  ff ff ff 01 05           .............
> ACL data: handle 43 flags 0x02 dlen 17
    L2CAP(d): cid 0x0041 len 13 [psm 0]
      0000: a1 01 00 00 00 ff ff ff  ff ff ff 00 05           .............
> ACL data: handle 43 flags 0x02 dlen 17
    L2CAP(d): cid 0x0041 len 13 [psm 0]
      0000: a1 01 00 00 08 0b ff ff  ff ff ff 01 05    

Can someone help me with the next steps. I tried to search for info on proceeding, but I am not able to figure this out clearly.

Thanks in advance.






__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-1014503239-1177909587=:1049
Content-Type: text/html; charset=ascii

<html><head><style type="text/css"><!-- DIV {margin:0px;} --></style></head><body><div style="font-family:times new roman, new york, times, serif;font-size:12pt"><div>Hi,<br><br>I have been trying to get the Sony PS3 remote working with bluetooth and evdev, and so far I have been successful in getting it paired. Unfortunately, trying to run evtest gives me the following<br><br><br>evtest /dev/input/event2<br>Input driver version is 1.0.0<br>Input device ID: bus 0x5 vendor 0x54c product 0x306 version 0x100<br>Input device name: "Sony Computer Entertainment Inc BD Remote Control"<br>Supported events:<br>&nbsp; Event type 0 (Sync)<br>Testing ... (interrupt to exit)<br><br>hcidump -X seems to be telling me that there is something coming through <br><br>root@garuda:/tmp# hcidump -X<br>HCI sniffer - Bluetooth packet analyzer ver 1.33<br>device: hci0 snap_len: 1028 filter: 0xffffffff<br>&gt; ACL data: handle 43 flags 0x02 dlen 17<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 13
 [psm 0]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0000: a1 01 00 00 08 0b ff ff&nbsp; ff ff ff 01 05&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .............<br>&gt; ACL data: handle 43 flags 0x02 dlen 17<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 13 [psm 0]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0000: a1 01 00 00 00 ff ff ff&nbsp; ff ff ff 00 05&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .............<br>&gt; ACL data: handle 43 flags 0x02 dlen 17<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 13 [psm 0]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0000: a1 01 00 00 08 0b ff ff&nbsp; ff ff ff 01 05&nbsp;&nbsp;&nbsp; <br><br>Can someone help me with the next steps. I tried to search for info on proceeding, but I am not able to figure this out clearly.<br><br>Thanks in advance.<br><br><br><br></div></div><br>



      <hr size=1>Ahhh...imagining that irresistible "new car" smell?<br> Check out
<a href="http://us.rd.yahoo.com/evt=48245/*http://autos.yahoo.com/new_cars.html;_ylc=X3oDMTE1YW1jcXJ2BF9TAzk3MTA3MDc2BHNlYwNtYWlsdGFncwRzbGsDbmV3LWNhcnM-">new cars at Yahoo! Autos.</a>
</body></html>
--0-1014503239-1177909587=:1049--


--===============2071607798==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============2071607798==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============2071607798==--
