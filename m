Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Johan Hedberg <johan.hedberg@nokia.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [DBUS PATCH] BlueZ D-Bus redesign
Message-ID: <20060210230043.GA15483@localhost.localdomain>
References: <e1effdeb0602101029v4f1b6e9dw8a0a75a4daf6ba55@mail.gmail.com> <1139596810.26234.73.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1139596810.26234.73.camel@localhost>
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
Date: Sat, 11 Feb 2006 01:00:43 +0200

Hi Marcel,

On Fri, Feb 10, 2006, Marcel Holtmann wrote:
> wow. These are a lot of changes in one patch. I would personally prefer
> to only get the Manager interface right at the moment and do the Device
> interface stuff after that. However it might make sense to do a clean
> cut and apply this patch and then start from there.
> 
> Johan, what do you think?

Well, it is a big patch. However, while it would be easier to follow if
it was split into several parts (e.g. manager, discovery, bonding, etc),
we need to get most things in the new API document commited anyway
before next release, so I don't have anything against applying Claudio's
patch and continuing work from there.

Btw Marcel, the API document should probably be added to CVS or
published on this list since AFAIK currently you, I, Claudio and Eduardo
are the only ones in posession of it.

> Should we split the Manager interface and the Device interface into two
> separate files?

I think that would make sense. That way you could also define clearer
interfaces between them in the code (function wise).

Johan


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
