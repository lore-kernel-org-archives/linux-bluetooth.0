Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <6297d67c0606270126k2217235fwbc7fd3b56b1007dc@mail.gmail.com>
Date: Tue, 27 Jun 2006 13:56:19 +0530
From: "Mayank Batra" <mayankbatra@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1151393851.25011.7.camel@localhost>
MIME-Version: 1.0
References: <6297d67c0606262242q11b6e769r15a48f1edffaa759@mail.gmail.com>
	<1151393851.25011.7.camel@localhost>
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
Content-Type: multipart/mixed; boundary="===============1699850044=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1699850044==
Content-Type: multipart/alternative;
	boundary="----=_Part_22290_27111281.1151396779371"

------=_Part_22290_27111281.1151396779371
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Marcel,

On 6/27/06, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> the kernel modules for BlueZ are part of the Linux kernel. Pick a recent
> kernel and you get all of them. And you should really go ahead with a
> 2.6 kernel. It is worth any initial trouble.


I already have a 2.4.21 kernel running, but I cannot see any of the kernel
modules for BlueZ, e.g. bluez.o, l2cap.o, rfcomm.o in the directory
/lib/modules/kernel.

So does that mean that my kernel was compiled without Bluetooth support?
- If yes, is there any way with which I can enable Bluetooth support? (Will
I have to recompile the kernel?)
- Or can I directly apply some patch by which I can get those kernel
modules?

Kindly advise.

Thanks.
Regards,
Mayank

------=_Part_22290_27111281.1151396779371
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Marcel,<br><br>
<div><span class="gmail_quote">On 6/27/06, <b class="gmail_sendername">Marcel Holtmann</b> &lt;<a href="mailto:marcel@holtmann.org">marcel@holtmann.org</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">the kernel modules for BlueZ are part of the Linux kernel. Pick a recent<br>kernel and you get all of them. And you should really go ahead with a
<br>2.6 kernel. It is worth any initial trouble.</blockquote>
<div>&nbsp;</div>
<div>I already have a 2.4.21 kernel running, but I cannot see any of the kernel modules for BlueZ, e.g. bluez.o, l2cap.o, rfcomm.o in the directory /lib/modules/kernel.</div>
<div>&nbsp;</div>
<div>So does that mean that my kernel was compiled without Bluetooth support?</div>
<div>- If yes, is there any way with which I can enable Bluetooth support? (Will I have to recompile the kernel?)</div>
<div>- Or can I directly apply some patch by which I can get those kernel modules?</div>
<div>&nbsp;</div>
<div>Kindly advise.</div>
<div>&nbsp;</div>
<div>Thanks.</div>
<div>Regards,</div>
<div>Mayank</div><br>&nbsp;</div>

------=_Part_22290_27111281.1151396779371--


--===============1699850044==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1699850044==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1699850044==--
