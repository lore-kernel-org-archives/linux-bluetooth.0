Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Richard Pruen" <r.pruen@btinternet.com>
To: <dwest@cs.usyd.edu.au>, <bluez-users@lists.sourceforge.net>
Subject: RE: [Bluez-users] Using BlueZ for network access via ppp does notwork, nothing at all in log files
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Message-Id: <E1BFM71-0001hE-00@protactinium.btinternet.com>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 19 Apr 2004 00:54:12 +0100


>From: "David West"<dwest@cs.usyd.edu.au>

Hi David, 

>I had a similar problem to yours (see threads from last week).  I ended
>up solving it by uninstalling and reinstalling the bluez packages.

Thanks for the tip.

It turns out that the problems are with the XDA2. Installing a different stack on the XDA2 solved the problem. 

The microsoft stack doesn't work with network access, so is doomed from the start.

Richard



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
