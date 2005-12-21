Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <F6E1228667B6D411BAAA00306E00F2A506A75557@pdc2.nestec.net>
From: JIBIN K <JIBINK@nestec.net>
To: "'bluez-devel@lists.sourceforge.net'" <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Subject: [Bluez-devel] bcsp problem
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
Date: Wed, 21 Dec 2005 16:34:29 +0530


Hi


	I am using bluez stack.  I found a Bluetooth Problem with Mobile
	 phone.
     It's happen when bluetooth device  connect to Mobile Phone for a long
     time,it shows the following error message.

 	 bcsp_handle_le_pkt: Found a LE sync pkt, card has reset
 	 bcsp_pkt_cull: Peer acked invalid packet
 	
 	I Think thehe above messages shows that the  bluetooth device was
  reset during the 	communication with mobile.So the bluecore firmware
  embedded in the chip will start sending 	Sync packets again to bcsp
  stack to establish the link between bluecore and bcsp stack.
 	
 	Why it is happening in bluez stack?
 	How to solve this problem ?

  Please help me.pls send ur reply as soon as possible

expecting ur reply

Regards
Jibin




---------------------------------------------------------------------------
       "This e-mail and any files transmitted with it are for the sole use
of the intended recipient(s) and may contain confidential and privileged
information. If you are not the intended recipient, please contact the
sender by reply e-mail and destroy all copies of the original message.

       Any unauthorized review, use, disclosure, dissemination, forwarding,
printing or copying of this email or any action taken upon this e-mail is
strictly prohibited and may be unlawful."
---------------------------------------------------------------------------


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
