Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20060116072925.48073.qmail@web15009.mail.cnb.yahoo.com>
From: Chenghua Yan <hua9008@yahoo.com.cn>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-743602839-1137396565=:46747"
Subject: [Bluez-users] BTSCO question
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
Date: Mon, 16 Jan 2006 15:29:25 +0800 (CST)

--0-743602839-1137396565=:46747
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: 8bit

Hi all
   
  I use btsco to let my PC reach my headset,the dangle's maker is ISSC.
  Run such command:
   
  # btsco -v headset_bdaddr
   
  It appears:
   
  btsco v0.4
  Voice setting : 0x0060
  RFCOMM channel 1 connected
   
  What should I do next?
  I open the other terminate to run 
   
  # aplay -B 1000000 -D plughw: *.wav
   
  But there's no sound in my headset,I want to know why.
  And I want to know what to do next to reach my destination.
   
  Thanks a lot.



		
---------------------------------
 —≈ª¢1G√‚∑—” œ‰∞Ÿ∑÷∞Ÿ∑¿¿¨ª¯–≈
 —≈ª¢÷˙ ÷-À—À˜°¢…±∂æ°¢∑¿…ß»≈  
--0-743602839-1137396565=:46747
Content-Type: text/html; charset=gb2312
Content-Transfer-Encoding: 8bit

<DIV id=RTEContent>Hi all</DIV>  <DIV>&nbsp;</DIV>  <DIV>I use btsco to let my PC reach my headset,the dangle's maker is ISSC.</DIV>  <DIV>Run such command:</DIV>  <DIV>&nbsp;</DIV>  <DIV># btsco -v headset_bdaddr</DIV>  <DIV>&nbsp;</DIV>  <DIV>It appears:</DIV>  <DIV>&nbsp;</DIV>  <DIV>btsco v0.4</DIV>  <DIV>Voice setting : 0x0060</DIV>  <DIV>RFCOMM channel 1 connected</DIV>  <DIV>&nbsp;</DIV>  <DIV>What should I do next?</DIV>  <DIV>I open the other terminate to run </DIV>  <DIV>&nbsp;</DIV>  <DIV># aplay -B 1000000 -D plughw: *.wav</DIV>  <DIV>&nbsp;</DIV>  <DIV>But there's no sound in my headset,I want to know why.</DIV>  <DIV>And I want to know what to do next to reach my destination.</DIV>  <DIV>&nbsp;</DIV>  <DIV>Thanks a lot.</DIV><BR><BR><p>
		<hr size=1><a href="http://cn.mail.yahoo.com" target=blank> 
—≈ª¢1G√‚∑—” œ‰∞Ÿ∑÷∞Ÿ∑¿¿¨ª¯–≈</a><br> 
<a href="http://cn.zs.yahoo.com" target=blank>—≈ª¢÷˙ ÷-À—À˜°¢…±∂æ°¢∑¿…ß»≈</a> 
 

--0-743602839-1137396565=:46747--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
