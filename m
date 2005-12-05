Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20051205103257.18037.qmail@web32409.mail.mud.yahoo.com>
From: Arch Sayo <a12chi@yahoo.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1000886356-1133778777=:18014"
Subject: [Bluez-users] RFCOMM disconnect command from slave device
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
Date: Mon, 5 Dec 2005 02:32:57 -0800 (PST)

--0-1000886356-1133778777=:18014
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi Marcel,
   
  I would like to ask if it is okay for a slave device to be the first to issue a disconnect command in the RFCOMM layer rather than the master device. Usually, after the OBEX Disconnect request of the master device and the corresponding response of the slave device, the master issues a disconnect command in the RFCOMM layer. However, the slave device (running on BlueZ) is the first one to issue a disconnect command in the RFCOMM layer, and the master device issues a disconnect command (RFCOMM) after that of the slave device. Is this okay?
   
  Trace for this kind of transaction is as follows:
  > ACL data: handle 41 flags 0x02 dlen 17
      L2CAP(d): cid 0x0040 len 13 [psm 3]
        RFCOMM(d): UIH: cr 1 dlci 10 pf 1 ilen 8 fcs 0xac credits 1
          OBEX: Disconnect cmd(f): len 8
          Connection ID (0xcb) = 0
  < ACL data: handle 41 flags 0x02 dlen 11
      L2CAP(d): cid 0x0041 len 7 [psm 3]
        RFCOMM(d): UIH: cr 0 dlci 10 pf 0 ilen 3 fcs 0x6a
          OBEX: Disconnect rsp(f): status 200 len 3
          Status 200 = Success
  < ACL data: handle 41 flags 0x02 dlen 8
      L2CAP(d): cid 0x0041 len 4 [psm 3]
        RFCOMM(s): DISC: cr 0 dlci 10 pf 1 ilen 0 fcs 0xc
  > HCI Event: Number of Completed Packets (0x13) plen 5
      handle 41 packets 1
  > HCI Event: Number of Completed Packets (0x13) plen 5
      handle 41 packets 1
  > ACL data: handle 41 flags 0x02 dlen 8
      L2CAP(d): cid 0x0040 len 4 [psm 3]
        RFCOMM(s): DISC: cr 1 dlci 10 pf 1 ilen 0 fcs 0x6d
  < ACL data: handle 41 flags 0x02 dlen 8
      L2CAP(d): cid 0x0041 len 4 [psm 3]
        RFCOMM(s): UA: cr 1 dlci 10 pf 1 ilen 0 fcs 0x47
  > ACL data: handle 41 flags 0x02 dlen 8
      L2CAP(d): cid 0x0040 len 4 [psm 3]
        RFCOMM(s): DM: cr 0 dlci 10 pf 1 ilen 0 fcs 0xc7
  > HCI Event: Number of Completed Packets (0x13) plen 5
      handle 41 packets 1
  > ACL data: handle 41 flags 0x02 dlen 8
      L2CAP(d): cid 0x0040 len 4 [psm 3]
        RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd
  < ACL data: handle 41 flags 0x02 dlen 8
      L2CAP(d): cid 0x0041 len 4 [psm 3]
        RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
   
  Thanks so much,
  Arch

		
---------------------------------
 Yahoo! DSL Something to write home about. Just $16.99/mo. or less
--0-1000886356-1133778777=:18014
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<DIV>Hi Marcel,</DIV>  <DIV>&nbsp;</DIV>  <DIV>I would like to ask if it is okay for a slave device to be the first to issue a disconnect command in the RFCOMM layer rather than the master device. Usually, after the OBEX Disconnect request of the master device and the corresponding response of the slave device, the master issues a disconnect command in the RFCOMM layer. However,&nbsp;the slave device (running on BlueZ) is the first one to issue a disconnect command in the RFCOMM layer, and the master device issues a disconnect command (RFCOMM) after that of the slave device. Is this okay?</DIV>  <DIV>&nbsp;</DIV>  <DIV>Trace for this kind of transaction is as follows:</DIV>  <DIV class=MsoNormal style="MARGIN: 0in 0in 0pt"><FONT face="Times New Roman" size=3>&gt; ACL data: handle 41 flags 0x02 dlen 17</FONT></DIV>  <DIV class=MsoNormal style="MARGIN: 0in 0in 0pt"><FONT size=3><FONT face="Times New Roman"><SPAN style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp; </SPAN>L2CAP(d): cid 
 0x0040
 len 13 [psm 3]</FONT></FONT></DIV>  <DIV class=MsoNormal style="MARGIN: 0in 0in 0pt"><FONT size=3><FONT face="Times New Roman"><SPAN style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>RFCOMM(d): UIH: cr 1 dlci 10 pf 1 ilen 8 fcs 0xac credits 1</FONT></FONT></DIV>  <DIV class=MsoNormal style="MARGIN: 0in 0in 0pt"><FONT size=3><FONT face="Times New Roman"><SPAN style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>OBEX: Disconnect cmd(f): len 8</FONT></FONT></DIV>  <DIV class=MsoNormal style="MARGIN: 0in 0in 0pt"><FONT size=3><FONT face="Times New Roman"><SPAN style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>Connection ID (0xcb) = 0</FONT></FONT></DIV>  <DIV class=MsoNormal style="MARGIN: 0in 0in 0pt"><FONT face="Times New Roman" size=3>&lt; ACL data: handle 41 flags 0x02 dlen 11</FONT></DIV>  <DIV class=MsoNormal style="MARGIN: 0in 0in 0pt"><FONT size=3><FONT face="Times New Roman"><SPAN style="mso-spacerun:
 yes">&nbsp;&nbsp;&nbsp; </SPAN>L2CAP(d): cid 0x0041 len 7 [psm 3]</FONT></FONT></DIV>  <DIV class=MsoNormal style="MARGIN: 0in 0in 0pt"><FONT size=3><FONT face="Times New Roman"><SPAN style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>RFCOMM(d): UIH: cr 0 dlci 10 pf 0 ilen 3 fcs 0x6a</FONT></FONT></DIV>  <DIV class=MsoNormal style="MARGIN: 0in 0in 0pt"><FONT size=3><FONT face="Times New Roman"><SPAN style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>OBEX: Disconnect rsp(f): status 200 len 3</FONT></FONT></DIV>  <DIV class=MsoNormal style="MARGIN: 0in 0in 0pt"><FONT size=3><FONT face="Times New Roman"><SPAN style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>Status 200 = Success</FONT></FONT></DIV>  <DIV class=MsoNormal style="MARGIN: 0in 0in 0pt"><FONT face="Times New Roman" size=3>&lt; ACL data: handle 41 flags 0x02 dlen 8</FONT></DIV>  <DIV class=MsoNormal style="MARGIN: 0in 0in 0pt"><FONT size=3><FONT face="Tim
 es
 New&#10; Roman"><SPAN style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp; </SPAN>L2CAP(d): cid 0x0041 len 4 [psm 3]</FONT></FONT></DIV>  <DIV class=MsoNormal style="MARGIN: 0in 0in 0pt"><FONT size=3><FONT face="Times New Roman"><SPAN style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>RFCOMM(s): DISC: cr 0 dlci 10 pf 1 ilen 0 fcs 0xc</FONT></FONT></DIV>  <DIV class=MsoNormal style="MARGIN: 0in 0in 0pt"><FONT face="Times New Roman" size=3>&gt; HCI Event: Number of Completed Packets (0x13) plen 5</FONT></DIV>  <DIV class=MsoNormal style="MARGIN: 0in 0in 0pt"><FONT size=3><FONT face="Times New Roman"><SPAN style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp; </SPAN>handle 41 packets 1</FONT></FONT></DIV>  <DIV class=MsoNormal style="MARGIN: 0in 0in 0pt"><FONT face="Times New Roman" size=3>&gt; HCI Event: Number of Completed Packets (0x13) plen 5</FONT></DIV>  <DIV class=MsoNormal style="MARGIN: 0in 0in 0pt"><FONT size=3><FONT face="Times New Roman"><SPAN style="mso-spacerun:
 yes">&nbsp;&nbsp;&nbsp; </SPAN>handle 41 packets 1</FONT></FONT></DIV>  <DIV class=MsoNormal style="MARGIN: 0in 0in 0pt"><FONT face="Times New Roman" size=3>&gt; ACL data: handle 41 flags 0x02 dlen 8</FONT></DIV>  <DIV class=MsoNormal style="MARGIN: 0in 0in 0pt"><FONT size=3><FONT face="Times New Roman"><SPAN style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp; </SPAN>L2CAP(d): cid 0x0040 len 4 [psm 3]</FONT></FONT></DIV>  <DIV class=MsoNormal style="MARGIN: 0in 0in 0pt"><FONT size=3><FONT face="Times New Roman"><SPAN style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>RFCOMM(s): DISC: cr 1 dlci 10 pf 1 ilen 0 fcs 0x6d</FONT></FONT></DIV>  <DIV class=MsoNormal style="MARGIN: 0in 0in 0pt"><FONT face="Times New Roman" size=3>&lt; ACL data: handle 41 flags 0x02 dlen 8</FONT></DIV>  <DIV class=MsoNormal style="MARGIN: 0in 0in 0pt"><FONT size=3><FONT face="Times New Roman"><SPAN style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp; </SPAN>L2CAP(d): cid 0x0041 len 4 [psm 3]</FONT></FON
 T></DIV>
  <DIV class=MsoNormal style="MARGIN: 0in 0in 0pt"><FONT size=3><FONT face="Times New Roman"><SPAN style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>RFCOMM(s): UA: cr 1 dlci 10 pf 1 ilen 0 fcs 0x47</FONT></FONT></DIV>  <DIV class=MsoNormal style="MARGIN: 0in 0in 0pt"><FONT face="Times New Roman" size=3>&gt; ACL data: handle 41 flags 0x02 dlen 8</FONT></DIV>  <DIV class=MsoNormal style="MARGIN: 0in 0in 0pt"><FONT size=3><FONT face="Times New Roman"><SPAN style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp; </SPAN>L2CAP(d): cid 0x0040 len 4 [psm 3]</FONT></FONT></DIV>  <DIV class=MsoNormal style="MARGIN: 0in 0in 0pt"><FONT size=3><FONT face="Times New Roman"><SPAN style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>RFCOMM(s): DM: cr 0 dlci 10 pf 1 ilen 0 fcs 0xc7</FONT></FONT></DIV>  <DIV class=MsoNormal style="MARGIN: 0in 0in 0pt"><FONT face="Times New Roman" size=3>&gt; HCI Event: Number of Completed Packets (0x13) plen 5</FONT></DIV>  <DIV class=MsoNormal
 style="MARGIN: 0in 0in 0pt"><FONT size=3><FONT face="Times New Roman"><SPAN style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp; </SPAN>handle 41 packets 1</FONT></FONT></DIV>  <DIV class=MsoNormal style="MARGIN: 0in 0in 0pt"><FONT face="Times New Roman" size=3>&gt; ACL data: handle 41 flags 0x02 dlen 8</FONT></DIV>  <DIV class=MsoNormal style="MARGIN: 0in 0in 0pt"><FONT size=3><FONT face="Times New Roman"><SPAN style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp; </SPAN>L2CAP(d): cid 0x0040 len 4 [psm 3]</FONT></FONT></DIV>  <DIV class=MsoNormal style="MARGIN: 0in 0in 0pt"><FONT size=3><FONT face="Times New Roman"><SPAN style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd</FONT></FONT></DIV>  <DIV class=MsoNormal style="MARGIN: 0in 0in 0pt"><FONT face="Times New Roman" size=3>&lt; ACL data: handle 41 flags 0x02 dlen 8</FONT></DIV>  <DIV class=MsoNormal style="MARGIN: 0in 0in 0pt"><FONT size=3><FONT face="Times New Roman"><SPAN
 style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp; </SPAN>L2CAP(d): cid 0x0041 len 4 [psm 3]</FONT></FONT></DIV>  <DIV class=MsoNormal style="MARGIN: 0in 0in 0pt"><FONT size=3><FONT face="Times New Roman"><SPAN style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7</FONT></FONT></DIV>  <DIV class=MsoNormal style="MARGIN: 0in 0in 0pt"><FONT face="Times New Roman" size=3></FONT>&nbsp;</DIV>  <DIV class=MsoNormal style="MARGIN: 0in 0in 0pt"><FONT face="Times New Roman" size=3>Thanks so much,</FONT></DIV>  <DIV class=MsoNormal style="MARGIN: 0in 0in 0pt"><FONT face="Times New Roman" size=3>Arch</FONT></DIV><p>
		<hr size=1> <a href="http://pa.yahoo.com/*http://us.rd.yahoo.com/evt=37474/*http://promo.yahoo.com/broadband/ 
">Yahoo! DSL</a> Something to write home about. Just $16.99/mo. or less
--0-1000886356-1133778777=:18014--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
