Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <470B3979.4080301@free.fr>
References: <470A50E5.2090800@free.fr>
	<1191862220.12212.3.camel@aeonflux.holtmann.net>
	<470B3979.4080301@free.fr>
Date: Tue, 09 Oct 2007 10:45:24 +0200
Message-Id: <1191919524.31341.11.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] HFP design question : polls opened !
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

Hi Fabien,

> >> To ease the pain we could use the brand new GRegex tool, that brings the
> >> power of regular expressions to the glib world. That would meen however 
> >> that we would have to port it to eglib first.
> > 
> > it is okay to depend on GLib for certain things. Starting with 4.x we
> > will make GLib mandatory and remove eglib. However for the AT command
> > parsing, I might wanna have a self written parser. This way it is more
> > portable.
> 
> Marcel, there is no portability issue with GRegex : it is completely 
> self contained (no external deps added). ;-)

as I said, for BlueZ 4.x, no problem. Before that we have to see. Show
me example code for an AT parser. I purely will judge based on its
complexity.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
