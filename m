Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20040905073705.47183.qmail@web52803.mail.yahoo.com>
From: gonzalo briceno <gonzalohbriceno@yahoo.com>
Subject: Re: [Bluez-users] Key step in bluetonium setup, bcm203x does not load firmware
To: Luiz Fernando Capitulino <lcapitulino@conectiva.com.br>
Cc: bluez-users@lists.sourceforge.net
In-Reply-To: <41375861.90004@conectiva.com.br>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1063742842-1094369825=:46872"
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sun, 5 Sep 2004 00:37:05 -0700 (PDT)

--0-1063742842-1094369825=:46872
Content-Type: text/plain; charset=us-ascii

Luiz,
 
You are completely right.  I followed your instructions and my Broadcom Bluetonium (bcm203x module) based chip is working.  I hope I did not gloss over any section of information although I am almost positive that I did not.  Anyways, any one having this problem has to simply download bluez-firmware and copy the broadcom files onto /usr/lib/hotplug/firmware.  
Thank you so much.

Luiz Fernando Capitulino <lcapitulino@conectiva.com.br> wrote:

Hello Gonzalo,

gonzalo briceno wrote:

> I installed bluez-firmware-1.0 and bluez-utils-2.9,
> however, the problem is not fixed. When I look at
> /proc/bus/usb/devices the bluetonium chip is listed
> but sure enough, it does not load the usb_hci module.
>
> Any help?

We had the some problem here (but the device is different).

On our setup, we copied the firmware files to:

/usr/lib/hotplug/firmware/

and reloaded the kernel module.

I'm not certain if it is the right thing to do, but
it worked.

Hope it helps,

-- 
Luiz Fernando N. Capitulino


--
Gonzalo Briceno
gonzalohbriceno@yahoo.com
267.679.1289
		
---------------------------------
Do you Yahoo!?
Read only the mail you want - Yahoo! Mail SpamGuard.
--0-1063742842-1094369825=:46872
Content-Type: text/html; charset=us-ascii

<DIV>Luiz,</DIV>
<DIV>&nbsp;</DIV>
<DIV>You are completely right.&nbsp; I followed your instructions and my Broadcom Bluetonium (bcm203x module) based chip is working.&nbsp; I hope I did not gloss over any section of information although I am almost positive that I did not.&nbsp; Anyways, any one having this problem has to simply download bluez-firmware and copy the broadcom files onto /usr/lib/hotplug/firmware.&nbsp; </DIV>
<DIV>Thank you so much.<BR><BR><B><I>Luiz Fernando Capitulino &lt;lcapitulino@conectiva.com.br&gt;</I></B> wrote:</DIV>
<BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid"><BR>Hello Gonzalo,<BR><BR>gonzalo briceno wrote:<BR><BR>&gt; I installed bluez-firmware-1.0 and bluez-utils-2.9,<BR>&gt; however, the problem is not fixed. When I look at<BR>&gt; /proc/bus/usb/devices the bluetonium chip is listed<BR>&gt; but sure enough, it does not load the usb_hci module.<BR>&gt;<BR>&gt; Any help?<BR><BR>We had the some problem here (but the device is different).<BR><BR>On our setup, we copied the firmware files to:<BR><BR>/usr/lib/hotplug/firmware/<BR><BR>and reloaded the kernel module.<BR><BR>I'm not certain if it is the right thing to do, but<BR>it worked.<BR><BR>Hope it helps,<BR><BR>-- <BR>Luiz Fernando N. Capitulino<BR></BLOCKQUOTE><BR><BR>--<br>Gonzalo Briceno<br>gonzalohbriceno@yahoo.com<br>267.679.1289<p>
		<hr size=1>Do you Yahoo!?<br>
Read only the mail you want - <a href="http://us.rd.yahoo.com/mail_us/taglines/spamguard/*http://promotions.yahoo.com/new_mail/static/protection.html">Yahoo! Mail SpamGuard</a>.
--0-1063742842-1094369825=:46872--


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
