Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <de33c8be0502021102725d0022@mail.gmail.com>
From: =?ISO-8859-1?Q?Fl=E1vio?= <flavio.henriques@gmail.com>
To: bluez-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: [Bluez-devel] BlueZ libraries..
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
Date: Wed, 2 Feb 2005 19:02:52 +0000

Hi there!
Hi have just installed the bluez libraries to start using them.
I have made this simple program to test the includes:

#include <bluetooth/bluetooth.h>
#include <bluetooth/l2cap.h>
#include <bluetooth/hci.h>
#include <bluetooth/hci_lib.h>

int main(void)
{
	printf("teste");
	return 0;

}


But the result is:
/usr/include/bluetooth/l2cap.h:46: error: syntax error before "sa_family_t"
/usr/include/bluetooth/l2cap.h:49: error: syntax error before '}' token
/usr/include/bluetooth/hci.h:1114: error: syntax error before "sa_family_t"
/usr/include/bluetooth/hci.h:1116: error: syntax error before '}' token

Can anyone please tell me what i am doing wrong?
Thank you.


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
