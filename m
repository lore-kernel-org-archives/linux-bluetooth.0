Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <9ec07a230512080854q1770cef1jcc17b16488ea3ca5@mail.gmail.com>
From: =?ISO-8859-1?Q?Israel_Gu=EDo?= <israzar@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_21471_1017124.1134060869677"
Subject: [Bluez-devel] incorrect power level
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
Date: Thu, 8 Dec 2005 17:54:29 +0100

------=_Part_21471_1017124.1134060869677
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi all,

I am measuring the transmit power level by means of hcitool and whilst the
power level is over 0, there is no problem. However, when the value should
be negative, I get a rather odd value, 252 for example.

I don't konw where the problem is, but i think the value is trated as
unsigned integer when it is signed. Please, if somebody observed this, tell
me so.

Thanks.

------=_Part_21471_1017124.1134060869677
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi all,<br><br>I am measuring the transmit power level by means of hcitool =
and whilst the power level is over 0, there is no problem. However, when th=
e value should be negative, I get a rather odd value, 252 for example.<br>
<br>I don't konw where the problem is, but i think the value is trated as u=
nsigned integer when it is signed. Please, if somebody observed this, tell =
me so.<br><br>Thanks.<br>

------=_Part_21471_1017124.1134060869677--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
