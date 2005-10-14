Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Johan Hedberg <jhedberg@iki.fi>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20051014210539.GA20633@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-devel] Python/Gtk2 test application for the new D-BUS interface
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
Date: Sat, 15 Oct 2005 00:05:39 +0300

Hi,

In case someone is interested, I started developing a pygtk based test
application for the new D-BUS interface which we are working on. You can
get the first version here:
http://www.iki.fi/~jhedberg/bluez-python.tar.gz

Note that the code is in a very early stage. Currently it supports the
inquiry, periodic inquiry and remote name method calls and signals.

To execute the application, run bluez-python/btdbus.py

Johan


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
