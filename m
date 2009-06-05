Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Add on demand functionality to bluetooth init script
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: Petr Lautrbach <plautrba@redhat.com>,
	linux-bluetooth@vger.kernel.org
In-Reply-To: <20090605153852.GA29262@jh-x301>
References: <4A27DFBE.407@redhat.com>  <20090605153852.GA29262@jh-x301>
Content-Type: text/plain
Date: Fri, 05 Jun 2009 17:48:26 +0200
Message-Id: <1244216906.23850.70.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> > This patch adds on demand functionality for bluetooth service based on
> > udev events.  It's adapted from Fedora [1].
> >
> > Idea is that bluetoothd doesn't need to be running unless the user
> > actually has a bluetooth device.
> 
> The patch looks good to me (though my udev knowledge is rather limited).
> However, I'd like to get a second opinion from Marcel before pushing
> upstream.

first of all the question from Stefan needs to be handled on how we
handle the case for udev event before D-Bus system daemon is started.

Personally I think having an extra init script style for this makes no
sense and just adds complexity in the start/stop process of the daemon.

I might prefer if we add special bluetoothd --udev={start,stop} handling
to it (including polling code for D-Bus system daemon availability).

Regards

Marcel


