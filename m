Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <20061116161319.54202.qmail@web37710.mail.mud.yahoo.com>
Date: Thu, 16 Nov 2006 08:13:19 -0800 (PST)
From: Imran Siddique <imran_stdu@yahoo.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1163678809.5169.47.camel@localhost>
MIME-Version: 1.0
Subject: Re: [Bluez-devel] Bluetooth devices connection problem
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1375187561=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1375187561==
Content-Type: multipart/alternative; boundary="0-1467772982-1163693599=:54180"
Content-Transfer-Encoding: 8bit

--0-1467772982-1163693599=:54180
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

I know that is very easy to implement with L2CAP and RFCOMM, but my assignment is to be implement using HCI layer, and have to use these command ...
   
  Now, I have fix this problem ...
   
  Thanks for ur reply ...
   
  take care
  Regards,

Marcel Holtmann <marcel@holtmann.org> wrote:
  Hi,

> We are using Linux for tranfering a file on bluetooth devices. Connection create
> function on HCI layer i.e. (hci_create_connection(----)) can't procced and give
> error message.
> 
> Connection failed !
> : operation not permitted
> 
> kindly suggest is there any problem with linux kernal or else.

simply don't use this command. There is no need to deal with low-level
HCI command at all. The L2CAP and RFCOMM sockets full abstract from this
and for everything else we have a nice D-Bus based interface.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel



Imran Siddique 
MS Computing Science 
Umeå University, 
Sweden. 
--------------------------------
Cell: +46-762743152
 
---------------------------------
Sponsored Link

Mortgage rates near 39yr lows. $510,000 Mortgage for $1,698/mo -   Calculate new house payment
--0-1467772982-1163693599=:54180
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<div>I know that is very easy to implement with L2CAP and RFCOMM, but my assignment is to be implement using HCI layer, and have to use these command ...</div>  <div>&nbsp;</div>  <div>Now, I have fix this problem ...</div>  <div>&nbsp;</div>  <div>Thanks for ur reply ...</div>  <div>&nbsp;</div>  <div>take care</div>  <div>Regards,<BR><BR><B><I>Marcel Holtmann &lt;marcel@holtmann.org&gt;</I></B> wrote:</div>  <BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid">Hi,<BR><BR>&gt; We are using Linux for tranfering a file on bluetooth devices. Connection create<BR>&gt; function on HCI layer i.e. (hci_create_connection(----)) can't procced and give<BR>&gt; error message.<BR>&gt; <BR>&gt; Connection failed !<BR>&gt; : operation not permitted<BR>&gt; <BR>&gt; kindly suggest is there any problem with linux kernal or else.<BR><BR>simply don't use this command. There is no need to deal with low-level<BR>HCI command at all. The L2CAP and
 RFCOMM sockets full abstract from this<BR>and for everything else we have a nice D-Bus based interface.<BR><BR>Regards<BR><BR>Marcel<BR><BR><BR><BR>-------------------------------------------------------------------------<BR>Take Surveys. Earn Cash. Influence the Future of IT<BR>Join SourceForge.net's Techsay panel and you'll get the chance to share your<BR>opinions on IT &amp; business topics through brief surveys - and earn cash<BR>http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV<BR>_______________________________________________<BR>Bluez-devel mailing list<BR>Bluez-devel@lists.sourceforge.net<BR>https://lists.sourceforge.net/lists/listinfo/bluez-devel<BR></BLOCKQUOTE><BR><BR><BR><STRONG>Imran Siddique</STRONG> <BR>MS Computing Science <BR>Umeå University, <BR>Sweden. <BR>--------------------------------<BR>Cell: +46-762743152<p>&#32;

<font color="666666"><font size="2"><hr size=1>Sponsored Link</font></font><br><br>Mortgage rates near 39yr lows. $510,000 Mortgage for $1,698/mo -   
<a href="http://www.lowermybills.com/lre/index.jsp?sourceid=lmb-9134-16416&moid=4119">Calculate new house payment</a>
--0-1467772982-1163693599=:54180--


--===============1375187561==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1375187561==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1375187561==--
