Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Nelson Murilo <nelson@pangeia.com.br>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] BlueZ libraries..
Message-ID: <20050202191134.GB2792@pangeia.com.br>
References: <de33c8be0502021102725d0022@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <de33c8be0502021102725d0022@mail.gmail.com>
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
Date: Wed, 2 Feb 2005 17:11:34 -0200


Try include netdb.h on top=20

On Wed, Feb 02, 2005 at 07:02:52PM +0000, Fl=E1vio wrote:
> Hi there!
> Hi have just installed the bluez libraries to start using them.
> I have made this simple program to test the includes:
>=20
> #include <bluetooth/bluetooth.h>
> #include <bluetooth/l2cap.h>
> #include <bluetooth/hci.h>
> #include <bluetooth/hci_lib.h>
>=20
> int main(void)
> {
> 	printf("teste");
> 	return 0;
>=20
> }
>=20
>=20
> But the result is:
> /usr/include/bluetooth/l2cap.h:46: error: syntax error before "sa_famil=
y_t"
> /usr/include/bluetooth/l2cap.h:49: error: syntax error before '}' token
> /usr/include/bluetooth/hci.h:1114: error: syntax error before "sa_famil=
y_t"
> /usr/include/bluetooth/hci.h:1116: error: syntax error before '}' token
>=20
> Can anyone please tell me what i am doing wrong?
> Thank you.
>=20
>=20
> -------------------------------------------------------
> This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
> Tool for open source databases. Create drag-&-drop reports. Save time
> by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
> Download a FREE copy at http://www.intelliview.com/go/osdn_nl
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
