Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Simple file push, without OBEX?
From: Stephen Crane <steve.crane@rococosoft.com>
To: Lalith Chakravarthi <lalithvc@yahoo.com>
Cc: bluez-users <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040401105910.81075.qmail@web40713.mail.yahoo.com>
References: <20040401105910.81075.qmail@web40713.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1080820549.1907.110.camel@baroque.rococosoft.com>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 01 Apr 2004 12:55:50 +0100

btgoep:// is a (fairly large IMO) layer over btspp://. You could always
implement it yourself ;-)

On Thu, 2004-04-01 at 11:59, Lalith Chakravarthi wrote:
> > 
> > Is it possible to send a simple file, such as a vCard, or an image, 
> > from a MIDlet running on one device to another device, via bluetooth?
> > 
> > It seems to be an operation that requires an OBEX push to me, but as 
> > no handsets implement OBEX in their JSR-82 implementations, that 
> > leaves RFCOMM or L2CAP. As far as I can see, RFCOMM/L2CAP 
> > connections are always client/server. Is it possible to simply 
> > connect to another device and send a file using these methods, 
> > without specifying a service or custom MIDlet to connect to, and 
> > have the receiver deal with the file appropriately? Or is there a 
> > generic service that accepts incoming files, that can be specified 
> > in the connection string? 
> > 
> > thanks for any help. And no, this isn't an April Fools joke!
> > 
> > 
> 
> 
> __________________________________
> Do you Yahoo!?
> Yahoo! Small Business $15K Web Design Giveaway 
> http://promotions.yahoo.com/design_giveaway/
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: IBM Linux Tutorials
> Free Linux tutorial presented by Daniel Robbins, President and CEO of
> GenToo technologies. Learn everything from fundamentals to system
> administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
-- 
Stephen Crane, Rococo Software Ltd. http://www.rococosoft.com
steve.crane@rococosoft.com +353-1-6601315 (ext 209)



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
