Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Apple mouse and disconnect problem
From: Marcel Holtmann <marcel@holtmann.org>
To: Chris Hubball <chris.hubball@csr.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <7D3093619D15A841A322413C3F138E0855C2F9@exchange02.csr.com>
References: <7D3093619D15A841A322413C3F138E0855C2F9@exchange02.csr.com>
Content-Type: text/plain
Message-Id: <1073320020.2508.17.camel@pegasus>
Mime-Version: 1.0
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
Date: Mon, 05 Jan 2004 17:27:00 +0100

Hi Chris,

> There is no defined "owner" of an ACL connection mainly because the
> L2CAP connections on top of it can be established by either end.
> 
> From general interop experience, if you close the last L2CAP connection
> on the ACL, you should also disconnect the ACL.  Not sure if you've got
> this feature, but it's also a nice idea to add a timeout before closing
> an ACL as it's common to open another L2CAP connection immediately after
> e.g. SDP search followed by HID.  This saves the paging time to re-open
> the ACL.

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




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
