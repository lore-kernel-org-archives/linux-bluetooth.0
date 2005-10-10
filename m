Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: david <gangchen@mobilesoft.com.cn>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <1128906830.2417.1.camel@localhost.localdomain>
References: <1128906830.2417.1.camel@localhost.localdomain>
Content-Type: text/plain; charset=GB2312
Message-Id: <1128909236.2417.20.camel@localhost.localdomain>
Mime-Version: 1.0
Subject: [Bluez-devel] ttyS0 problem
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
Date: Mon, 10 Oct 2005 09:53:56 +0800

Hi marcel,

=D4=DA 2005-10-10=D2=BB=B5=C4 09:13 +0800=A3=ACdavid=D0=B4=B5=C0=A3=BA
> Hi David,
> =20
>  > I want to write some commands to the uart(ttyS0), but it fails.
>  > The steps are as follows:
>  > =20
>  > 1. hciattach ttyS0 texas
>  > 2. Open ttyS0 device again and get a fd, init ttyS0 with speed,
>  > flow_ctl and so on,then write a command(0x30) to the fd but return
>  > 0; That is nothing is written to ttyS0.
>  > =20
>  > If I write the same command  in the  function texas(int fd, struct
>  > uart_t *u, struct termios *ti), it succeeds.
>  > From bluez-utiles I see the following code which maybe
>  > the reason why I can't write the command to ttyS0 after running
>  > hciattach ttyS0 texas.
>  > =20
>  > /* Set TTY to N_HCI line discipline */
>  >  i =3D N_HCI;
>  >  if (ioctl(fd, TIOCSETD, &i) < 0) {
>  >   perror("Can't set line discipline");
>  >   return -1;
>  >  }
>  > =20
>  > It seems the codes is very important ,because if I delete these
>  > codes, the following codes can't run any more.
>  > =20
>  > Is there any method that I can write the command to the ttyS0
>  > successfully after step 1?
> =20
>  after step 1, you  must use the HCI raw socket to send commands. What
>  commands do you wanna send?
> =20
>  Regards
> =20
>  Marcel
=20

> What commands do you wanna send?
The command is HCI_GO_TO_SLEEP_IND(0x30) which is only one byte. It is a
vendor specific command used to ask the BT device to go to sleep. If BT
device receives the command, maybe it would response
HCILL_GO_TO_SLEEP_ACK(0x31) command to the host.

> after step 1, you  must use the HCI raw socket to send commands

Is this means we cannot write command to ttyS0 directly through write()
function?


Regards

David


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
