Return-Path: <cyrus@holtmann.org>
Message-ID: <e96e9eeb0807020056v224e3dccsb4d0288bd532051d@mail.gmail.com>
Date: Wed, 2 Jul 2008 10:56:46 +0300
From: "Voni Hakau" <hakauvoni@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <alpine.LNX.1.10.0807011047300.6029@nge2.ngu.pk>
MIME-Version: 1.0
References: <e96e9eeb0806130507u139f58a2sa7094a65f9ecff17@mail.gmail.com>
	<4852914F.6020209@earthlink.net>
	<e96e9eeb0806160505m44d366e7if9cea8e1d3c6978b@mail.gmail.com>
	<4856EC25.5040508@earthlink.net>
	<e96e9eeb0806300506l1aaeaf6bje93db6f4f5af880e@mail.gmail.com>
	<e96e9eeb0806300509w12d1dfaen3f00db7732db80c8@mail.gmail.com>
	<alpine.LNX.1.10.0807011047300.6029@nge2.ngu.pk>
Cc: marcel@holtmann.org
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

On Tue, Jul 1, 2008 at 6:09 PM, jayjwa <jayjwa@atr2.ath.cx> wrote:

> -> > we can see that it tried to use my host's libdbus-1.so, and it ignores
> -> > the DBUS_LIBS variable..

> Perhaps the library is mentioned in a libtool (.la) file? You should be able
> to change the Makefiles if needed. Looking in 3.34 utils, I see your libdbus-1
> is mentioned in lots of places (found with `rgrep -r 'dbus-1' . | most ` while
> cwd was /tmp/bluez-utils-3.34):

So you think too that there is a bug in bluez-utils ? That it ignores
the DBUS_LIBS environment variable ?

Thank you
Voni

-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
