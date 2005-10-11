Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: david <gangchen@mobilesoft.com.cn>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <1129010637.2346.1.camel@localhost.localdomain>
References: <1129010637.2346.1.camel@localhost.localdomain>
Content-Type: text/plain; charset=GB2312
Message-Id: <1129012750.2346.33.camel@localhost.localdomain>
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
Date: Tue, 11 Oct 2005 14:39:10 +0800

Hi marcel,

=D4=DA 2005-10-11=B6=FE=B5=C4 14:03 +0800=A3=ACdavid=D0=B4=B5=C0=A3=BA
>  Hi David,

>  > I want to write some commands to the uart(ttyS0), but it fails.
 >  > The steps are as follows:
 >  > =20
 >  > 1. hciattach ttyS0 texas
 >  > 2. Open ttyS0 device again and get a fd, init ttyS0 with speed,
 >  > flow_ctl and so on,then write a command(0x30) to the fd but return
 >  > 0; That is nothing is written to ttyS0.
 >  > =20
> marcel write,=20
>  > > What commands do you wanna send?
>  > The command is HCI_GO_TO_SLEEP_IND(0x30) which is only one byte. It is=
 a
>  > vendor specific command used to ask the BT device to go to sleep. If B=
T
>  > device receives the command, maybe it would response
>  > HCILL_GO_TO_SLEEP_ACK(0x31) command to the host.
> =20
>  do you have the specification of these vendor commands? Is this command
>  according to the HCI specification or is it an extension of the H:4
>  transport protocol?
> =20
>  > > after step 1, you  must use the HCI raw socket to send commands
>  >=20
>  > Is this means we cannot write command to ttyS0 directly through write(=
)
>  > function?
> =20
>  After calling hciattach the kernel takes over the serial port via the
>  line discipline and the reads and writes are useless.
> =20
>  Regards
> =20
>  Marcel



Now, I can write command(0x30) to ttyS0 driectly after hciattach tty0
texas(assume step 1);
The function is as follows(assume step 2):

static int write_cmd_to_ttyS0()

{
                int fdd;
                int len;
                char cmd[5];
                int temp;
                int dd;
   =20
                fdd =3D open("/dev/ttyS0", O_RDWR | O_NOCTTY);
                if (fdd < 0) {
                        printf("Can't open serial port, fd =3D %d\n",fdd);
                        return -1;
       		  }
                else
                        printf("open serial ok, fd =3D %d\n", fdd);
             =20
		  temp =3D 0;
                if (ioctl(fdd, TIOCSETD, &temp) < 0) {
                        perror("Can't set line discipline");
                        return -1;
                  }

                cmd[0] =3D 0x30;//HCILL_GO_TO_SLEEP_IND

                len =3D write(fdd, cmd, 1);
                printf("write %d byte\n", len);
                len =3D read(fdd, cmd, 1);
                printf("read %d byte cmd[0] =3D %d\n", len, cmd[0]);

                temp =3D N_HCI;
                if (ioctl(fdd, TIOCSETD, &temp) < 0) {
                        perror("Can't set line discipline");
                        return -1;
                }
                if (ioctl(fdd, HCIUARTSETPROTO, 0) < 0) {
                        perror("Can't set device");
                        return -1;
                }
 }            =20

After step 2,  step3 and step 4 run successfully.=20

step 3: hciconfig hci0 up
step 4: hcitool scan

If I change the steps as follows, an error occures in step 4, the error
is "Device is not available". Do you know why? How can I step 4 can run
successfully after step 3?

step 1: hciattach ttyS0 texas
Step 2: hciconfig hci0 up
step 3: write_cmd_to_ttyS0()
step 4: hcitool scan

/*** cmd_scan() ****/
   if (dev_id < 0) {
                dev_id =3D hci_get_route(NULL);
                if (dev_id < 0) {
                        perror("Device is not available");
                        exit(1);
                }
        }
/**********************/




Regards,

David



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
