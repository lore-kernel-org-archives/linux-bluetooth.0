Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20060106100921.4675.qmail@web60620.mail.yahoo.com>
From: ronny hidayat <kempyeng88@yahoo.com>
Subject: Re: [Bluez-users] bluetooth settings in debian
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1136540911.7429.3.camel@localhost>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1763682378-1136542161=:2188"
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
Date: Fri, 6 Jan 2006 10:09:21 +0000 (GMT)

--0-1763682378-1136542161=:2188
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hello again,
   
  Do you know what command should I use to send/receive file via bluetooth ?
  Where should I put PIN number ?
  Are there any documentation too ?
   
  Thanks
  Ronny

Marcel Holtmann <marcel@holtmann.org> wrote:
  Hi Ronny,

> I have Linux Debian 2.6, bluetooth & Bluez already installed.
> But I don't know how to change setting for bluetooth (like friendly
> name & services).
> How / Where can I find those settings ?

Look at /etc/bluetooth/hcid.conf.

> I want to make program like rfcomm server that can receive connection
> up to 7 client and then sending messages between them.
> Does bluez support this ?

Yes.

> Maybe anyone has documentation or sample program for this ?

Look at the source code of bluez-utils.

Regards

Marcel


Send instant messages to your online friends http://uk.messenger.yahoo.com 
--0-1763682378-1136542161=:2188
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<DIV>Hello again,</DIV>  <DIV>&nbsp;</DIV>  <DIV>Do you know what command should I use to send/receive file via bluetooth ?</DIV>  <DIV>Where should I put PIN number ?</DIV>  <DIV>Are there any documentation too ?</DIV>  <DIV>&nbsp;</DIV>  <DIV>Thanks</DIV>  <DIV>Ronny<BR><BR><B><I>Marcel Holtmann &lt;marcel@holtmann.org&gt;</I></B> wrote:</DIV>  <BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid">Hi Ronny,<BR><BR>&gt; I have Linux Debian 2.6, bluetooth &amp; Bluez already installed.<BR>&gt; But I don't know how to change setting for bluetooth (like friendly<BR>&gt; name &amp; services).<BR>&gt; How / Where can I find those settings ?<BR><BR>Look at /etc/bluetooth/hcid.conf.<BR><BR>&gt; I want to make program like rfcomm server that can receive connection<BR>&gt; up to 7 client and then sending messages between them.<BR>&gt; Does bluez support this ?<BR><BR>Yes.<BR><BR>&gt; Maybe anyone has documentation or sample program for t
 his
 ?<BR><BR>Look at the source code of bluez-utils.<BR><BR>Regards<BR><BR>Marcel<BR><BR></BLOCKQUOTE><p>Send instant messages to your online friends http://uk.messenger.yahoo.com 
--0-1763682378-1136542161=:2188--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
