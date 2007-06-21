Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Thu, 21 Jun 2007 08:07:49 +0000 (GMT)
From: leconte.michel@cegetel.net
To: bluez-users@lists.sourceforge.net
Message-id: <ebd5c02d6fa8.467a31d5@cegetel.net>
MIME-version: 1.0
Subject: [Bluez-users] Understand an HCI command
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2099088467=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============2099088467==
Content-type: text/html; charset=us-ascii
Content-language: fr
Content-transfer-encoding: quoted-printable
Content-disposition: inline

Hi all=2C=3CBR=3E=3CBR=3Eto initialize the HCI/UART channel between a Se=
mtech-Xemics bluetooth kit=3CBR=3Eand a Host (Xscale) I use the command =
=22hciattach=22=2E In this programm=2C I add a specific=3CBR=3Evendor HC=
I command to change the baud rate of the UART at the bluetooth side=2E  =
    =3CBR=3E=3CBR=3EWith a numeric analyser=2C I look at the hci flow af=
ter the command =22hciattach=22 =3CBR=3Ebetween the host and the bluetoo=
th kit=2E Here=27s what I observe =3A    =3CBR=3E=3CBR=3E1=2E I see a fi=
rst HCI command frame ( the vendor HCI command to change the UART baud r=
ate)=3CBR=3E	from Host to bluetooth circuit=2E For this specific command=
=2C the bluetooth circuit does not respond=2E=3CBR=3E=3CBR=3E2=2E I see =
a second HCI command frame of 4 bytes length (frome Host to bluetooth ci=
rcuit) =3A=3CBR=3E=3CBR=3E=3CBR=3E	HCI=5FCOMMAND=5FPACKET	 OCF	  OGF	=3C=
BR=3E		0x01 			0x03	 0x10     0x00	     =3CBR=3E	=3CBR=3E=3CBR=3E3=2E Th=
e bluetooth circuit responds with the following frame =3A=3CBR=3E=3CBR=3E=
=3CBR=3E	HCI=5FEVENT=5FPKT  EVENT=5FCODE  DATA LENGTH   RECALL the comma=
nd=3CBR=3E		0x04		  0x0E		  0x0C		0X01 0x03 0x10 0x00   0xFF 0xFF 0xBD 0=
xF8 0x1B 0x18 0x00 0x00=3CBR=3E=3CBR=3E=3CBR=3E=3CBR=3EFirst=2C I wonder=
 where does come from the HCI command with an OCF=3D0x03 and an OGF=3D0x=
10=2E It=27s not a normalized hci command=2E=3CBR=3EIs it a specific com=
mand from the linux kernel or from bluez =3F=3F=3CBR=3E=3CBR=3EWhere can=
 I found information about this command and its reply =3F=3CBR=3E=3CBR=3E=
=3CBR=3E=3CBR=3Ethanks for any idea or information which can help me=2E=3C=
BR=3E=3CBR=3Eregards=2E=3CBR=3E=3CBR=3E=3CBR=3EMichel=3Cbr=3E=3Cbr=3E=3C=
br=3E=3Cbr=3E-----------------------------------------------------------=
-----=3Cbr=3EAvec Neuf=2C on peut envoyer jusqu=27=26agrave=3B 9Go par m=
ail=2E=3Cbr=3EDecouvrez Neuf Giga=3Cbr=3E=3Ca href=3D=22http=3A//www=2En=
eufgiga=2Ecom/=22=3Ehttp=3A//www=2Eneufgiga=2Ecom=3C/a=3E


--===============2099088467==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============2099088467==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============2099088467==--
