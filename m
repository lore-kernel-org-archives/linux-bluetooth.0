Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <20060822094156.27087.qmail@web25406.mail.ukl.yahoo.com>
Date: Tue, 22 Aug 2006 11:41:56 +0200 (CEST)
From: Dirk Vornheder <dirk_vornheder@yahoo.de>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] pand connection fails
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1403583857=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1403583857==
Content-Type: multipart/alternative; boundary="0-138094537-1156239716=:23466"
Content-Transfer-Encoding: 8bit

--0-138094537-1156239716=:23466
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi !
   
  After compile and installation bluez-libs/utils 3.x including
   
  kernel patch mh5 under SUSE 10.0 and kernel 2.6.17.9
   
  i plugin my AVM Bluetooth Stick and get the following messages:
   
  Aug 20 21:04:31 pcmini kernel: Bluetooth: BlueFRITZ! USB loading firmware
  Aug 20 21:04:34 pcmini kernel: Bluetooth: BlueFRITZ! USB device ready
  Aug 20 21:04:39 pcmini ifup: No configuration found for ippp*
  Aug 20 21:04:44 pcmini ifup: No configuration found for isdn*
  Aug 20 21:04:52 pcmini hcid[6804]: Bluetooth HCI daemon
  Aug 20 21:04:52 pcmini hcid[6804]: Register path:/org/bluez fallback:1
  Aug 20 21:04:52 pcmini sdpd[6806]: Bluetooth SDP daemon
  Aug 20 21:04:52 pcmini hcid[6804]: Device hci0 has been added
  Aug 20 21:04:53 pcmini hcid[6804]: Can't write inquiry mode for hci0: 
  Connection timed out (110)
  Aug 20 21:04:53 pcmini hcid[6804]: Register path:/org/bluez/hci0 fallback:0
  Aug 20 21:04:54 pcmini hcid[6804]: Sending read scan enable command failed: 
  Connection timed out (110)
  Aug 20 21:04:54 pcmini kernel: hci_cmd_task: hci0 command tx timeout
  Aug 20 21:04:54 pcmini hcid[6804]: HCI dev 0 up
  Aug 20 21:04:54 pcmini hcid[6804]: Starting security manager 0
  Aug 20 21:04:55 pcmini hcid[6804]: Can't write inquiry mode for hci0: 
  Connection timed out (110)
  Aug 20 21:04:55 pcmini hcid[6804]: Sending read scan enable command failed: 
  Connection timed out (110)
  Aug 20 21:04:55 pcmini kernel: hci_cmd_task: hci0 command tx timeout
   
  hcitool scan works but building a pand connection fails:
   
  Aug 20 21:05:35 pcmini kernel: Bluetooth: BNEP (Ethernet Emulation) ver 1.2
  Aug 20 21:05:35 pcmini kernel: Bluetooth: BNEP filters: protocol multicast
  Aug 20 21:05:35 pcmini pand[6815]: Bluetooth PAN daemon version 3.2
  Aug 20 21:05:35 pcmini pand[6815]: Connecting to 00:04:0E:85:35:15
  Aug 20 21:05:41 pcmini hcid[6804]: pin_code_request (sba=00:04:0E:85:2E:9A, 
  dba=00:04:0E:85:35:15)
  Aug 20 21:05:41 pcmini hcid[6804]: call_passkey_agent(): no agent registered
  Aug 20 21:05:41 pcmini pand[6815]: Connect to 00:04:0E:85:35:15 failed. 
  Connection refused(111)
  Aug 20 21:05:43 pcmini kernel: hci_cmd_task: hci0 command tx timeout
   
  Dirk

 		
---------------------------------
Was ist Glück? Schlafen Fische überhaupt? Die Antworten gibt’s auf Yahoo! Clever.
--0-138094537-1156239716=:23466
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<div>Hi !</div>  <div>&nbsp;</div>  <div>After compile and installation bluez-libs/utils 3.x including</div>  <div>&nbsp;</div>  <div>kernel patch mh5 under SUSE 10.0 and kernel 2.6.17.9</div>  <div>&nbsp;</div>  <div>i plugin my AVM Bluetooth Stick and get the following messages:</div>  <div>&nbsp;</div><FONT size=2>  <div>Aug 20 21:04:31 pcmini kernel: Bluetooth: BlueFRITZ! USB loading firmware</div>  <div>Aug 20 21:04:34 pcmini kernel: Bluetooth: BlueFRITZ! USB device ready</div>  <div>Aug 20 21:04:39 pcmini ifup: No configuration found for ippp*</div>  <div>Aug 20 21:04:44 pcmini ifup: No configuration found for isdn*</div>  <div>Aug 20 21:04:52 pcmini hcid[6804]: Bluetooth HCI daemon</div>  <div>Aug 20 21:04:52 pcmini hcid[6804]: Register path:/org/bluez fallback:1</div>  <div>Aug 20 21:04:52 pcmini sdpd[6806]: Bluetooth SDP daemon</div>  <div>Aug 20 21:04:52 pcmini hcid[6804]: Device hci0 has been added</div>  <div>Aug 20 21:04:53 pcmini hcid[6804]: Can't write
 inquiry mode for hci0: </div>  <div>Connection timed out (110)</div>  <div>Aug 20 21:04:53 pcmini hcid[6804]: Register path:/org/bluez/hci0 fallback:0</div>  <div>Aug 20 21:04:54 pcmini hcid[6804]: Sending read scan enable command failed: </div>  <div>Connection timed out (110)</div>  <div>Aug 20 21:04:54 pcmini kernel: hci_cmd_task: hci0 command tx timeout</div>  <div>Aug 20 21:04:54 pcmini hcid[6804]: HCI dev 0 up</div>  <div>Aug 20 21:04:54 pcmini hcid[6804]: Starting security manager 0</div>  <div>Aug 20 21:04:55 pcmini hcid[6804]: Can't write inquiry mode for hci0: </div>  <div>Connection timed out (110)</div>  <div>Aug 20 21:04:55 pcmini hcid[6804]: Sending read scan enable command failed: </div>  <div>Connection timed out (110)</div>  <div>Aug 20 21:04:55 pcmini kernel: hci_cmd_task: hci0 command tx timeout</div>  <div>&nbsp;</div>  <div>hcitool scan works but building a pand connection fails:</div>  <div>&nbsp;</div>  <div>Aug 20 21:05:35 pcmini kernel: Bluetooth:
 BNEP (Ethernet Emulation) ver 1.2</div>  <div>Aug 20 21:05:35 pcmini kernel: Bluetooth: BNEP filters: protocol multicast</div>  <div>Aug 20 21:05:35 pcmini pand[6815]: Bluetooth PAN daemon version 3.2</div>  <div>Aug 20 21:05:35 pcmini pand[6815]: Connecting to 00:04:0E:85:35:15</div>  <div>Aug 20 21:05:41 pcmini hcid[6804]: pin_code_request (sba=00:04:0E:85:2E:9A, </div>  <div>dba=00:04:0E:85:35:15)</div>  <div>Aug 20 21:05:41 pcmini hcid[6804]: call_passkey_agent(): no agent registered</div>  <div>Aug 20 21:05:41 pcmini pand[6815]: Connect to 00:04:0E:85:35:15 failed. </div>  <div>Connection refused(111)</div>  <div>Aug 20 21:05:43 pcmini kernel: hci_cmd_task: hci0 command tx timeout</div>  <div>&nbsp;</div>  <div>Dirk</div></FONT><p>&#32;
		<hr size=1>Was ist Glück? Schlafen Fische überhaupt? Die Antworten gibt’s auf <a href=http://de.rd.yahoo.com/xx/searchpromo/i/tagline/cleverfp/*http://de.answers.yahoo.com>Yahoo! Clever</a>.
--0-138094537-1156239716=:23466--


--===============1403583857==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1403583857==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1403583857==--
