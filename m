Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bluez and threading
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20041216125827.GB24108@ee.oulu.fi>
References: <20041216125827.GB24108@ee.oulu.fi>
Content-Type: text/plain
Message-Id: <1103227046.6325.8.camel@notepaq>
Mime-Version: 1.0
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
Date: Thu, 16 Dec 2004 20:57:25 +0100

Hi Jani,

> Is there support for threading in bluez?

the simple answer is yes.

> For example, I have different threads for HCI inquering,
> sending stuff via rfcomm socket and for listening incoming
> rfcomm connections. Is it possible to do all this at the
> same time in separate threads?

The kernel will handle this. If not, it is a bug.

> Right now, I have written C++ code using bluez libs for all
> these threads but I get segmentation fault when I try to run
> them at the same time. So, I wonder if it was possible to
> thread these tasks at all.

Check your own code first, because I don't think that it is a problem of
the BlueZ library of kernel.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
