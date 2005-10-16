Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Johan Hedberg <johan.hedberg@nokia.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Python/Gtk2 test application for the new D-BUS interface
Message-ID: <20051016165415.GA31000@localhost.localdomain>
References: <20051014210539.GA20633@localhost.localdomain> <1129469396.24835.8.camel@blade>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1129469396.24835.8.camel@blade>
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
Date: Sun, 16 Oct 2005 19:54:15 +0300

On Sun, Oct 16, 2005, Marcel Holtmann wrote:
> it crashes with the name resolve on AMD64, but it is a great starting
> point.

There are some small changes to how name resolving is done in the latest
version (0.2) available here:
http://www.iki.fi/~jhedberg/bluez-python/

If you still get the crash, could you perhaps send a backtrace of it? (I
don't have a 64bit machine to reproduce it on).

Johan


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
