Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] bluetooth socket + rfcomm tty
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0501291742500.13497-100000@antilope>
References: <Pine.LNX.4.44.0501291742500.13497-100000@antilope>
Content-Type: text/plain
Message-Id: <1107019605.10735.22.camel@pegasus>
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
Date: Sat, 29 Jan 2005 18:26:45 +0100

Hi Victor,

> I use TTY because I want to provide AT command communication and PPP over 
> the same channel, in my case I send a number of AT commands, then start 
> pppd over the channel (converted to TTY) and then, after it is finished, I 
> want to send AT commands again. I want to do this all without reopening 
> bluetooth connection with the phone, which is being closed when pppd 
> finishes on TTY. I also can open a TTY from my application, so pppd can 
> not close the connection on exit (cause there are still open descriptors) 
> - but 
> sending commands through an open TTY works strange to me... 

check if your TTY is set to raw mode and actually you should look at
dund, because this provides most of this functionality. And using pppd
you can also define post-connection scripts.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
