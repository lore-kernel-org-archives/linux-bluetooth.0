Return-Path: <bluez-users-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Message-ID: <EFCD68F7BFDB06468769D4D9EAAA938705EE4718@scsmsx401.amr.corp.intel.com>
From: "Pering, Trevor" <trevor.pering@intel.com>
To: <bluez-users@lists.sourceforge.net>
Subject: [Bluez-users] PAN and DUN
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 19 Jan 2005 20:29:15 -0800

I'm confused by the how-to at
http://www.cs.ucla.edu/~cclljj/interest/notes/bluez/pand_dund.html --
which is linked from the BlueZ how-to page.
=20
It does a fair bit of setup, and then has the instructions:

13. on master side:=20
sdpd
pand --listen --master --service --sdp --role NAP
dund --listen --sdp

14. on slave side=20
sdpd
pand --connect <bt_addr> --sdp
dund --connect <bt_addr> --sdp

Which, is far as I can tell, is setting up both a dun and pan connection
between the two devices -- which seems very redundant to me. The DUN
link will set up an IP link over RFCOMM using PPP, while PAN will set up
a direct IP link.

Is this correct?  Wouldn't it be sufficient to either dun or pan, but
not both?

Thanks,
	Trevor


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
