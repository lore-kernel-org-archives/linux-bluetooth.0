Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Re: D-Link DBT-120 destroyed? (with bluefw)
From: Marcel Holtmann <marcel@holtmann.org>
To: Roger Larsson <roger.larsson@norran.net>
Cc: bluez-users@lists.sf.net
In-Reply-To: <200406082046.30496.roger.larsson@norran.net>
References: <200405290103.26485.roger.larsson@norran.net>
	 <1086633659.2724.65.camel@localhost>
	 <200406082046.30496.roger.larsson@norran.net>
Content-Type: text/plain
Message-Id: <1086721405.5040.24.camel@pegasus>
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
Date: Tue, 08 Jun 2004 21:03:25 +0200

Hi Roger,

> > > I was following instructions on a German site to get my DBT-120 to work
> > > in Linux. First time I skipped over that command. Second time I forgot to
> > > skip it.

what site?

> > > The D-Link does not light up any more - can it be repaired?

I don't know. What does dmesg say? What is in the log files?

> > > If not what USB BlueTooth adapter do you recommend?
> > > I will be using it with Ericsson phones (T610 and T39)

Your D-Link is fine ;)

> > I'd suggest for you to ask this question on bluez-users@lists.sf.net.
> > And no, bluefw cannot possible kill the your DBT-120 because that
> > devices does not have permanent firmware at all. It expects driver to
> > load FW every time it's plugged in.
> 
> Forgot to mention, my DBT-120 has hw revision B3.
> I am not subscribed.

And here is the problem. The DBT-120 (Rev B3) is not Broadcom based and
so it don't need a firmware download. It is CSR based.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: GNOME Foundation
Hackers Unite!  GUADEC: The world's #1 Open Source Desktop Event.
GNOME Users and Developers European Conference, 28-30th June in Norway
http://2004/guadec.org
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
