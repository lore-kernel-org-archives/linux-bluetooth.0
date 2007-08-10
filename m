Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <b5c34db00708100613v27b1b0b8vd9535a2269110588@mail.gmail.com>
Date: Fri, 10 Aug 2007 18:43:51 +0530
From: "umamahesh yelchuru venkata" <umeshyv@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <1186736578.20129.202.camel@violet>
MIME-Version: 1.0
References: <fb2ac3c90708092110y3a4ffff1ka8d5ea1ebdd17e32@mail.gmail.com>
	<1186736578.20129.202.camel@violet>
Subject: Re: [Bluez-users] bluetooth-applet and gnome-vfs-obexftp
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0919147697=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0919147697==
Content-Type: multipart/alternative;
	boundary="----=_Part_25330_21396604.1186751631995"

------=_Part_25330_21396604.1186751631995
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Marcel,
        Currently i want to test bluetooth dongle for my development board
DBAu1200 i ported linux-2.6.11 kernel and enabled the required bluetooth
services and usb bluetooth driver .To test it i cross compiled the
bluez-libs-2.25 and bluez-utils-2.25 for MIPS architecture and for cross
compilation i followed the following documentation from uclinux please see
the following link docs.blackfin.uclinux.org/doku.php?id=blutooth_on_usb in
that instead of bfin-uclinux i used mipsel and for CPPFLAGS="-D__KERNEL" it
compiled successfully and i ported all the files under install folder,when i
tried to execute from board following was the error message,

Cannot execute the binary files.Could you guide where i am going wrong,
waiting for your valuable suggestions

Thank you

Regards
Umesh
On 8/10/07, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Andrew,
>
> > Version 0.10 of bluez-gnome added support for "browsing devices" - a
> > much needed feature by any account.  What I'm not thrilled about is
> > that it was written to support gnome-vfs-obexftp.
> >
> > Don't get me wrong - gnome-vfs-obexftp is awesome, but
> > bluetooth-applet is the wrong entry point for it.  The applet should
> > allow you to see what devices are around you and allow you to initiate
> > a bonding with them but the assumption that you want to browse OBEX is
> > bad.
>
> it is exactly the right entry point. You might wanna compare how MacOS X
> handles it. The actual bonding will be done automatically. You are the
> client and so we can rely on the actual FTP server to ask for a bonding
> and not wasting time to try to pair a public FTP repository that has no
> key anyway.
>
> > Another problem with this approach is that it creates a dependency on
> > gnome-vfs-obexftp and assumes that it's present.  If it's desirable to
> > have the applet launch other programs it should support more than
> > obex:// and there should be some generic mechanism for programs to
> > plug themselves in as handling a given service.  It should be possible
> > some day to get a bluetooth mouse working from the GUI, or a bluetooth
> > headset, for example.
>
> It only supports Bluetooth FTP and is not meant to support everything.
> So I have no idea what you are talking about. Use the preferences dialog
> or the upcoming wizard to connect other type of Bluetooth devices.
>
> > Of course there needs to be better integration of gnome-vfs-obexftp,
> > but that integration should be in nautilus where everything else
> > vfs-related is found.  A bluetooth link under computer:/// when an
> > adapter is present would be sufficient (though I wish we'd treat OBEX
> > more generically as well - it's got 3 or 4 transports besides
> > bluetooth).
>
> We know that OBEX supports more than the Bluetooth transport, but which
> of these transports actually have devices that support FTP like
> transactions. Most of them only allow to push or pull a file. However
> feel free to fix gnome-vfs-obexftp to make this work.
>
> If you wanna have the Bluetooth adapters (yes, plural. We can have more
> than one) under computer:/// then go ahead a send patches upstream. I
> personally don't care and I am not responsible for that part of
> software.
>
> As usual with these kind of things, I am not the UI expert and if you
> wanna have fixed or changed something, you better send in a patch. We
> always welcome new development blood.
>
> Regards
>
> Marcel
>
>
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc.
> Still grepping through log files to find problems?  Stop.
> Now Search log events and configuration files using AJAX and a browser.
> Download your FREE copy of Splunk now >>  http://get.splunk.com/
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>

------=_Part_25330_21396604.1186751631995
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hi Marcel,</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Currently i want to test bluetooth dongle for my development board DBAu1200 i ported linux-2.6.11 kernel and enabled the required bluetooth services and usb bluetooth driver .To test it i cross compiled the 
bluez-libs-2.25 and bluez-utils-2.25 for MIPS architecture and for cross compilation i followed the following documentation from uclinux please see the following link <a href="http://docs.blackfin.uclinux.org/doku.php?id=blutooth_on_usb">
docs.blackfin.uclinux.org/doku.php?id=blutooth_on_usb</a> in that instead of bfin-uclinux i used mipsel and for CPPFLAGS=&quot;-D__KERNEL&quot; it compiled successfully and i ported all the files under install folder,when i tried to execute from board following was the error message,
<br><br>Cannot execute the binary files.Could you guide where i am going wrong, waiting for your valuable suggestions </div>
<div>&nbsp;</div>
<div>Thank you</div>
<div>&nbsp;</div>
<div>Regards</div>
<div>Umesh</div>
<div><span class="gmail_quote">On 8/10/07, <b class="gmail_sendername">Marcel Holtmann</b> &lt;<a href="mailto:marcel@holtmann.org">marcel@holtmann.org</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Hi Andrew,<br><br>&gt; Version 0.10 of bluez-gnome added support for &quot;browsing devices&quot; - a<br>&gt; much needed feature by any account.&nbsp;&nbsp;What I&#39;m not thrilled about is
<br>&gt; that it was written to support gnome-vfs-obexftp.<br>&gt;<br>&gt; Don&#39;t get me wrong - gnome-vfs-obexftp is awesome, but<br>&gt; bluetooth-applet is the wrong entry point for it.&nbsp;&nbsp;The applet should<br>&gt; allow you to see what devices are around you and allow you to initiate
<br>&gt; a bonding with them but the assumption that you want to browse OBEX is<br>&gt; bad.<br><br>it is exactly the right entry point. You might wanna compare how MacOS X<br>handles it. The actual bonding will be done automatically. You are the
<br>client and so we can rely on the actual FTP server to ask for a bonding<br>and not wasting time to try to pair a public FTP repository that has no<br>key anyway.<br><br>&gt; Another problem with this approach is that it creates a dependency on
<br>&gt; gnome-vfs-obexftp and assumes that it&#39;s present.&nbsp;&nbsp;If it&#39;s desirable to<br>&gt; have the applet launch other programs it should support more than<br>&gt; obex:// and there should be some generic mechanism for programs to
<br>&gt; plug themselves in as handling a given service.&nbsp;&nbsp;It should be possible<br>&gt; some day to get a bluetooth mouse working from the GUI, or a bluetooth<br>&gt; headset, for example.<br><br>It only supports Bluetooth FTP and is not meant to support everything.
<br>So I have no idea what you are talking about. Use the preferences dialog<br>or the upcoming wizard to connect other type of Bluetooth devices.<br><br>&gt; Of course there needs to be better integration of gnome-vfs-obexftp,
<br>&gt; but that integration should be in nautilus where everything else<br>&gt; vfs-related is found.&nbsp;&nbsp;A bluetooth link under computer:/// when an<br>&gt; adapter is present would be sufficient (though I wish we&#39;d treat OBEX
<br>&gt; more generically as well - it&#39;s got 3 or 4 transports besides<br>&gt; bluetooth).<br><br>We know that OBEX supports more than the Bluetooth transport, but which<br>of these transports actually have devices that support FTP like
<br>transactions. Most of them only allow to push or pull a file. However<br>feel free to fix gnome-vfs-obexftp to make this work.<br><br>If you wanna have the Bluetooth adapters (yes, plural. We can have more<br>than one) under computer:/// then go ahead a send patches upstream. I
<br>personally don&#39;t care and I am not responsible for that part of<br>software.<br><br>As usual with these kind of things, I am not the UI expert and if you<br>wanna have fixed or changed something, you better send in a patch. We
<br>always welcome new development blood.<br><br>Regards<br><br>Marcel<br><br><br><br>-------------------------------------------------------------------------<br>This SF.net email is sponsored by: Splunk Inc.<br>Still grepping through log files to find problems?&nbsp;&nbsp;Stop.
<br>Now Search log events and configuration files using AJAX and a browser.<br>Download your FREE copy of Splunk now &gt;&gt;&nbsp;&nbsp;<a href="http://get.splunk.com/">http://get.splunk.com/</a><br>_______________________________________________
<br>Bluez-users mailing list<br><a href="mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net</a><br><a href="https://lists.sourceforge.net/lists/listinfo/bluez-users">https://lists.sourceforge.net/lists/listinfo/bluez-users
</a><br></blockquote></div><br>

------=_Part_25330_21396604.1186751631995--


--===============0919147697==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--===============0919147697==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0919147697==--
