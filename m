Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [gbluezconf] D-Bus client prototype
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e1effdeb0601261259h7eb14f95wc315f53a2c0baa14@mail.gmail.com>
References: <e1effdeb0512201427g43906c29g78a8ce4fcdc3c71a@mail.gmail.com>
	 <1135120979.26233.40.camel@localhost>
	 <e1effdeb0512211051i63f7e734jac900d5fd9ab70ca@mail.gmail.com>
	 <1135192627.25328.8.camel@localhost>
	 <e1effdeb0601261259h7eb14f95wc315f53a2c0baa14@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1138309764.5901.153.camel@localhost>
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
Date: Thu, 26 Jan 2006 22:09:24 +0100

Hi Claudio,

> A new prototype version is available at:
> http://www.cin.ufpe.br/~ckt/gbluezconf/gbluezconf-00.04.tar.gz

you still depend on a "bluetooth/dbus.h" file that is not part of BlueZ
yet. Why don't you include a copy of it?

The error looks like this:

pair.c:41:28: error: bluetooth/dbus.h: No such file or directory
pair.c: In function '_dbus_pair_hci_signal_filter_cb':
pair.c:516: error: 'DEV_HCI_INTERFACE' undeclared (first use in this function)
pair.c:516: error: (Each undeclared identifier is reported only once
pair.c:516: error: for each function it appears in.)
...

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
