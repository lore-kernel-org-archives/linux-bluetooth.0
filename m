Return-Path: <bluez-users-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="GB2312"
Message-ID: <E36E0C5C92D97049B4855B5498A9454790E93B@weshml02.winbond.com.tw>
From: "PC32 YPXin" <YPXin@Winbond.com.tw>
To: <bluez-users@lists.sourceforge.net>
Subject: [Bluez-users] Make a local network using two Bluetooth USB Dongle
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sun, 9 May 2004 11:56:25 +0800

Dear All:
	I have made a File Transfer using two Bluetooth USB Dongle(which is =
Bigabyte supporting Bluetooth Spec v1.1) between a linux box and windows =
machine.
	In windows, I can find the BlueDevice in linux and its service(such as =
Audio Gateway, include File Transfer), but I cannot transfer to linux, =
because timeout.
=09
	I do that as the document from bluez.org:
		Get the kernel 2.4.20, and patch it.
		then compile with support Bluetooth:
				<M> L2CAP
				<M> SCO links
				<M>RFCOMM
				<M>BNEP
			Bluetooth device drivers:
				<M>HCI USB driver
				<M>HCI UART driver
				<M>HCI BlueFRITZ! USB driver
				<M>HCI VHCI driver

	make, make install,make modules,make modules_install
	then reboot
	install the bluetools from bluez.org
	and ln /usr/sbin/hcid /sbin/hcid
	/etc/init.d/bluetooth start
	and get [OK];
	Then let windows to search the device, and found it, got its service, =
it was ok. Then transfer file, but failed.
	This is log from hcidump:
=09
		> HCI Event: Connect Request(0x04) plen 10
		< HCI Command: Accept Connection Request(0x01|0x0009) plen 7
		> HCI Event: Command Status(0x0f) plen 4
		> HCI Event: Connect Complete(0x03) plen 11
		< HCI Command: Write Link Policy Settings(0x02|0x000d) plen 4
		> HCI Event: Page Scan Repetition Mode Change(0x20) plen 7
		> HCI Event: Command Complete(0x0e) plen 6
		< HCI Command: Change Connection Packet Type(0x01|0x000f) plen 4
		> HCI Event: Max Slots Change(0x1b) plen 3
		> HCI Event: Command Status(0x0f) plen 4
		> HCI Event: Connection Packet Type Changed(0x1d) plen 5
		> ACL data: handle 0x0028 flags 0x02 dlen 12
		    L2CAP(s): Connect req: psm 1 scid 0x0049
		> HCI Event: Disconn Complete(0x05) plen 4                             =
                 =20
                                   =20

	I don't know why the L2Cap(s): Connect req broken?
	Very Thanks

		YPXin

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3DThe privileged confidential=
 information contained in this email is intended for use only by the addres=
sees as indicated by the original author of this email. If you are not the =
addressee indicated in this email or are not responsible for delivery of th=
e email to such person, please kindly reply the sender indicating according=
ly and delete all copies of it from your computer and network server immedi=
ately. We thank you for your cooperation. It is advisable that any unauthor=
ized use of confidential information of Winbond is strictly prohibited; and=
 any information in this email that does not relate to the official busines=
s of Winbond shall be deemed as neither given nor endorsed by Winbond.=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3DIf your computer is unable to =
decode Chinese font, please ignore the following message. They essentially =
repeat the&nbsp; English statement above.=A5=BB=ABH=A5=F3=A4=BA=A9=D2=A7t=
=B5=D8=A8=B9=B9q=A4l=AA=BA=B0]=B2=A3=A9=CA=BE=F7=B1K=A9=CA=B8=EA=B0T, =B6=
=C8=B1=C2=C5v=AD=EC=B5o=ABH=A4H=AB=FC=A9w=A4=A7=A6=AC=ABH=A4H=A8=FA=BE\=A4=
=A7=A5=CE. =B0=B2=A8=CF=B1z=A8=C3=ABD=B3Q=AB=FC=A9w=A4=A7=A6=AC=ABH=A4H=A9=
=CE=A6]=A5=F4=A6=F3=AD=EC=A6]=A6b=A5=BC=B8g=B1=C2=C5v=AA=BA=B1=A1=A7=CE=A4=
=A7=A4U=A6=AC=A8=EC=A5=BB=ABH=A5=F3, =BD=D0=B1z=A7i=AA=BE=AD=EC=B5o=ABH=A4H=
=A8=C3=A5=DF=A7Y=B1N=ABH=A5=F3=B1q=B9q=B8=A3=BBP=BA=F4=B8=F4=A6=F8=AAA=BE=
=B9=A4=A4=A4=A9=A5H=AE=F8=B0=A3. =B9=EF=A9=F3=B1z=AA=BA=A6X=A7@, =A7=DA=AD=
=CC=A5=FD=A6=B9=ADP=C1=C2. =AFS=A6=B9=B4=A3=BF=F4, =A5=F4=A6=F3=A5=BC=B8g=
=B1=C2=C5v=BE=D5=A6=DB=A8=CF=A5=CE=B5=D8=A8=B9=B9q=A4l=AA=BA=BE=F7=B1K=B8=
=EA=B0T=AA=BA=A6=E6=AC=B0=ACO=B3Q=C4Y=AE=E6=B8T=A4=EE=AA=BA. =ABH=A5=F3=BBP=
=B5=D8=A8=B9=B9q=A4l=C0=E7=B7~=B5L=C3=F6=A4=A7=A4=BA=AEe,=A4=A3=B1o=B5=F8=
=AC=B0=B5=D8=A8=B9=B9q=A4l=A4=A7=A5=DF=B3=F5=A9=CE=B7N=A8=A3.=0D


-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
