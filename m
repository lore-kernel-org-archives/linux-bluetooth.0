Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <25BA763748F34FF6A428E1AE776B1E32@freqonedev>
References: <25BA763748F34FF6A428E1AE776B1E32@freqonedev>
Date: Sat, 30 Aug 2008 10:59:41 +0200
Message-Id: <1220086781.7145.35.camel@californication>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] "Gather Write"/writev call and BlueZ driver...
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

Hi David,

> Not sure who to address this to (Marcel, maybe?), but does the Bluetooth 
> driver support the writev call?
> 
> The reason for asking is that in AVRCP+Metadata I need to implement 
> fragmentation in AVCTP.  Of course, I can just sling chunks of the big 
> AVRCP packet into AVCTP buffers, pre-pending with the appropriate AVCTP 
> header, but was wondering if there might be a more elegant solution 
> (using writev to write the header, then the appropriate piece of the 
> AVRCP packet).

go ahead and try it. I am not sure about writev, but in general it
should be supported since the kernel callback only expose sendmsg and
the rest it userspace API.

Regards

Marcel



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
