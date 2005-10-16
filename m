Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Johan Hedberg <johan.hedberg@nokia.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Python/Gtk2 test application for the new D-BUS interface
Message-ID: <20051016211330.GA32013@localhost.localdomain>
References: <20051014210539.GA20633@localhost.localdomain> <1129469396.24835.8.camel@blade> <20051016165415.GA31000@localhost.localdomain> <1129490655.24835.22.camel@blade>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1129490655.24835.22.camel@blade>
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
Date: Mon, 17 Oct 2005 00:13:30 +0300

Hi Marcel,

On Sun, Oct 16, 2005, Marcel Holtmann wrote:
> So how do I create a backtrace with Python for you?

I was thinking of the several lines of "traceback" information that
python usually prints when the code does something bad. If the program
is segfaulting without producing any other output I don't really have
any expecrience in debugging that kind of problems. In the case that we
have found a bug in the python D-BUS bindings debugging could be even
harder.

Johan



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
