Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Content-Type: text/plain
Message-Id: <1095867826.6223.48.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-devel] Improving the PIN request a little bit
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
Date: Wed, 22 Sep 2004 17:43:46 +0200

Hi,

I like to improve the PIN request stuff and my plan is to follow the
SuSE approach. Right now the hcid can use /etc/bluetooth/pin for
incoming connection or call the PIN helper. I like to move everything
into the PIN helper program and let this decide wether to return with a
fixed PIN from a file or call a GUI tool. This also means that I plan to
deprecated the Python based script and so remove the dependancy on
Python and Python-GTK. I like to have a simple shell script that may
call the bluez-pin binary or the KDE tool for it or whatever depending
on what is installed/configured and what desktop is running. If it fails
it falls back to the /etc/bluetooth/pin file and sends that string back
to the hcid. Comments?

Maybe it is also a good idea to do the same for the link key. Any ideas?

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
