Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <20060105105234.25444.qmail@web53101.mail.yahoo.com>
From: ermal mino <ermalmino1004@yahoo.it>
Subject: Re: [Bluez-devel] inquiry frequency
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <66dc03c80601041139r7a44eb49w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-698473558-1136458354=:21393"
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
Date: Thu, 5 Jan 2006 11:52:34 +0100 (CET)

--0-698473558-1136458354=:21393
Content-Type: text/plain; charset=iso-8859-1

Thank you Cesar,
  it worked fine.
  Regards.

Cezar Sá Espinola <cezarsa@gmail.com> ha scritto: 
  Hi Ermal.
Try to use the flag IREQ_CACHE_FLUSH with hci_inquiry().

regards,
-
Cezar

2006/1/4, ermal mino :
> Hi,
>
> I made a program wich searches for bluettooth devices continuously.
> I saw that until about 20-30 seconds from the first inquiry the results
> that were given to me were the same as the first one.
>
> I don't know if i explained it well, in a few words it makes a real inquiry
> every 20-30 seconds.
> How can i fix this or at least to make this delay smaller?
>
> regards,
> Ermal Mino.
>
> ________________________________
> Yahoo! Messenger: chiamate gratuite in tutto il mondo
>
>


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems? Stop! Download the new AJAX search engine that makes
searching your log files as easy as surfing the web. DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_idv37&alloc_id865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
  


		
---------------------------------
Yahoo! Mail: gratis 1GB per i messaggi, antispam, antivirus, POP3
--0-698473558-1136458354=:21393
Content-Type: text/html; charset=iso-8859-1

<DIV>Thank you Cesar,</DIV>  <DIV>it worked fine.</DIV>  <DIV>Regards.<BR><BR><B><I>Cezar Sá Espinola &lt;cezarsa@gmail.com&gt;</I></B> ha scritto: </DIV>  <BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid">Hi Ermal.<BR>Try to use the flag IREQ_CACHE_FLUSH with hci_inquiry().<BR><BR>regards,<BR>-<BR>Cezar<BR><BR>2006/1/4, ermal mino <ERMALMINO1004@YAHOO.IT>:<BR>&gt; Hi,<BR>&gt;<BR>&gt; I made a program wich searches for bluettooth devices continuously.<BR>&gt; I saw that until about 20-30 seconds from the first inquiry the results<BR>&gt; that were given to me were the same as the first one.<BR>&gt;<BR>&gt; I don't know if i explained it well, in a few words it makes a real inquiry<BR>&gt; every 20-30 seconds.<BR>&gt; How can i fix this or at least to make this delay smaller?<BR>&gt;<BR>&gt; regards,<BR>&gt; Ermal Mino.<BR>&gt;<BR>&gt; ________________________________<BR>&gt; Yahoo! Messenger: chiamate gratuite in tutto il
 mondo<BR>&gt;<BR>&gt;<BR><BR><BR>-------------------------------------------------------<BR>This SF.net email is sponsored by: Splunk Inc. Do you grep through log files<BR>for problems? Stop! Download the new AJAX search engine that makes<BR>searching your log files as easy as surfing the web. DOWNLOAD SPLUNK!<BR>http://ads.osdn.com/?ad_idv37&amp;alloc_id865&amp;op=click<BR>_______________________________________________<BR>Bluez-devel mailing list<BR>Bluez-devel@lists.sourceforge.net<BR>https://lists.sourceforge.net/lists/listinfo/bluez-devel<BR></BLOCKQUOTE>  <DIV><BR></DIV><p>
		<hr size=1><font face="Arial" size="2"><a href="http://us.rd.yahoo.com/mail_it/taglines/*http://it.mail.yahoo.com"><b>Yahoo! Mail</b></a>: gratis 1GB per i messaggi, antispam, antivirus, POP3</font>
--0-698473558-1136458354=:21393--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
