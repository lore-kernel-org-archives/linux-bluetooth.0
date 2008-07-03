Return-Path: <cyrus@holtmann.org>
Date: Thu, 3 Jul 2008 18:18:42 -0400
From: jayjwa <jayjwa@atr2.ath.cx>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <e96e9eeb0807020056v224e3dccsb4d0288bd532051d@mail.gmail.com>
Message-ID: <alpine.LNX.1.10.0807031813010.5583@nge2.ngu.pk>
References: <e96e9eeb0806130507u139f58a2sa7094a65f9ecff17@mail.gmail.com>
	<4852914F.6020209@earthlink.net>
	<e96e9eeb0806160505m44d366e7if9cea8e1d3c6978b@mail.gmail.com>
	<4856EC25.5040508@earthlink.net>
	<e96e9eeb0806300506l1aaeaf6bje93db6f4f5af880e@mail.gmail.com>
	<e96e9eeb0806300509w12d1dfaen3f00db7732db80c8@mail.gmail.com>
	<alpine.LNX.1.10.0807011047300.6029@nge2.ngu.pk>
	<e96e9eeb0807020056v224e3dccsb4d0288bd532051d@mail.gmail.com>
MIME-Version: 1.0
Subject: Re: [Bluez-users] Bluez build problem
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net



On Wed, 2 Jul 2008, Voni Hakau wrote:

-> > Perhaps the library is mentioned in a libtool (.la) file? You should be able
-> > to change the Makefiles if needed. Looking in 3.34 utils, I see your libdbus-1
-> > is mentioned in lots of places (found with `rgrep -r 'dbus-1' . | most ` while
-> > cwd was /tmp/bluez-utils-3.34):
-> 
-> So you think too that there is a bug in bluez-utils ? That it ignores
-> the DBUS_LIBS environment variable ?

Honestly, I'm not sure. Note that vars like DBUS_LIBS can be set in many 
places, and there is an order in which they take preference. You might be 
setting it, only to have to cancelled by a higher-preference assignment some 
place else. If that is how it is designed to be, it's not a bug; it's hard to 
tell without the actual problem in front of me. It built OK here, but then I'm 
not cross compiling, which is a bit trickier.


-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
