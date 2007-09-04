Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <db972f430709040351i156c63b3kc73b3020534e838c@mail.gmail.com>
Date: Tue, 4 Sep 2007 18:51:32 +0800
From: "Ricky Soh" <rickysoh@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] bccmd compilation fails (help needed)
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0014068773=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0014068773==
Content-Type: multipart/alternative;
	boundary="----=_Part_30420_21270310.1188903092681"

------=_Part_30420_21270310.1188903092681
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

during normal bluez-util-3.18 installation, bccmd in the "tools" folder was
not compiled.

i tried the following compilation but have the following error.

[root@localhost tools]# gcc -lusb -lbluetooth csr.c csr_3wire.c csr_bcsp.c
csr_h4.c csr_hci.c csr_usb.c ubcsp.c bccmd.c -o bccmd
csr_usb.c: In function =E2=80=98csr_open_usb=E2=80=99:
csr_usb.c:68: warning: assignment makes pointer from integer without a cast
csr_usb.c:68: error: dereferencing pointer to incomplete type
csr_usb.c:69: error: dereferencing pointer to incomplete type
csr_usb.c:69: error: dereferencing pointer to incomplete type
csr_usb.c:70: error: dereferencing pointer to incomplete type
csr_usb.c:70: error: =E2=80=98USB_CLASS_HUB=E2=80=99 undeclared (first use =
in this
function)
csr_usb.c:70: error: (Each undeclared identifier is reported only once
csr_usb.c:70: error: for each function it appears in.)
csr_usb.c:73: error: dereferencing pointer to incomplete type
csr_usb.c:74: error: dereferencing pointer to incomplete type
csr_usb.c:86: warning: assignment makes pointer from integer without a cast
csr_usb.c: In function =E2=80=98do_command=E2=80=99:
csr_usb.c:133: error: =E2=80=98USB_TYPE_CLASS=E2=80=99 undeclared (first us=
e in this
function)
csr_usb.c:133: error: =E2=80=98USB_RECIP_DEVICE=E2=80=99 undeclared (first =
use in this
function)

Please help.

Thanks.

------=_Part_30420_21270310.1188903092681
Content-Type: text/html; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,<br><br>during normal bluez-util-3.18 installation, bccmd in the &quot;t=
ools&quot; folder was not compiled. <br><br>i tried the following compilati=
on but have the following error.<br><br>[root@localhost tools]# gcc -lusb -=
lbluetooth=20
csr.c csr_3wire.c csr_bcsp.c csr_h4.c csr_hci.c csr_usb.c ubcsp.c bccmd.c -=
o bccmd<br>csr_usb.c: In function =E2=80=98csr_open_usb=E2=80=99:<br>csr_us=
b.c:68: warning: assignment makes pointer from integer without a cast<br>cs=
r_usb.c:68: error: dereferencing pointer to incomplete type
<br>csr_usb.c:69: error: dereferencing pointer to incomplete type<br>csr_us=
b.c:69: error: dereferencing pointer to incomplete type<br>csr_usb.c:70: er=
ror: dereferencing pointer to incomplete type<br>csr_usb.c:70: error: =E2=
=80=98USB_CLASS_HUB=E2=80=99 undeclared (first use in this function)
<br>csr_usb.c:70: error: (Each undeclared identifier is reported only once<=
br>csr_usb.c:70: error: for each function it appears in.)<br>csr_usb.c:73: =
error: dereferencing pointer to incomplete type<br>csr_usb.c:74: error: der=
eferencing pointer to incomplete type
<br>csr_usb.c:86: warning: assignment makes pointer from integer without a =
cast<br>csr_usb.c: In function =E2=80=98do_command=E2=80=99:<br>csr_usb.c:1=
33: error: =E2=80=98USB_TYPE_CLASS=E2=80=99 undeclared (first use in this f=
unction)<br>csr_usb.c:133: error: =E2=80=98USB_RECIP_DEVICE=E2=80=99 undecl=
ared (first use in this function)
<br><br>Please help.<br><br>Thanks.<br>

------=_Part_30420_21270310.1188903092681--


--===============0014068773==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--===============0014068773==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0014068773==--
