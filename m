Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050203140325.25498.qmail@web52810.mail.yahoo.com>
From: Peter van der Linden <pjotrdenstora@yahoo.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] Errorhandling in BCSP protocol?
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
Date: Thu, 3 Feb 2005 06:03:25 -0800 (PST)

Hi all,

I am working with an implementation that has BlueZ
running on a host processor and a CSR BlueCore02 as
Bluetooth chip. The host processor and BlueCore
communicate through BCSP protocol. The BCSP from BlueZ
regularly reports errors like:
bcsp_recv: Short BCSP packet
bcsp_recv: Checksum failed
bcsp_recv: Out-of-order packet arrived, got 1 expected
2
In these cases the BlueCore02 retransmits the BCSP
packet after a timeout.

My question: is there another mechanism than these
timeouts in BCSP protocol? Are BCSP packets that cause
these errormessages acknowledged over the BCSP link?
According to a BCSP protocol document I saw there
should e.g. be a means to send an acknowledgement with
the expected pacletnumber even when the wrong
pzcvketnumber is received. Is this implemented in
BlueZ?
I am running Linux version 2.4.18 with the latest
BlueZ package for that kernel version. The intention
is to switch to Linux 2.6, but not right now!
Regards,
Pjotr



		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - Find what you need with new enhanced search.
http://info.mail.yahoo.com/mail_250


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
