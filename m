Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <ef9938ec0607121229y17e813d2oc27c33d3a339c3da@mail.gmail.com>
Date: Wed, 12 Jul 2006 12:29:58 -0700
From: "Albert Huang" <albert@csail.mit.edu>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20060712210553.dad90888.barthelemy.lemaire@gmail.com>
MIME-Version: 1.0
References: <20060712210553.dad90888.barthelemy.lemaire@gmail.com>
Subject: Re: [Bluez-devel] Compilation of a simple program (Debian Sid)
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1533756482=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1533756482==
Content-Type: multipart/alternative;
	boundary="----=_Part_7380_1414134.1152732598778"

------=_Part_7380_1414134.1152732598778
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

try without -ansi

-albert

On 7/12/06, barthelemy.lemaire@gmail.com <barthelemy.lemaire@gmail.com>
wrote:
>
> Hello all,
>
> I started Bluetooth Linux development yesterday and I'm having a problem
> in compiling the very simple program shown below :
>
> I'm running Debian Sid and the incriminated headers are in the
> libbluetooth2-dev package (Version: 3.1-1). Did I miss something? is there
> a bug in the package?
>
> Thanks in advance
>
> Barth
>
>
> bluetooth.c:
>
> #define EXIT_SUCCESS 0
>
> #include <stdlib.h>
> #include <netdb.h>
> #include <bluetooth/bluetooth.h>
> #include <bluetooth/hci.h>
> #include <bluetooth/hci_lib.h>
>
> int main ( int argc, char *argv[] )
> {
>         return EXIT_SUCCESS;
> }                               /* ----------  end of function
> main  ---------- */
>
>
> Makefile :
>
> CFLAGS = -Wall -ansi
> LDLAGS = -Wall -ansi
> EXEC = b
> LIBRARY= -lbluetooth
>
> $(EXEC):$(EXEC).o
>         gcc -o $@ $^
> $(EXEC).o:$(EXEC).c
>         gcc -o $@ -c $^ $(CFLAGS) $(LIBRARY)
>
>
> Here is the output :
>
> barth@debian:~/dev$ make
> gcc -o bluetooth.o -c bluetooth.c -Wall -ansi -lbluetooth
> In file included from bluetooth.c:23:
> /usr/include/bluetooth/bluetooth.h:113: error: expected '=', ',', ';',
> 'asm' or '__attribute__' before 'int'
> /usr/include/bluetooth/bluetooth.h:117: error: expected '=', ',', ';',
> 'asm' or '__attribute__' before 'void'
> In file included from bluetooth.c:25:
> /usr/include/bluetooth/hci_lib.h:137: error: expected '=', ',', ';', 'asm'
> or '__attribute__' before 'void'
> /usr/include/bluetooth/hci_lib.h:142: error: expected '=', ',', ';', 'asm'
> or '__attribute__' before 'void'
> /usr/include/bluetooth/hci_lib.h:147: error: expected '=', ',', ';', 'asm'
> or '__attribute__' before 'int'
> /usr/include/bluetooth/hci_lib.h:153: error: expected '=', ',', ';', 'asm'
> or '__attribute__' before 'void'
> /usr/include/bluetooth/hci_lib.h:157: error: expected '=', ',', ';', 'asm'
> or '__attribute__' before 'void'
> /usr/include/bluetooth/hci_lib.h:161: error: expected '=', ',', ';', 'asm'
> or '__attribute__' before 'void'
> /usr/include/bluetooth/hci_lib.h:165: error: expected '=', ',', ';', 'asm'
> or '__attribute__' before 'int'
> /usr/include/bluetooth/hci_lib.h:169: error: expected '=', ',', ';', 'asm'
> or '__attribute__' before 'void'
> /usr/include/bluetooth/hci_lib.h:173: error: expected '=', ',', ';', 'asm'
> or '__attribute__' before 'void'
> /usr/include/bluetooth/hci_lib.h:177: error: expected '=', ',', ';', 'asm'
> or '__attribute__' before 'void'
> /usr/include/bluetooth/hci_lib.h:181: error: expected '=', ',', ';', 'asm'
> or '__attribute__' before 'int'
> /usr/include/bluetooth/hci_lib.h:185: error: expected '=', ',', ';', 'asm'
> or '__attribute__' before 'void'
> /usr/include/bluetooth/hci_lib.h:189: error: expected '=', ',', ';', 'asm'
> or '__attribute__' before 'void'
> /usr/include/bluetooth/hci_lib.h:193: error: expected '=', ',', ';', 'asm'
> or '__attribute__' before 'void'
> /usr/include/bluetooth/hci_lib.h:197: error: expected '=', ',', ';', 'asm'
> or '__attribute__' before 'int'
> make: *** [bluetooth.o] Erreur 1
>
>
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
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>

------=_Part_7380_1414134.1152732598778
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

try without -ansi<br><br>-albert<br><br><div><span class="gmail_quote">On 7/12/06, <b class="gmail_sendername"><a href="mailto:barthelemy.lemaire@gmail.com">barthelemy.lemaire@gmail.com</a></b> &lt;<a href="mailto:barthelemy.lemaire@gmail.com">
barthelemy.lemaire@gmail.com</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Hello all,<br><br>I started Bluetooth Linux development yesterday and I'm having a problem in compiling the very simple program shown below :
<br><br>I'm running Debian Sid and the incriminated headers are in the libbluetooth2-dev package (Version: 3.1-1). Did I miss something? is there a bug in the package?<br><br>Thanks in advance<br><br>Barth<br><br><br>bluetooth.c
:<br><br>#define EXIT_SUCCESS 0<br><br>#include &lt;stdlib.h&gt;<br>#include &lt;netdb.h&gt;<br>#include &lt;bluetooth/bluetooth.h&gt;<br>#include &lt;bluetooth/hci.h&gt;<br>#include &lt;bluetooth/hci_lib.h&gt;<br><br>int main ( int argc, char *argv[] )
<br>{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return EXIT_SUCCESS;<br>}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* ----------&nbsp;&nbsp;end of function main&nbsp;&nbsp;---------- */<br><br><br>Makefile :<br><br>CFLAGS = -Wall -ansi<br>LDLAGS = -Wall -ansi<br>EXEC = b<br>LIBRARY= -lbluetooth
<br><br>$(EXEC):$(EXEC).o<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;gcc -o $@ $^<br>$(EXEC).o:$(EXEC).c<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;gcc -o $@ -c $^ $(CFLAGS) $(LIBRARY)<br><br><br>Here is the output :<br><br>barth@debian:~/dev$ make<br>gcc -o bluetooth.o -c bluetooth.c
 -Wall -ansi -lbluetooth<br>In file included from bluetooth.c:23:<br>/usr/include/bluetooth/bluetooth.h:113: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'int'<br>/usr/include/bluetooth/bluetooth.h:117: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'void'
<br>In file included from bluetooth.c:25:<br>/usr/include/bluetooth/hci_lib.h:137: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'void'<br>/usr/include/bluetooth/hci_lib.h:142: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'void'
<br>/usr/include/bluetooth/hci_lib.h:147: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'int'<br>/usr/include/bluetooth/hci_lib.h:153: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'void'
<br>/usr/include/bluetooth/hci_lib.h:157: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'void'<br>/usr/include/bluetooth/hci_lib.h:161: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'void'
<br>/usr/include/bluetooth/hci_lib.h:165: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'int'<br>/usr/include/bluetooth/hci_lib.h:169: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'void'
<br>/usr/include/bluetooth/hci_lib.h:173: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'void'<br>/usr/include/bluetooth/hci_lib.h:177: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'void'
<br>/usr/include/bluetooth/hci_lib.h:181: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'int'<br>/usr/include/bluetooth/hci_lib.h:185: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'void'
<br>/usr/include/bluetooth/hci_lib.h:189: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'void'<br>/usr/include/bluetooth/hci_lib.h:193: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'void'
<br>/usr/include/bluetooth/hci_lib.h:197: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'int'<br>make: *** [bluetooth.o] Erreur 1<br><br><br><br><br><br><br><br><br>-------------------------------------------------------------------------
<br>Using Tomcat but need to do more? Need to support web services, security?<br>Get stuff done quickly with pre-integrated technology to make your job easier<br>Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
<br><a href="http://sel.as-us.falkag.net/sel?cmd=lnk&amp;kid=120709&amp;bid=263057&amp;dat=121642">http://sel.as-us.falkag.net/sel?cmd=lnk&amp;kid=120709&amp;bid=263057&amp;dat=121642</a><br>_______________________________________________
<br>Bluez-devel mailing list<br><a href="mailto:Bluez-devel@lists.sourceforge.net">Bluez-devel@lists.sourceforge.net</a><br><a href="https://lists.sourceforge.net/lists/listinfo/bluez-devel">https://lists.sourceforge.net/lists/listinfo/bluez-devel
</a><br></blockquote></div><br>

------=_Part_7380_1414134.1152732598778--


--===============1533756482==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

--===============1533756482==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1533756482==--
