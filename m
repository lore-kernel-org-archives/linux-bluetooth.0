Return-Path: <cyrus@holtmann.org>
Subject: Re: [BUG] 2.6.30-rc4 hid bluetooth not working
From: Marcel Holtmann <marcel@holtmann.org>
To: Jiri Kosina <jkosina@suse.cz>
Cc: Marc Pignat <Marc.Pignat@hevs.ch>, ext-roger.quadros@nokia.com,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <alpine.LNX.2.00.0905020019360.22532@wotan.suse.de>
References: <49FA604C020000BF000290B6@mailgw2.hevs.ch>
	 <alpine.LNX.2.00.0905020019360.22532@wotan.suse.de>
Content-Type: text/plain
Date: Fri, 01 May 2009 15:56:34 -0700
Message-Id: <1241218594.3156.1.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jiri,

> > Subject: bluetooth: Fix serialization when adding/deleting connections in hci_sysfs
> > 
> > add_conn and del_conn should be serialized, but flush_workqueue can't be used
> > by the worker thread on it's own queue, so use flush_work to serialize add_conn
> > and del_conn against each other.
> > 
> > Signed-off-by: Marc Pignat <marc.pignat@hevs.ch>
> 
> Acked-by: Jiri Kosina <jkosina@suse.cz>
> 
> FWIW.

nak from my side since I think it is the wrong fix. We really wanna wait
for all works to finish here. This includes work from other connection
attempts or terminations.

Regards

Marcel


