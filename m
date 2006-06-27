Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <6297d67c0606270617s5f419729xd369b5142ffa5c06@mail.gmail.com>
Date: Tue, 27 Jun 2006 18:47:12 +0530
From: "Mayank Batra" <mayankbatra@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1151410695.25011.25.camel@localhost>
MIME-Version: 1.0
References: <6297d67c0606270505v511be476t247bcfc16d451833@mail.gmail.com>
	<1151410695.25011.25.camel@localhost>
Subject: Re: [Bluez-devel] Cross Compiling openobex
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0967085163=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0967085163==
Content-Type: multipart/alternative;
	boundary="----=_Part_29199_3360512.1151414232215"

------=_Part_29199_3360512.1151414232215
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Marcel,

On 6/27/06, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> > Does this mean that I have to compile glib also for ARM?
>
> use openobex-1.3 all other versions are outdated. And you might need to
> change ussp-push to not compile with GLib.


Actually, that is what I wanted to know. How do I compile ussp-push without
GLib?
It is simply not possible as the source files of ussp-push are including
header files from GLib.

Regards,
Mayank

------=_Part_29199_3360512.1151414232215
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Marcel,<br><br>
<div><span class="gmail_quote">On 6/27/06, <b class="gmail_sendername">Marcel Holtmann</b> &lt;<a href="mailto:marcel@holtmann.org">marcel@holtmann.org</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">&gt; Does this mean that I have to compile glib also for ARM?<br><br>use openobex-1.3 all other versions are outdated. And you might need to
<br>change ussp-push to not compile with GLib.</blockquote>
<div>&nbsp;</div>
<div>Actually, that is what I wanted to know. How do I compile ussp-push without GLib?</div>
<div>It is simply not possible as the source files of ussp-push are including header files from GLib.</div>
<div>&nbsp;</div>
<div>Regards,</div>
<div>Mayank</div></div>

------=_Part_29199_3360512.1151414232215--


--===============0967085163==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0967085163==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0967085163==--
