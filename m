Return-Path: <cyrus@holtmann.org>
Message-ID: <48728258.6080809@aircable.net>
Date: Mon, 07 Jul 2008 17:53:44 -0300
From: Manuel Naranjo <manuel@aircable.net>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] No more binary SDP registration in new 4.0 API?
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

Hello everyone,

I've been asking this the hole weekend on the irc channel, but yet no 
one could tell me if this is a bug or a feature, or what ever.

On Dbus api 3.X you could register binary sdp records over dbus, but new 
api can't I all ready implemented adding records, I need to implement 
the update records. But I would like to know if it makes sense to commit 
this patch or not.

Thanks,
Manuel

-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
