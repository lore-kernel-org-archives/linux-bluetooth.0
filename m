Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <7b9ca310608080731k1a74a219q3f6c2fa18e0beda3@mail.gmail.com>
Date: Tue, 8 Aug 2006 10:31:48 -0400
From: "Michael Ellis" <michael.f.ellis@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <7b9ca310608080658h4e5e64c3i2e3448bc67fc5278@mail.gmail.com>
MIME-Version: 1.0
References: <7b9ca310608071427nb9b9d28u86251148f66d7bac@mail.gmail.com>
	<1154999049.3905.108.camel@aeonflux.holtmann.net>
	<7b9ca310608071818v5871bb19y2593b7a693ca4ab6@mail.gmail.com>
	<7b9ca310608080658h4e5e64c3i2e3448bc67fc5278@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="===============1042267224=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1042267224==
Content-Type: multipart/alternative;
	boundary="----=_Part_12327_31663417.1155047508286"

------=_Part_12327_31663417.1155047508286
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 8/8/06, Michael Ellis <michael.f.ellis@gmail.com> wrote:
>
>
>
>
> > HCI Event: Connect Complete (0x03) plen 11
>     status 0x06 handle 41 bdaddr 00:0C:84:00:16:51 type ACL encrypt 0x00
>     Error: PIN or Key Missing
>
> Found it.  In hcid.conf, I had pin-helper instead of pin_helper.  Is there
a setting that will cause hcid to log messages about invalid parameters in
the hcid.conf file? That would have saved me a couple of hours.
Mike

------=_Part_12327_31663417.1155047508286
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br><div><span class="gmail_quote">On 8/8/06, <b class="gmail_sendername">Michael Ellis</b> &lt;<a href="mailto:michael.f.ellis@gmail.com">michael.f.ellis@gmail.com</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div><span class="q"><br><br></span></div><div><br>
&gt; HCI Event: Connect Complete (0x03) plen 11<br>
&nbsp;&nbsp;&nbsp; status 0x06 handle 41 bdaddr 00:0C:84:00:16:51 type ACL encrypt 0x00<br>
&nbsp;&nbsp;&nbsp; Error: PIN or Key Missing<br>
<br></div></blockquote></div>Found it.&nbsp; In hcid.conf, I had
pin-helper instead of pin_helper.&nbsp; Is there a setting that will
cause hcid to log messages about invalid parameters in the hcid.conf
file? That would have saved me a couple of hours.<br>
Mike<br>


------=_Part_12327_31663417.1155047508286--


--===============1042267224==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1042267224==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1042267224==--
