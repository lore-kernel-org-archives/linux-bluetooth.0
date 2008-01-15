Return-Path: <cyrus@holtmann.org>
Date: Tue, 15 Jan 2008 17:51:41 -0500 (EST)
From: Tim Smith <tsmith@cs.toronto.edu>
To: bluez-devel@lists.sourceforge.net
Message-ID: <Pine.LNX.4.64.0801151725390.6831@apps0.cs.toronto.edu>
MIME-Version: 1.0
Subject: [Bluez-devel] L2CAP retransmission and flow control
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi all,

I've gotten the impression from various postings here that:

- L2CAP retransmission is not considered necessary because baseband
retransmission effectively provides a reliable physical transport.

- L2CAP flow control is not considered necessary because applications 
requiring flow control can use RFCOMM (which provides flow control).

- Due to L2CAP retransmission and flow control not being considered 
necessary, implementation of them is not considered a high priority 
activity.

Marcel, can you confirm, deny, or expand on the above?


Thanks,
Tim Smith

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
