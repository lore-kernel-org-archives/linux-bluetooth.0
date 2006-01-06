Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <20060106143636.31846.qmail@web53110.mail.yahoo.com>
From: ermal mino <ermalmino1004@yahoo.it>
To: bluez <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-238505642-1136558196=:31839"
Subject: [Bluez-devel] open obex multisession
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
Date: Fri, 6 Jan 2006 15:36:36 +0100 (CET)

--0-238505642-1136558196=:31839
Content-Type: text/plain; charset=iso-8859-1

Hi,
  I tried to send a file to two cellphones at the same time using ussp-push.
  I excecuted it in two different consoles. By this time the conections freeze and i can't disconnect them anynmore, even using "hcitool dc". The only way to disconnect is restart the pc or disconnect the usb dongle.
  It gives me the same problem when using two dongles at the same time.
   
  I saw that in the ussp-push code it binds the local socket in 0 channel.
  I modified it and tried with diffrent channels for each connection but still nothing changed.
   
  Is it possible what i am trying to do ?
  Acording to bluetooth specification i can make 7 connections simultaneously being the master. I controled the connections and i was the master.
   
  is it bluez or open obex responsible for this error?
   
  what can i do to fix it and send files to more than one phone at the same time?
   
  P.S. if somebody could tell me where to find a good tutorial for open obex i would be grateful. I couldn't find nothing searching with google.
   
  Thank you.
  Regards,
  Ermal Mino.

Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
--0-238505642-1136558196=:31839
Content-Type: text/html; charset=iso-8859-1

<DIV id=RTEContent>Hi,</DIV>  <DIV>I tried to send a file to two cellphones at the same time using ussp-push.</DIV>  <DIV>I excecuted it in two different consoles. By this time the conections freeze and i can't disconnect them anynmore, even using "hcitool dc". The only way to disconnect is restart the pc or disconnect the usb dongle.</DIV>  <DIV>It gives me the same problem when using two dongles at the same time.</DIV>  <DIV>&nbsp;</DIV>  <DIV>I saw that in the ussp-push code it binds the local socket in 0 channel.</DIV>  <DIV>I modified it and tried with diffrent channels for each connection but still nothing changed.</DIV>  <DIV>&nbsp;</DIV>  <DIV>Is it possible what i am trying to do ?</DIV>  <DIV>Acording to bluetooth specification i can make 7 connections simultaneously being the master. I controled the connections and i was the master.</DIV>  <DIV>&nbsp;</DIV>  <DIV>is it bluez or open obex responsible for this error?</DIV>  <DIV>&nbsp;</DIV>  <DIV>what can i do to fi
 x it and
 send files to more than one phone at the same time?</DIV>  <DIV>&nbsp;</DIV>  <DIV>P.S. if somebody&nbsp;could tell me where to find a good tutorial for open obex i would be grateful. I couldn't find nothing searching with google.</DIV>  <DIV>&nbsp;</DIV>  <DIV>Thank you.</DIV>  <DIV>Regards,</DIV>  <DIV>Ermal Mino.</DIV><p>Chiacchiera con i tuoi amici in tempo reale! <br> http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
--0-238505642-1136558196=:31839--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
