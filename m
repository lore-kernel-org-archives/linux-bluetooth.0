Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bluez Ported on uClinux
From: Erwin Authried <eauth@softsys.co.at>
To: "bluez-users@lists.sourceforge.net" <bluez-users@lists.sourceforge.net>
In-Reply-To: <34ec511439101.heejune@snut.ac.kr>
References: <34ec511439101.heejune@snut.ac.kr>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1106299817.28779.188.camel@justakiss>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 21 Jan 2005 10:30:17 +0100

Am Fre, den 21.01.2005 schrieb =EC=95=88=ED=9D=AC=EC=A4=80 um 4:11:
>         Dear BlueZers,
>        =20
>         =20
>        =20
>         Recently I ported Bluez (kernel stack, and lib and utils) on
>         uClinux (Arm cored Conexant Network Processor Machine).=20
>        =20
>         Why? I couldn't find any port (usually the Makefiles) on the
>         web, and saw several unclearly answered questions on the
>         mailing list.=20
>        =20
>         =20
>        =20
>         Now, I works very well for PAN and SPP (which is my major
>         applications so far): however, it works excellent but It does
>         not work very well with Windows application provided my dongle
>         provider (CSR-based AirBird USB class 1).   Especially it take
>         too long time to make pan connection (around 30 secs), though
>         it it works ok after the long connection time.=20
>        =20
>         =20
>        =20
>         =20
>        =20
>         Here I ask some help request !
>        =20
>         =20
>        =20
>          -  Is there any way to make the ip assigning process
>         automatically?
>        =20
>         =20
>        =20
>              > pand --listen --master --role GN
>        =20
>         =20
>        =20
>             .....
>        =20
>         =20
>        =20
>              >ifconfig bnep0  192.168.7.1=20
>        =20
>         =20
>        =20
>              Is there any way to make the ifconfig automatically? =20
>        =20
>         =20
>        =20
>            =20
>        =20
>          -  I cannot handle shared library very well. So I am using it
>         with static library.=20
>        =20
>             Is there anyone who success with shared library in uClinux
>         and Bluez lib and utils?
>        =20
Hi,

for the uClinux port, no Makefile changes are required. You just need a
few options for "configure". Look at http://cvs.home.at/midori/sources/,
you can find the build scripts in bluez-libs-2.10 and bluez-utils-2.10.
=20
The ifconfig should be done in /etc/bluetooth/pan/dev-up. My script
looks like this:
------------------------
#!/bin/sh
# IP and BT_GATEWAY are exported from /etc/rc
ifconfig $1 $IP
test -z $BT_GATEWAY || route add default gw $BT_GATEWAY
------------------------
The script is called automatically by pand.=20
I'm not aware of shared library support for ARM.=20

Regards,
Erwin




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
