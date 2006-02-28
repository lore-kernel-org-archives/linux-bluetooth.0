Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <20060228152345.41492.qmail@web53107.mail.yahoo.com>
From: ermal mino <ermalmino1004@yahoo.it>
Subject: Re: [Bluez-devel] rfcomm socket connect timeout
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20060228145922.GQ6529@beta.private.mielke.cc>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-2036364169-1141140225=:40773"
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
Date: Tue, 28 Feb 2006 16:23:45 +0100 (CET)

--0-2036364169-1141140225=:40773
Content-Type: text/plain; charset=iso-8859-1

I don't know if there's a way to do it programmatically but i think it is a built in charachteristic as it is defined as a constant.
  I have had problems of this type and all I had to do was go to usr/src/linux/include/net/bluetooth/rfcomm.h
  and you must change:
  #define RFCOMM_CONN_TIMEOUT (HZ * 30)
  to:
  #define RFCOMM_CONN_TIMEOUT (HZ * X)
  where X is a number of your choice.
   
  And after that I rebuild the kernel modules ,all of them as i don't know another way of rebuilding only the bluetooth part.
   
   
  

Dave Mielke <dave@mielke.cc> ha scritto: 
  Is there a way to reduce the timeout for an rfcomm socket connect?

-- 
Dave Mielke | 2213 Fox Crescent | I believe that the Bible is the
Phone: 1-613-726-0014 | Ottawa, Ontario | Word of God. Please contact me
EMail: dave@mielke.cc | Canada K2A 1H7 | if you're concerned about Hell.
http://FamilyRadio.com/ | http://Mielke.cc/bible/


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel


		
---------------------------------
Yahoo! Mail: gratis 1GB per i messaggi, antispam, antivirus, POP3
--0-2036364169-1141140225=:40773
Content-Type: text/html; charset=iso-8859-1

<div>I don't know if there's a way to do it programmatically but i think it is a built in charachteristic as it is defined as a constant.</div>  <div>I have had problems of this type and all I had to do was go to usr/src/linux/include/net/bluetooth/rfcomm.h</div>  <div>and you must change:</div>  <div>#define RFCOMM_CONN_TIMEOUT (HZ * 30)</div>  <div>to:</div>  <div>#define RFCOMM_CONN_TIMEOUT (HZ * X)</div>  <div>where X is a number of your choice.</div>  <div>&nbsp;</div>  <div>And after that I rebuild the kernel modules ,all of them as i don't know another way of rebuilding only the bluetooth part.</div>  <div>&nbsp;</div>  <div>&nbsp;</div>  <div><BR><BR><B><I>Dave Mielke &lt;dave@mielke.cc&gt;</I></B> ha scritto: </div>  <BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid">Is there a way to reduce the timeout for an rfcomm socket connect?<BR><BR>-- <BR>Dave Mielke | 2213 Fox Crescent | I believe that the Bible is the<BR>Pho
 ne:
 1-613-726-0014 | Ottawa, Ontario | Word of God. Please contact me<BR>EMail: dave@mielke.cc | Canada K2A 1H7 | if you're concerned about Hell.<BR>http://FamilyRadio.com/ | http://Mielke.cc/bible/<BR><BR><BR>-------------------------------------------------------<BR>This SF.Net email is sponsored by xPML, a groundbreaking scripting language<BR>that extends applications into web and mobile media. Attend the live webcast<BR>and join the prime developer group breaking into this new coding territory!<BR>http://sel.as-us.falkag.net/sel?cmd=lnk&amp;kid=110944&amp;bid=241720&amp;dat=121642<BR>_______________________________________________<BR>Bluez-devel mailing list<BR>Bluez-devel@lists.sourceforge.net<BR>https://lists.sourceforge.net/lists/listinfo/bluez-devel<BR></BLOCKQUOTE><BR><p>
		<hr size=1><font face="Arial" size="2"><a href="http://us.rd.yahoo.com/mail_it/taglines/*http://it.mail.yahoo.com"><b>Yahoo! Mail</b></a>: gratis 1GB per i messaggi, antispam, antivirus, POP3</font>
--0-2036364169-1141140225=:40773--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
