Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Mon, 28 May 2007 11:16:15 -0400
From: "Marcus C. Gottwald" <gottwald@inf.fu-berlin.de>
To: bluez-users@lists.sourceforge.net
Message-ID: <20070528151615.GA12492@mi.fu-berlin.de>
References: <20070522161255.GA9813@robsims.com>
	<20070522180817.GA24396@mi.fu-berlin.de>
	<20070528001339.GB4055@robsims.com>
Mime-Version: 1.0
In-Reply-To: <20070528001339.GB4055@robsims.com>
Subject: Re: [Bluez-users] Sharing devices with dual-booted Windows
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net


Rob Sims wrote (Sun 2007-May-27 18:13:40 -0600):

> On Tue, May 22, 2007 at 02:08:17PM -0400, Marcus C. Gottwald wrote:
> > Rob Sims wrote (Tue 2007-May-22 10:12:55 -0600):
> > > I have several devices that I use with both Linux and Windows on the
> > > same laptop.  The issue is that the remote devices, such as my PDA, s=
ee
> > > the laptop as the same device no matter what OS is running, and pairi=
ng
> > > is broken.
>  =

> > I always thought of this as a defect in the protocol:
> > Identification is based on the hardware address, but
> > stateful authentication using that identification is
> > performed on a layer way up.
> =

> Are you implying that the hardware address is not changeable, as it is
> for ethernet hardware?

No. But there's an interesting thought: Do you think (Or does
anybody know?) that during protocol design, where this issue
might have come up, someone said, "Ah, that's not a problem,
simply let the user configure his operating systems to change
the hardware address after the device has been plugged in."? --
I still think this was overlooked.


Cheers, Marcus

-- =

   Marcus C. Gottwald  =B7  http://www.inf.fu-berlin.de/~gottwald/


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
