Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <6297d67c0606282357q5d228640yeba467999c9665a9@mail.gmail.com>
Date: Thu, 29 Jun 2006 12:27:21 +0530
From: "Mayank Batra" <mayankbatra@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <loom.20060628T185219-52@post.gmane.org>
MIME-Version: 1.0
References: <loom.20060628T033626-329@post.gmane.org>
	<6297d67c0606272053xff3b84dwf59410cce7bc658b@mail.gmail.com>
	<loom.20060628T185219-52@post.gmane.org>
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
Content-Type: multipart/mixed; boundary="===============1057509665=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1057509665==
Content-Type: multipart/alternative;
	boundary="----=_Part_42091_4076876.1151564241373"

------=_Part_42091_4076876.1151564241373
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Robert,

On 6/28/06, Robert Wlaschin <robertw@healthhero.com> wrote:
>
> To get past the dbus problem, if you don't already have the dbus source
> you'll
> need to get it from http://www.freedesktop.org/wiki/Software/dbus, after
> that


I've got the DBus sources, and it is working fine.

you'll need to get a new version of bluez-utils-3.1/acinclude.m4 from the
> bluez
> CVS -- there is a bug in this file that looks for the incorrect dbus libs.


I think that the CVS is down, can you please send it to me by mail?

Thanks.

Mayank

------=_Part_42091_4076876.1151564241373
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Robert,<br><br>
<div><span class="gmail_quote">On 6/28/06, <b class="gmail_sendername">Robert Wlaschin</b> &lt;<a href="mailto:robertw@healthhero.com">robertw@healthhero.com</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">To get past the dbus problem, if you don't already have the dbus source you'll<br>need to get it from <a href="http://www.freedesktop.org/wiki/Software/dbus">
http://www.freedesktop.org/wiki/Software/dbus</a>, after that</blockquote>
<div>&nbsp;</div>
<div>I've got the DBus sources, and it is working fine.</div><br>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">you'll need to get a new version of bluez-utils-3.1/acinclude.m4 from the bluez<br>CVS -- there is a bug in this file that looks for the incorrect dbus libs.
</blockquote>
<div>&nbsp;</div>
<div>I think that the CVS is down, can you please send it to me by mail?</div><br>Thanks.</div>
<div>&nbsp;</div>
<div>Mayank</div>

------=_Part_42091_4076876.1151564241373--


--===============1057509665==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1057509665==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1057509665==--
