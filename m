Return-Path: <bluez-devel-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: [Bluez-devel] Apple mouse and disconnect problem
Message-ID: <7D3093619D15A841A322413C3F138E0855C2F9@exchange02.csr.com>
From: "Chris Hubball" <Chris.Hubball@csr.com>
To: <bluez-devel@lists.sourceforge.net>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 5 Jan 2004 16:07:16 -0000

Hi,

There is no defined "owner" of an ACL connection mainly because the
L2CAP connections on top of it can be established by either end.

>From general interop experience, if you close the last L2CAP connection
on the ACL, you should also disconnect the ACL.  Not sure if you've got
this feature, but it's also a nice idea to add a timeout before closing
an ACL as it's common to open another L2CAP connection immediately after
e.g. SDP search followed by HID.  This saves the paging time to re-open
the ACL.

Chris.

-------- Original Message --------
Subject: [Bluez-devel] Apple mouse and disconnect problem
Date: Sun, 21 Dec 2003 02:52:32 +0100
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>

Hi Folks,

I played with the Apple Bluetooth mouse and I had a problem with the
termination of the ACL link after the two L2CAP channels are closed. The
ACL link still stays there, but not always. After a long time of testing
and tracking possible errors I found that the Apple mouse itself never
terminates the ACL link (like it does not role switch itself or go to
sniff mode after idle time). So the host stack has to terminate the ACL
link if no other L2CAP connection is open. In the case of BlueZ we do
this only for outgoing and not for incoming ones. And this means that if
the mouse reconnects the ACL link will never closed if we terminate the
connection because of idle time or because the bthid daemon was shut
down. I looked through the revisions of the HCI core code, but we never
close the ACL link if the connection was not created by us and so I must
assume that no one else had this problem before. However the relevant
code is in include/net/bluetooth/hci_core.h

	static inline void hci_conn_put(struct hci_conn *conn)
	{
	        if (atomic_dec_and_test(&conn->refcnt)) {
	                if (conn->type =3D=3D SCO_LINK)
	                        hci_conn_set_timer(conn, HZ / 100);
	                else if (conn->out)
	                        hci_conn_set_timer(conn,
HCI_DISCONN_TIMEOUT);
	        }
	}

My question is now, why we only initiate the disconnect timer for
outgoing connections? Is the device that creates the ACL link also
responsible for its termination? If yes, why the hell is the Bluetooth
stack on the Apple mouse not doing this and how did this device then got
qualified?

I used the attached patch and everything seems to be ok. Any comments?

Regards

Marcel




--=20


**********************************************************************
This email and any files transmitted with it are confidential and
intended solely for the use of the individual or entity to whom they
are addressed. If you have received this email in error please notify
the system manager.

This footnote also confirms that this email message has been swept by
MIMEsweeper for the presence of computer viruses.

www.mimesweeper.com
**********************************************************************



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
