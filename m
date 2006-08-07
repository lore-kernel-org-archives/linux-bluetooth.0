Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <c5cec3110608071613t47c4f0c5qcec15139ee78acff@mail.gmail.com>
Date: Tue, 8 Aug 2006 07:13:10 +0800
From: bees <guoqibi@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <7b9ca310608071427nb9b9d28u86251148f66d7bac@mail.gmail.com>
MIME-Version: 1.0
References: <7b9ca310608071427nb9b9d28u86251148f66d7bac@mail.gmail.com>
Subject: Re: [Bluez-users] dbus-1.pc not found
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2042215501=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============2042215501==
Content-Type: multipart/alternative;
	boundary="----=_Part_137585_29981229.1154992390159"

------=_Part_137585_29981229.1154992390159
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,Mike

http://sourceforge.net/mailarchive/message.php?msg_id=20745208, you will
find more in that mail list. I also arossed the problem before, finally I
have to use the old version of bluez(utils2.25   libs2.25).  Or you can
upgrade Linux on your host.

Regards

Bees


2006/8/8, Michael Ellis <michael.f.ellis@gmail.com>:
>
> Apologies if this has already been discussed, but I've searched on Google
> and Gmane and haven't found anything that seems to fit exactly.
>
> Trying to configure bluez-utils-3.2 on slackware 10.1 with a 2.6.11kernel,  I get
>
> checking for DBUS... Package dbus-1 was not found in the pkg-config search
> path.
> Perhaps you should add the directory containing `dbus-1.pc'
> to the PKG_CONFIG_PATH environment variable
> No package 'dbus-1' found
> configure: error: dbus > 0.35 is required
>
> Installing dbus-0.91, apparently successfully, does not cure the error.
> Is there something I needed to do other than the usual ./configure;  make;
> sudo make install?  My dbus executables were installed in /usr/local/bin.
>
> I also tried building bluez-utils-3.2 with  ./configure --disable-dbus.
> No effect, same error.  FWIW, I'm using the FCE4 desktop rather than Gnome
> or KDE. I mention this because I get the impression the need for dbus is
> typically associated with Desktop support.
>
>  I very much need to get bluez-utils working for simple serial comm to an
> embedded device and could care less about GUIs.  What's the most
> straightforward way get past this hurdle?
> Thanks,
> Mike Ellis
>
>
>
>
>
>
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job
> easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
>
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>
>
>

------=_Part_137585_29981229.1154992390159
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hi,Mike</div>
<div>&nbsp;</div>
<div><a onclick="return top.js.OpenExtLink(window,event,this)" href="http://sourceforge.net/mailarchive/message.php?msg_id=20745208" target="_blank">http://sourceforge.net/mailarchive/message.php?msg_id=20745208</a>, you will find more in that mail list. I&nbsp;also arossed the problem before,&nbsp;finally I have to use the&nbsp;old version of bluez(
utils2.25&nbsp;&nbsp; libs2.25).&nbsp;&nbsp;Or you can upgrade Linux&nbsp;on your host.</div>
<div>&nbsp;</div>
<div>Regards</div>
<div>&nbsp;</div>
<div>Bees<br><br>&nbsp;</div>
<div><span class="gmail_quote">2006/8/8, Michael Ellis &lt;<a onclick="return top.js.OpenExtLink(window,event,this)" href="mailto:michael.f.ellis@gmail.com" target="_blank">michael.f.ellis@gmail.com</a>&gt;:</span> 
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div>Apologies if this has already been discussed, but I've searched on Google and Gmane and haven't found anything that seems to fit exactly.<br><br>Trying to configure bluez-utils-3.2 on slackware 10.1 with a 2.6.11 kernel,&nbsp; I get&nbsp; 
<br><br clear="all">checking for DBUS... Package dbus-1 was not found in the pkg-config search path.<br>Perhaps you should add the directory containing `dbus-1.pc'<br>to the PKG_CONFIG_PATH environment variable<br>No package 'dbus-1' found 
<br>configure: error: dbus &gt; 0.35 is required<br><br>Installing dbus-0.91, apparently successfully, does not cure the error.&nbsp; Is there something I needed to do other than the usual ./configure;&nbsp; make;&nbsp; sudo make install?&nbsp; My dbus executables were installed in /usr/local/bin. 
<br><br>I also tried building bluez-utils-3.2 with&nbsp; ./configure --disable-dbus.&nbsp; No effect, same error.&nbsp; FWIW, I'm using the FCE4 desktop rather than Gnome or KDE. I mention this because I get the impression the need for dbus is typically associated with Desktop support. &nbsp; 
<br><br>&nbsp;I very much need to get bluez-utils working for simple serial comm to an embedded device and could care less about GUIs.&nbsp; What's the most straightforward way get past this hurdle?&nbsp; <br>Thanks,<br>Mike Ellis<br><br>
<br><br><br>&nbsp;</div><br>-------------------------------------------------------------------------<br>Using Tomcat but need to do more? Need to support web services, security?<br>Get stuff done quickly with pre-integrated technology to make your job easier 
<br>Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo<br><a onclick="return top.js.OpenExtLink(window,event,this)" href="http://sel.as-us.falkag.net/sel?cmd=lnk&amp;kid=120709&amp;bid=263057&amp;dat=121642" target="_blank">
http://sel.as-us.falkag.net/sel?cmd=lnk&amp;kid=120709&amp;bid=263057&amp;dat=121642</a><br><br>_______________________________________________<br>Bluez-users mailing list<br><a onclick="return top.js.OpenExtLink(window,event,this)" href="mailto:Bluez-users@lists.sourceforge.net" target="_blank">
Bluez-users@lists.sourceforge.net</a><br><a onclick="return top.js.OpenExtLink(window,event,this)" href="https://lists.sourceforge.net/lists/listinfo/bluez-users" target="_blank">https://lists.sourceforge.net/lists/listinfo/bluez-users 
</a><br><br><br></blockquote></div><br>

------=_Part_137585_29981229.1154992390159--


--===============2042215501==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============2042215501==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============2042215501==--
