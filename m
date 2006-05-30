Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <20060530140840.52436.qmail@web50504.mail.yahoo.com>
Date: Tue, 30 May 2006 07:08:40 -0700 (PDT)
From: Mahtab Hossain <mahtab_hossain2002@yahoo.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] Transmit Power Level (TPL)
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1980051024=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1980051024==
Content-Type: multipart/alternative; boundary="0-1012532341-1148998120=:52089"
Content-Transfer-Encoding: 8bit

--0-1012532341-1148998120=:52089
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi,

I have been trying to work on the various signal strength values (RSSI, LQ & TPL) for quite sometime now. Though I am successful in getting RSSI & link quality (LQ) for my dongles (from both hcitool command & my own program), I always get Transmit Power level (TPL) as 0 - I have tested in various distances.
My dongles are either ISSC or Broadcom-based (no CSR dongles) - all of them support "power-control" feature.

And Marcel, I had also digged your code and saw that, you take a parameter for transmit power level calculation (the "type" field) in "hci_read_transmit_power_level" function and you set the parameter as:
type = (argc>1) ? atoi(argv[1]) : 0;

Since no argument is given, the type field is always 0. Does it have any significance? I have also seen that this type field is not required for RSSI or LQ calculation.

Finally, I only see "Get_Link_Quality" and "Read_RSSI" in bluetooth specification 1.0.B - no mention of "Transmit Power Level" there. My dongles are bluetooth 1.2, so, is there a possibility that they didn't provide transmit_power_level status value similar to that previous specification.
I think bluetooth specification 1.0.B is the free one available till now. If later versions are available, could anyone please provide me the link.

Lastly, if anyone could get bluetooth transmit power level (TPL) values other than 0, please let me know (preferrably with the dongles and bluetooth versions used in the dongles).

Thanks
Mahtab
		
---------------------------------
Be a chatter box. Enjoy free PC-to-PC calls  with Yahoo! Messenger with Voice.
--0-1012532341-1148998120=:52089
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi,<br><br>I have been trying to work on the various signal strength values (RSSI, LQ &amp; TPL) for quite sometime now. Though I am successful in getting RSSI &amp; link quality (LQ) for my dongles (from both hcitool command &amp; my own program), I always get Transmit Power level (TPL) as 0 - I have tested in various distances.<br>My dongles are either ISSC or Broadcom-based (no CSR dongles) - all of them support "power-control" feature.<br><br>And Marcel, I had also digged your code and saw that, you take a parameter for transmit power level calculation (the "type" field) in "hci_read_transmit_power_level" function and you set the parameter as:<br>type = (argc&gt;1) ? atoi(argv[1]) : 0;<br><br>Since no argument is given, the type field is always 0. Does it have any significance? I have also seen that this type field is not required for RSSI or LQ calculation.<br><br>Finally, I only see "Get_Link_Quality" and "Read_RSSI" in bluetooth specification 1.0.B - no mention of
 "Transmit Power Level" there. My dongles are bluetooth 1.2, so, is there a possibility that they didn't provide transmit_power_level status value similar to that previous specification.<br>I think bluetooth specification 1.0.B is the free one available till now. If later versions are available, could anyone please provide me the link.<br><br>Lastly, if anyone could get bluetooth transmit power level (TPL) values other than 0, please let me know (preferrably with the dongles and bluetooth versions used in the dongles).<br><br>Thanks<br>Mahtab<p>
		<hr size=1>Be a chatter box. Enjoy <a href="http://us.rd.yahoo.com/mail_us/taglines/postman12/*http://us.rd.yahoo.com/evt=39663/*http://messenger.yahoo.com">free PC-to-PC calls </a> with Yahoo! Messenger with Voice.
--0-1012532341-1148998120=:52089--


--===============1980051024==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1980051024==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1980051024==--
