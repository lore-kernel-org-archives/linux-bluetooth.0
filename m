Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-Id: <I9YCME$DFE1F4BA6EFCB5068110B7257B436297@uol.com.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
From: "omap" <omap@uol.com.br>
To: "bluez-devel" <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] HCIemu
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
Date: Fri,  7 Jan 2005 13:06:14 -0200



Hi folks,


I am trying to compile the HCIemu but
i am having the following error messages:

hciemu.c:956: error: invalid use of
undefined type `struct vhci_device'
hciemu.c:958: error: invalid use of
undefined type `struct vhci_device'
hciemu.c:959: error: invalid use of
undefined type `struct vhci_device'
hciemu.c:960: error: invalid use of
undefined type `struct vhci_device'
hciemu.c:963: warning: implicit
declaration of function `g_main_new'
hciemu.c:963: error: `FALSE'
undeclared (first use in this function)
hciemu.c:963: warning: assignment
makes pointer from integer without a cast
hciemu.c:973: error: invalid use of
undefined type `struct vhci_device'
hciemu.c:976: error: `G_IO_IN'
undeclared (first use in this function)
hciemu.c:981: warning: implicit
declaration of function `g_main_run'

should i enter anything else in the
make command line?


Thanks=0A =0A____________________________________________________________=
______________=0AAcabe com aquelas janelinhas que pulam na sua tela.=0AAn=
tiPop-up UOL - =C9 gr=E1tis!=0Ahttp://antipopup.uol.com.br/=0A



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
