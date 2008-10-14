Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Fix PS3 BD remote input event generation
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <8D4D4D94-FD26-47A8-A9F9-CFD7D093BBDE@gmail.com>
References: <1223936924.2243.0.camel@snoogens.fab.redhat.com>
	 <8D4D4D94-FD26-47A8-A9F9-CFD7D093BBDE@gmail.com>
Content-Type: text/plain
Date: Tue, 14 Oct 2008 12:09:58 +0200
Message-Id: <1223978998.4764.3.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> > - Fix byte-reading in the decode function by using a guint8, instead
> > of an int, we were overreading and were getting keycodes of
> > 0xffffff44 when we wanted a single byte of 0x44.
> > - Remove use of KEY_REMOTE_X, those keys never got upstream, and the
> > values they were defined at are now used for completely different
> > keys
> > - Update uinput.h with the latest keycodes from 2.6.27
> 
> The patch has been pushed upstream. Thanks!

this patch should have been split at least into 2 pieces (maybe 3). The
uinput update at least should have been separate. We are using GIT and
there is no reason to push combined patches ever. I do _NOT_ wanna have
big patches that fix multiple things. Break them down.

Regards

Marcel


