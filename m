Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <470A50E5.2090800@free.fr>
References: <470A50E5.2090800@free.fr>
Date: Mon, 08 Oct 2007 18:50:20 +0200
Message-Id: <1191862220.12212.3.camel@aeonflux.holtmann.net>
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

> Looks like HFP work will finally get started, thanks to Frederic 
> Dalleau's initiative. :-)
> For my part i will switch to that one day or the other, however at
> the moment i am still working on some a2dp fixes and some other stuff, 
> but i will get there eventually.
> 
> One of the painful issues with HFP is the AT commands parsing. I tend to
> be a lazy guy and not very interested in writing a parser (hey we are in 
> 21th century now !! :-) )
> To ease the pain we could use the brand new GRegex tool, that brings the
> power of regular expressions to the glib world. That would meen however 
> that we would have to port it to eglib first.

it is okay to depend on GLib for certain things. Starting with 4.x we
will make GLib mandatory and remove eglib. However for the AT command
parsing, I might wanna have a self written parser. This way it is more
portable.

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
