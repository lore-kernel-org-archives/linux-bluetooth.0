Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <5000105b0501070138cd4b4a8@mail.gmail.com>
From: Amit Kumar Goel <amitgoel25aug@gmail.com>
To: Bluez-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: [Bluez-devel] SDP & RFCOMM SYNC
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
Date: Fri, 7 Jan 2005 15:08:41 +0530

Hi frds,

I am working over SDP layer & i want to suport multiple profile over rfcomm.

I want to know how I can implement the following situation.

Already there is one rfcomm (ACL) connection with the remote device by
a profile .Other profile wants to make sdp session with the same
device.How can we send query request over the l2cap chanel?

If so, wat will happen after if sdp sends a disconnect request after query?

Regards 
Amit


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
