Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <6297d67c0606272053xff3b84dwf59410cce7bc658b@mail.gmail.com>
Date: Wed, 28 Jun 2006 09:23:00 +0530
From: "Mayank Batra" <mayankbatra@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <loom.20060628T033626-329@post.gmane.org>
MIME-Version: 1.0
References: <loom.20060628T033626-329@post.gmane.org>
Subject: Re: [Bluez-devel] cross-compiling bluez-utils.3.1
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1820046631=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1820046631==
Content-Type: multipart/alternative;
	boundary="----=_Part_4854_17986110.1151466780100"

------=_Part_4854_17986110.1151466780100
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Robert,

On 6/28/06, Robert Wlaschin <robertw@healthhero.com> wrote:

> I seem to be having problems with the latest version of bluez-utils.  It
> seems
> that dbus is a required component of the 3.1 release; which isn't
> cross-compile
> friendly (the dbus build complains about cross-compiling) -- a previous
> version
> of bluez-utils (2.21) is.  In the 2.21 release there was an option to
> compile
> without dbus, is there a work around for the 3.1/if so, how?  If not, any
> suggestions about cross-compiling the stock bluez-utils.3.1 (including
> dbus as
> necessary) for an ARM processor?
>
> Robert


Actually the latest bluez-utils are not even compiling on PC. It complains
that dbus package is not present.

Regards,
Mayank

------=_Part_4854_17986110.1151466780100
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Robert,<br><br>
<div><span class="gmail_quote">On 6/28/06, <b class="gmail_sendername">Robert Wlaschin</b> &lt;<a href="mailto:robertw@healthhero.com">robertw@healthhero.com</a>&gt; wrote:</span></div>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">I seem to be having problems with the latest version of bluez-utils.&nbsp;&nbsp;It seems<br>that dbus is a required component of the 
3.1 release; which isn't cross-compile<br>friendly (the dbus build complains about cross-compiling) -- a previous version<br>of bluez-utils (2.21) is.&nbsp;&nbsp;In the 2.21 release there was an option to compile<br>without dbus, is there a work around for the 
3.1/if so, how?&nbsp;&nbsp;If not, any<br>suggestions about cross-compiling the stock bluez-utils.3.1 (including dbus as<br>necessary) for an ARM processor?<br><br>Robert</blockquote>
<div>&nbsp;</div>
<div>Actually the latest bluez-utils are not even compiling on PC. It complains that dbus package is not present.</div>
<div>&nbsp;</div>
<div>Regards,</div>
<div>Mayank</div><br>

------=_Part_4854_17986110.1151466780100--


--===============1820046631==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1820046631==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1820046631==--
