Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Sumeet VERMA <sumeet.verma@st.com>
To: "'leiyu'" <leiyu@kcoe.cn>,
        "'Bluez-Users'" <bluez-users@lists.sourceforge.net>
Date: Wed, 25 Jul 2007 12:33:12 +0530
Message-ID: <01d601c7ce89$dde062e0$832fc70a@dlh.st.com>
MIME-Version: 1.0
In-Reply-To: <EJENLMBEOLKAMCJFBFMDGEDNCAAA.leiyu@kcoe.cn>
Subject: [Bluez-users]
	=?gb2312?B?UkU6IFtCbHVlei11c2Vyc11SRT+oum9jcm9zcy1jb21waWxlIGJsdWV6LXU=?=	=?gb2312?B?dGlscy0zLjk=?=
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0817527117=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0817527117==
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable

Hi Leiyu
I don=A1=AFt know the exact problem but I can suggest changing the =
environment
variable LD_LIBRARY_PATH
$ export  LD_LIBRARY_PATH=3D/bluez/bluez-libs/lib

Try this. Probably it should work.


Regards,
Sumeet=20
-----Original Message-----
From: leiyu [mailto:leiyu@kcoe.cn]=20
Sent: Wednesday, July 25, 2007 12:17 PM
To: Bluez-Users; sumeet
Subject: RE: [Bluez-users]RE=A1=EAocross-compile bluez-utils-3.9

Dear Sumeet,

I add the option --includedir and --libdir to the configure string
./configure --prefix=3D/bluez/bluez-uitls --host=3Darm-linux
--includedir=3D/bluez/bluez-libs/include =
--libdir=3D/bluez/bluez-libs/lib

but it have the same error
sdp-xml.c:36:27: bluetooth/sdp.h: no such file or directory
sdp-xml.c:37:31: bluetooth/sdp_lib.h: no such file or directory

it's  very strange,  I feel ashamed to bother you again , thank you very
much

Best regards,
Leiyu=20




--===============0817527117==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--===============0817527117==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0817527117==--
