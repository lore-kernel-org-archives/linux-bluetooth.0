Return-Path: <Chris.Hubball@csr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: [Bluez-devel] Apple mouse and disconnect problem
Date: Mon, 5 Jan 2004 16:52:33 -0000
Message-ID: <7D3093619D15A841A322413C3F138E0855C2FC@exchange02.csr.com>
From: "Chris Hubball" <Chris.Hubball@csr.com>
To: "Marcel Holtmann" <marcel@holtmann.org>
Cc: "BlueZ Mailing List" <bluez-devel@lists.sourceforge.net>
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel,

There shouldn't be any problems with both sides sending HCI_disconnect
at the same time.  When the connection closes, both sides receive
HCI_Disconnect_Complete whichever end detached.  They only part that may
be misleading is that the Error code may state that the other end closed
it when you thought you had!

Chris.

-----Original Message-----
From: Marcel Holtmann [mailto:marcel@holtmann.org]=20
Sent: 05 January 2004 16:27
To: Chris Hubball
Cc: BlueZ Mailing List
Subject: RE: [Bluez-devel] Apple mouse and disconnect problem


Hi Chris,

> There is no defined "owner" of an ACL connection mainly because the=20
> L2CAP connections on top of it can be established by either end.
>=20
> From general interop experience, if you close the last L2CAP=20
> connection on the ACL, you should also disconnect the ACL.  Not sure=20
> if you've got this feature, but it's also a nice idea to add a timeout

> before closing an ACL as it's common to open another L2CAP connection=20
> immediately after e.g. SDP search followed by HID.  This saves the=20
> paging time to re-open the ACL.

we got all these things, but we only take care of the ACL links that we
set up. If the other side reconnects to us and had to create an ACL link
(because none exists) we don't terminate the ACL link after the timeout.
So the question is if it is ok if both ends call hci_disconnect? Do you
have seen any problems both ends are trying to terminate the ACL link?
How do the link manager handles this? I can't find any valuable comment
in the specification or the profiles which end should terminate the ACL
link.

Regards

Marcel




**********************************************************************
This email and any files transmitted with it are confidential and
intended solely for the use of the individual or entity to whom they
are addressed. If you have received this email in error please notify
the system manager.

This footnote also confirms that this email message has been swept by
MIMEsweeper for the presence of computer viruses.

www.mimesweeper.com
**********************************************************************
