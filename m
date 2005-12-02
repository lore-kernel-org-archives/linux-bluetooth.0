Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] vendor specific commands
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20051202072546.8845.qmail@web31106.mail.mud.yahoo.com>
References: <20051202072546.8845.qmail@web31106.mail.mud.yahoo.com>
Content-Type: text/plain
Message-Id: <1133513229.11226.12.camel@blade>
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
Date: Fri, 02 Dec 2005 09:47:09 +0100

Hi Jatin,

> I want to add support for few vendor specific commands to BlueZ, was
> wondering whats the best place in the source code to do that? I want
> to perform some hardware configuration before any other initialization
> happens.
>  
> I am also trying to understand general BlueZ architecture for any
> enhancements or customizations, what would be the best place to start
> (I have been  looking at the code, but do not completely understand it
> especially the startup part).
>  
> Also wondering whats BlueZ's policy regarding support for vendor
> specific commands/events? Is it possible to submit modifications for a
> particular vendor and get that incorporated in standard distributions.

this depends on, but in general it is no problem. However the Bluetooth
core inside the Linux kernel stays vendor free at any price. But you
should don't ask vague questions. Tell us what hardware you are talking
about and what vendor specific stuff is needed in detail.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
