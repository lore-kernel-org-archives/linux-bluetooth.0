Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <685df2130711140953t75ed2dbm7d8b00ba2ec66031@mail.gmail.com>
Date: Wed, 14 Nov 2007 12:53:53 -0500
From: "Joshua Bryant" <josh@bryantweb.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-devel] Question about BDADDR_ANY
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hello,

With btsco, I could specifiy an adapter with the -i switch (btsco -i
hci1 11.22.33.44.55..66).

With the current dbus call, it seems the interface is chosen
automatically with BDADDR_ANY. I notice in headset.c, sco_connect uses
BDADDR_ANY as the adapter.

Where is BDADDR_ANY set and can it be changed through the api? Are
there plans to manually specify the interface in the dbus command
(audio.Headset.Connect) as was possible through btsco? If not, how
will I deal with multiple adapters under the newer dbus command set?

Thanks for your help,
Josh

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
