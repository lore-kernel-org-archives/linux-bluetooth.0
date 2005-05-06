Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Guylhem Aznar <bluez-devel@externe.net>
To: Dimitry Andric <dimitry@andric.com>
Cc: bluez-devel@lists.sourceforge.net, steve.crane@rococosoft.com
Subject: Re: [Bluez-devel] cross compiling bluez 2.16 for arm (Zaurus)
Message-ID: <20050506220621.GA21921@externe.net>
References: <20050505182213.GA22967@externe.net> <35666156.20050506103036@andric.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <35666156.20050506103036@andric.com>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 6 May 2005 18:06:21 -0400

On Friday,  6 May 2005 at 10:30:36 (+0200), Dimitry Andric wrote:
> This usually means there's something wrong with your toolchain.
> Please run exactly the same command line, but then with the "-v"
> option to arm-linux-gcc, and mail us the output.

Seems normal to me. And it could compile everything else. IMHO it's
more likely a problem with sdptool.

Reading specs from /opt/Embedix/tools/lib/gcc-lib/arm-linux/2.95.2/specs
gcc version 2.95.2 19991024 (release)
 /opt/Embedix/tools/lib/gcc-lib/arm-linux/2.95.2/cpp -lang-c -v -I. -I. -=
I.. -I/home/guylhem/bluez-libs-2.16//include -I/usr/include -D__GNUC__=3D=
2 -D__GNUC_MINOR__=3D95 -Dunix -Darm -Dlinux -D__ELF__ -Darm_elf -D__unix=
__ -D__arm__ -D__linux__ -D__ELF__ -D__arm_elf__ -D__unix -D__arm -D__lin=
ux -D__arm_elf -Asystem(unix) -Asystem(posix) -Acpu(arm) -Amachine(arm) -=
D__CHAR_UNSIGNED__ -D__OPTIMIZE__ -Wall -D__ARM_ARCH_4__ -D__APCS_32__ -D=
HAVE_CONFIG_H sdptool.c /tmp/ccHeRuYo.i
GNU CPP version 2.95.2 19991024 (release) (ARM GNU/Linux with ELF)
#include "..." search starts here:
#include <...> search starts here:
 .
 ..
 /home/guylhem/bluez-libs-2.16/include
 /usr/include
 /opt/Embedix/tools/lib/gcc-lib/arm-linux/2.95.2/include
 /opt/Embedix/tools/lib/gcc-lib/arm-linux/2.95.2/../../../../arm-linux/in=
clude
End of search list.
The following default directories have been omitted from the search path:
 /opt/Embedix/tools/arm-linux/include/g++-3
 /opt/Embedix/tools/lib/gcc-lib/arm-linux/2.95.2/../../../../arm-linux/sy=
s-include
End of omitted list.
 /opt/Embedix/tools/lib/gcc-lib/arm-linux/2.95.2/cc1 /tmp/ccHeRuYo.i -qui=
et -dumpbase sdptool.c -O2 -Wall -version -o /tmp/ccwaDwHF.s
GNU C version 2.95.2 19991024 (release) (arm-linux) compiled by GNU C ver=
sion 2.95.3 20010315 (release).
 /opt/Embedix/tools/arm-linux/bin/as -o sdptool.o /tmp/ccwaDwHF.s
/tmp/ccwaDwHF.s: Assembler messages:
/tmp/ccwaDwHF.s:1094: Error: bad instruction `rorw $8,r4'
/tmp/ccwaDwHF.s:1094: Error: bad instruction `rorl $16,r4'
/tmp/ccwaDwHF.s:1094: Error: bad instruction `rorw $8,r4'
/tmp/ccwaDwHF.s:1096: Error: bad instruction `rorw $8,r3'
/tmp/ccwaDwHF.s:1099: Error: bad instruction `rorw $8,r2'
/tmp/ccwaDwHF.s:1102: Error: bad instruction `rorw $8,r3'
/tmp/ccwaDwHF.s:1105: Error: bad instruction `rorw $8,r2'
/tmp/ccwaDwHF.s:1105: Error: bad instruction `rorl $16,r2'
/tmp/ccwaDwHF.s:1105: Error: bad instruction `rorw $8,r2'
/tmp/ccwaDwHF.s:1108: Error: bad instruction `rorw $8,r3'

--=20
Bien =E0 vous - Best regards,
Guylhem P. Aznar

--=20
*@externe.net                                            http://externe.n=
et
P=E9rim=E9/Deprecated:    @oeil.qc.ca, @metalab.unc.edu, @ibiblio.org, @7=
un.org
GPG: 92EB37C1 DD11C9C9 20519D01 E8FA1B11 42975AF7 http://externe.net/pubk=
ey


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
