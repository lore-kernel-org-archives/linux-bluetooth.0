Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Wed, 12 Jul 2006 21:53:01 +0200
From: bad_mr_frosty_be@yahoo.fr
To: bluez-devel@lists.sourceforge.net
Message-Id: <20060712215301.06650eba.bad_mr_frosty_be@yahoo.fr>
In-Reply-To: <ef9938ec0607121229y17e813d2oc27c33d3a339c3da@mail.gmail.com>
References: <20060712210553.dad90888.barthelemy.lemaire@gmail.com>
	<ef9938ec0607121229y17e813d2oc27c33d3a339c3da@mail.gmail.com>
Mime-Version: 1.0
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
Content-Type: multipart/mixed; boundary="===============0416709678=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0416709678==
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


You were right, the problem was the -ansi option

Thank you very much

Barth

On Wed, 12 Jul 2006 12:29:58 -0700
"Albert Huang" <albert@csail.mit.edu> wrote:

> try without -ansi
> 
> -albert
> 
> On 7/12/06, barthelemy.lemaire@gmail.com <barthelemy.lemaire@gmail.com>
> wrote:
> >
> > Hello all,
> >
> > I started Bluetooth Linux development yesterday and I'm having a problem
> > in compiling the very simple program shown below :
> >
> > I'm running Debian Sid and the incriminated headers are in the
> > libbluetooth2-dev package (Version: 3.1-1). Did I miss something? is there
> > a bug in the package?
> >
> > Thanks in advance
> >
> > Barth
> >
> >
> > bluetooth.c:
> >
> > #define EXIT_SUCCESS 0
> >
> > #include <stdlib.h>
> > #include <netdb.h>
> > #include <bluetooth/bluetooth.h>
> > #include <bluetooth/hci.h>
> > #include <bluetooth/hci_lib.h>
> >
> > int main ( int argc, char *argv[] )
> > {
> >         return EXIT_SUCCESS;
> > }                               /* ----------  end of function
> > main  ---------- */
> >
> >
> > Makefile :
> >
> > CFLAGS = -Wall -ansi
> > LDLAGS = -Wall -ansi
> > EXEC = b
> > LIBRARY= -lbluetooth
> >
> > $(EXEC):$(EXEC).o
> >         gcc -o $@ $^
> > $(EXEC).o:$(EXEC).c
> >         gcc -o $@ -c $^ $(CFLAGS) $(LIBRARY)
> >
> >
> > Here is the output :
> >
> > barth@debian:~/dev$ make
> > gcc -o bluetooth.o -c bluetooth.c -Wall -ansi -lbluetooth
> > In file included from bluetooth.c:23:
> > /usr/include/bluetooth/bluetooth.h:113: error: expected '=', ',', ';',
> > 'asm' or '__attribute__' before 'int'
> > /usr/include/bluetooth/bluetooth.h:117: error: expected '=', ',', ';',
> > 'asm' or '__attribute__' before 'void'
> > In file included from bluetooth.c:25:
> > /usr/include/bluetooth/hci_lib.h:137: error: expected '=', ',', ';', 'asm'
> > or '__attribute__' before 'void'
> > /usr/include/bluetooth/hci_lib.h:142: error: expected '=', ',', ';', 'asm'
> > or '__attribute__' before 'void'
> > /usr/include/bluetooth/hci_lib.h:147: error: expected '=', ',', ';', 'asm'
> > or '__attribute__' before 'int'
> > /usr/include/bluetooth/hci_lib.h:153: error: expected '=', ',', ';', 'asm'
> > or '__attribute__' before 'void'
> > /usr/include/bluetooth/hci_lib.h:157: error: expected '=', ',', ';', 'asm'
> > or '__attribute__' before 'void'
> > /usr/include/bluetooth/hci_lib.h:161: error: expected '=', ',', ';', 'asm'
> > or '__attribute__' before 'void'
> > /usr/include/bluetooth/hci_lib.h:165: error: expected '=', ',', ';', 'asm'
> > or '__attribute__' before 'int'
> > /usr/include/bluetooth/hci_lib.h:169: error: expected '=', ',', ';', 'asm'
> > or '__attribute__' before 'void'
> > /usr/include/bluetooth/hci_lib.h:173: error: expected '=', ',', ';', 'asm'
> > or '__attribute__' before 'void'
> > /usr/include/bluetooth/hci_lib.h:177: error: expected '=', ',', ';', 'asm'
> > or '__attribute__' before 'void'
> > /usr/include/bluetooth/hci_lib.h:181: error: expected '=', ',', ';', 'asm'
> > or '__attribute__' before 'int'
> > /usr/include/bluetooth/hci_lib.h:185: error: expected '=', ',', ';', 'asm'
> > or '__attribute__' before 'void'
> > /usr/include/bluetooth/hci_lib.h:189: error: expected '=', ',', ';', 'asm'
> > or '__attribute__' before 'void'
> > /usr/include/bluetooth/hci_lib.h:193: error: expected '=', ',', ';', 'asm'
> > or '__attribute__' before 'void'
> > /usr/include/bluetooth/hci_lib.h:197: error: expected '=', ',', ';', 'asm'
> > or '__attribute__' before 'int'
> > make: *** [bluetooth.o] Erreur 1
> >
> >
> >
> >
> >
> >
> >
> >
> > -------------------------------------------------------------------------
> > Using Tomcat but need to do more? Need to support web services, security?
> > Get stuff done quickly with pre-integrated technology to make your job
> > easier
> > Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> > http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> > _______________________________________________
> > Bluez-devel mailing list
> > Bluez-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/bluez-devel
> >
> 

	

	
		
___________________________________________________________________________ 
Yahoo! Mail réinvente le mail ! Découvrez le nouveau Yahoo! Mail et son interface révolutionnaire.
http://fr.mail.yahoo.com



--===============0416709678==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

--===============0416709678==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0416709678==--
