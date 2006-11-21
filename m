Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200611211504.42604.denis.kenzior@trolltech.com>
References: <200611211504.42604.denis.kenzior@trolltech.com>
Date: Tue, 21 Nov 2006 08:41:01 +0100
Message-Id: <1164094861.28429.13.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [PATCH] XML SDP Record Registration
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Denis,

> Attached is a patch that adds an expat based parser for parsing XML records.  
> I've also added a new API function AddServiceRecordAsXML (does the same thing 
> as AddServiceRecord, but in XML format) to the Manager hierarchy.  

looks good to me, but please follow the coding style of BlueZ. In your
you have way to many whitespace between function names and pointers etc.

> I've modified the service-agent example to take a new argument, --xmlfile, 
> which will attempt to register a record stored in an XML format.

Nice idea. I like that. The dbus_message_append_args() can actually add
more then one argument at a time, this is why it is called "args". And
please use mmap() for reading the XML file.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
