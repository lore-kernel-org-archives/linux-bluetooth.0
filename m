Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <6297d67c0606262242q11b6e769r15a48f1edffaa759@mail.gmail.com>
Date: Tue, 27 Jun 2006 11:12:20 +0530
From: "Mayank Batra" <mayankbatra@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Subject: [Bluez-devel] Kernel Modules for ARM
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1114047369=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1114047369==
Content-Type: multipart/alternative;
	boundary="----=_Part_19888_19295860.1151386940215"

------=_Part_19888_19295860.1151386940215
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I am successfully able to cross-compile bluez-libs-2.25 and
bluez-utils-2.25for ARM.

But I feel that the kernel modules (like bluez.o, l2cap.o, rfcomm.o etc)
have not been built for ARM. (Or if they have been built somewhere, but I
can't find them)

So, if I say insmod bluez on my target, it says:

# insmod bluez
Using /lib/modules/kernel/bluez.o
insmod: ELF file not for this architecture
insmod: Could not load the module: Bad address

I have the feeling that the bluez.o is not an ELF file and it was not
generated during the cross compile.

Please help me out.

Thanks.

Regards,
Mayank

------=_Part_19888_19295860.1151386940215
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hi,</div>
<div>&nbsp;</div>
<div>I am successfully able to cross-compile bluez-libs-2.25 and bluez-utils-2.25 for ARM.</div>
<div>&nbsp;</div>
<div>But I feel that the kernel modules (like bluez.o, l2cap.o, rfcomm.o etc) have not been built for ARM. (Or if they have been built somewhere, but I can't find them)</div>
<div>&nbsp;</div>
<div>So, if I say insmod bluez on my target, it says:</div>
<div>&nbsp;</div>
<div># insmod bluez<br>Using /lib/modules/kernel/bluez.o<br>insmod: ELF file not for this architecture<br>insmod: Could not load the module: Bad address</div>
<div>&nbsp;</div>
<div>I have the feeling that the bluez.o is not an ELF file and it was not generated during the cross compile.</div>
<div>&nbsp;</div>
<div>Please help me out.</div>
<div>&nbsp;</div>
<div>Thanks.</div>
<div>&nbsp;</div>
<div>Regards,</div>
<div>Mayank</div>

------=_Part_19888_19295860.1151386940215--


--===============1114047369==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1114047369==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1114047369==--
