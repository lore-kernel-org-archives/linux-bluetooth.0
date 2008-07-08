Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <48728258.6080809@aircable.net>
References: <48728258.6080809@aircable.net>
Date: Tue, 08 Jul 2008 22:41:34 +0200
Message-Id: <1215549694.26279.6.camel@californication>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] No more binary SDP registration in new 4.0 API?
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

Hi Manuel,

> I've been asking this the hole weekend on the irc channel, but yet no 
> one could tell me if this is a bug or a feature, or what ever.
> 
> On Dbus api 3.X you could register binary sdp records over dbus, but new 
> api can't I all ready implemented adding records, I need to implement 
> the update records. But I would like to know if it makes sense to commit 
> this patch or not.

the idea is not to use binary SDP records at all anymore. Also we wanna
move the record registration and service authorization into a plugin and
don't have this in the Adapter interface anymore.

Regards

Marcel



-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
