Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Jani Pellikka <jpellikk@ee.oulu.fi>
To: bluez-users@lists.sourceforge.net
Message-ID: <20041216125827.GB24108@ee.oulu.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] Bluez and threading
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
Date: Thu, 16 Dec 2004 14:58:27 +0200

Hi,

Is there support for threading in bluez?

For example, I have different threads for HCI inquering,
sending stuff via rfcomm socket and for listening incoming
rfcomm connections. Is it possible to do all this at the
same time in separate threads?

Right now, I have written C++ code using bluez libs for all
these threads but I get segmentation fault when I try to run
them at the same time. So, I wonder if it was possible to
thread these tasks at all.

Thanks in advance,

-- 
Jani


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
