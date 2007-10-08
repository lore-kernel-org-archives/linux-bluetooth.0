Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <470A50E5.2090800@free.fr>
Date: Mon, 08 Oct 2007 17:46:45 +0200
From: Fabien Chevalier <fabchevalier@free.fr>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] HFP design question : polls opened !
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


Dear Bluez friends,

Looks like HFP work will finally get started, thanks to Frederic 
Dalleau's initiative. :-)
For my part i will switch to that one day or the other, however at
the moment i am still working on some a2dp fixes and some other stuff, 
but i will get there eventually.

One of the painful issues with HFP is the AT commands parsing. I tend to
be a lazy guy and not very interested in writing a parser (hey we are in 
21th century now !! :-) )
To ease the pain we could use the brand new GRegex tool, that brings the
power of regular expressions to the glib world. That would meen however 
that we would have to port it to eglib first.

I don't know if this is a good idea or not, it's just an idea.
What do you guys think about it?

Cheers,

Fabien

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
