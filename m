Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <6297d67c0606270347r35dd5e23i1b98fa6225008d5d@mail.gmail.com>
Date: Tue, 27 Jun 2006 16:17:45 +0530
From: "Mayank Batra" <mayankbatra@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.63.0606271146090.6782@redbean.intranet.gw-instruments.de>
MIME-Version: 1.0
References: <6297d67c0606262242q11b6e769r15a48f1edffaa759@mail.gmail.com>
	<1151393851.25011.7.camel@localhost>
	<6297d67c0606270126k2217235fwbc7fd3b56b1007dc@mail.gmail.com>
	<Pine.LNX.4.63.0606271146090.6782@redbean.intranet.gw-instruments.de>
Subject: Re: [Bluez-devel] Kernel Modules for ARM
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0022482344=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0022482344==
Content-Type: multipart/alternative;
	boundary="----=_Part_24993_11690813.1151405265175"

------=_Part_24993_11690813.1151405265175
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Peter,

On 6/27/06, Peter Wippich <pewi@gw-instruments.de> wrote:
>
>
> Have you tried to compile the kernel Modules as build in ?? This avoids
> all possible module path problems and stuff in the first place.


I've just recompiled my kernel, and now I am able to get the kernel modules
for BlueZ.

I also would recommend using a 2.6 kernel. We do not have any problems
> with it (at least not with the BlueZ part).


Ok...I'll try...but not now

Below is my build script for cross compiling bluez libs and utils. Maybe
> this helps.
> TARGET is set to arm-linux and XPREFIX is the path to the target device
> root on the build machine. Maybe this helps.
>
> Ciao,
>
> Peter


Thanks a lot for this script. But I've already cross-compiled the bluez-libs
and blue-utils. Anyways, I'll keep them with me for reference later on.
Actually, I almost did the steps written in the script. So, its good to have
them in a script.

Another problem that I am facing now is that when I do hcitool scan, I find
no devices whereas there are a lot of devices in the surroundings.
Another strange thing is that sdptool browse actually shows the services
present on the remote devices.
Also, if I register any service using sdptool, I can see it from a remote
device.
Any suggestion? Marcel?

Thanks.

Regards,
Mayank

------=_Part_24993_11690813.1151405265175
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Peter,<br><br>
<div><span class="gmail_quote">On 6/27/06, <b class="gmail_sendername">Peter Wippich</b> &lt;<a href="mailto:pewi@gw-instruments.de">pewi@gw-instruments.de</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid"><br>Have you tried to compile the kernel Modules as build in ?? This avoids<br>all possible module path problems and stuff in the first place.
</blockquote>
<div>&nbsp;</div>
<div>I've just recompiled my kernel, and now I am able to get the kernel modules for BlueZ.</div><br>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">I also would recommend using a 2.6 kernel. We do not have any problems<br>with it (at least not with the BlueZ part).
</blockquote>
<div>&nbsp;</div>
<div>Ok...I'll try...but not now</div><br>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Below is my build script for cross compiling bluez libs and utils. Maybe<br>this helps.<br>TARGET is set to arm-linux and XPREFIX is the path to the target device
<br>root on the build machine. Maybe this helps.<br><br>Ciao,<br><br>Peter</blockquote>
<div>&nbsp;</div>
<div>Thanks a lot for this script. But I've already cross-compiled the bluez-libs and blue-utils. Anyways, I'll keep them with me for reference later on. Actually, I almost did the steps written in the script. So, its good to have them in a script.
</div><br>Another problem that I am facing now is that when I do hcitool scan, I find no devices whereas there are a lot of devices in the surroundings.</div>
<div>Another strange thing is that sdptool browse actually shows the services present on the remote devices.</div>
<div>Also, if I register any service using sdptool, I can see it from a remote device.</div>
<div>Any suggestion? Marcel?</div>
<div>&nbsp;</div>
<div>Thanks.</div>
<div>&nbsp;</div>
<div>Regards,</div>
<div>Mayank</div>

------=_Part_24993_11690813.1151405265175--


--===============0022482344==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0022482344==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0022482344==--
