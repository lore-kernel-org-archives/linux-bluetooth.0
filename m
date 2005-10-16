Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Python/Gtk2 test application for the new D-BUS
	interface
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20051016211330.GA32013@localhost.localdomain>
References: <20051014210539.GA20633@localhost.localdomain>
	 <1129469396.24835.8.camel@blade>
	 <20051016165415.GA31000@localhost.localdomain>
	 <1129490655.24835.22.camel@blade>
	 <20051016211330.GA32013@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1129498153.24835.34.camel@blade>
Mime-Version: 1.0
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
Date: Sun, 16 Oct 2005 23:29:13 +0200

Hi Johan,

> > So how do I create a backtrace with Python for you?
> 
> I was thinking of the several lines of "traceback" information that
> python usually prints when the code does something bad. If the program
> is segfaulting without producing any other output I don't really have
> any expecrience in debugging that kind of problems. In the case that we
> have found a bug in the python D-BUS bindings debugging could be even
> harder.

I tested it on two machines running Ubuntu and both are crashing. One
was amd64 and one i386 based. So basically I think that the D-Bus is at
fault here. And there is no debugging output from Python. The only thing
I saw is an segmentation fault.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
