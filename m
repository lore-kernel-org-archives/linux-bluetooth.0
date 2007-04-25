Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Sumeet VERMA <sumeet.verma@st.com>
To: "Bluez devel" <bluez-devel@lists.sourceforge.net>
Date: Wed, 25 Apr 2007 12:28:06 +0530
Message-ID: <000101c78707$13a80dd0$8935c70a@dlh.st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0002_01C78735.2D6049D0"
Subject: [Bluez-devel] Esco implementation patch
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

------=_NextPart_000_0002_01C78735.2D6049D0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Marcel
I have done an implementation of esco in bluez kernel. I have hardcoded =
the settings of eSCO connection at the moment (packet type EV3).
Please review it and feel free to make modifications. This is working =
fine on my side. I changed the 2.6.20 kernel code.

Thanks and Regards,
Sumeet=20

------=_NextPart_000_0002_01C78735.2D6049D0
Content-Type: application/octet-stream;
	name="esco_patch.tgz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="esco_patch.tgz"

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
VFBBBRVUUEEFFVSwGf4HdHuYswBQAAA=

------=_NextPart_000_0002_01C78735.2D6049D0
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
------=_NextPart_000_0002_01C78735.2D6049D0
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

------=_NextPart_000_0002_01C78735.2D6049D0--
