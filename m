Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Sumeet VERMA <sumeet.verma@st.com>
To: "'BlueZ users'" <bluez-users@lists.sourceforge.net>
Date: Wed, 25 Jul 2007 09:57:01 +0530
Message-ID: <01c001c7ce74$0cadbf70$832fc70a@dlh.st.com>
MIME-Version: 1.0
In-Reply-To: <EJENLMBEOLKAMCJFBFMDOEDMCAAA.leiyu@kcoe.cn>
Subject: [Bluez-users]
	=?gb2312?B?UkU6IFtCbHVlei11c2Vyc11SRaHqb2Nyb3NzLWNvbXBpbGUgYmx1ZQ==?=	=?gb2312?B?ei11dGlscy0zLjk=?=
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0905552920=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0905552920==
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable

Hi Leiyu,
Add another option --includedir and --libdir to the configure string=20
./configure --prefix=3D/bluez/bluez-uitls --host=3Darm-linux
--includedir=3D/bluez/bluez-libs/include =
--libdir=3D/bluez/bluez-libs/libs

Set the libdir and includedir path to whatever path you are using.




Regards,
Sumeet=20
-----Original Message-----
From: bluez-users-bounces@lists.sourceforge.net
[mailto:bluez-users-bounces@lists.sourceforge.net] On Behalf Of leiyu
Sent: Wednesday, July 25, 2007 9:52 AM
To: Bluez-Users
Subject: [Bluez-users]RE=A3=BAcross-compile bluez-utils-3.9

Dear All,

Last email I did not express the error clearly I write all the procedure =
as
below

I install bluez-libs-3.9 in /bluez/bluezlibs  then export
PKG_CONFIG_PATH=3D/bluez/bluezlibs/lib/pkgconfig

Enter into bluez-utils-3.9, configure then make it
 =20
./configure --prefix=3D/bluez/bluez-uitls --host=3Darm-linux make

but it happens some error, it prompt :
sdp-xml.c:36:27: bluetooth/sdp.h: no such file or directory
sdp-xml.c:37:31: bluetooth/sdp_lib.h: no such file or directory

But All the files exist in /bluez/bluez-libs/include directory, It seems
that I already include bluez-lib, Could anyone help me to fix it?
Thanks in advance!

Best regards,
Leiyu



--===============0905552920==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--===============0905552920==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0905552920==--
