Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Content-Type: text/plain
Message-Id: <1099024935.10164.11.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-devel] Service level security for RFCOMM
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
Date: Fri, 29 Oct 2004 06:42:15 +0200

Hi Folks,

actually it seems that nobody really cares about service level security
on the RFCOMM layer. Or people are too lazy to send in a patch. However,
I spent some hours with thinking about it and the core stuff of a small
framework for providing authentication and encrypt feedback from HCI to
higher level protocols is finished.

The problem now is to change the RFCOMM state machine to deal with it
and reject connections in the failure case. After looking at the state
machine of RFCOMM, I realized that there are two posibilities when to
trigger the authentication. One is after we receive the PN CMD and the
other after the SABM for the specific channel. The specification says
nothing about that. What are the pros and cons?

And btw, who is really interested in this feature or needs it?

Regards

Marcel




-------------------------------------------------------
This Newsletter Sponsored by: Macrovision 
For reliable Linux application installations, use the industry's leading
setup authoring tool, InstallShield X. Learn more and evaluate 
today. http://clk.atdmt.com/MSI/go/ins0030000001msi/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
