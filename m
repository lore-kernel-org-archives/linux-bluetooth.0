Return-Path: <cyrus@holtmann.org>
Date: Sat, 2 May 2009 00:20:22 +0200 (CEST)
From: Jiri Kosina <jkosina@suse.cz>
To: Marc Pignat <Marc.Pignat@hevs.ch>
Cc: marcel@holtmann.org, ext-roger.quadros@nokia.com,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.6.30-rc4 hid bluetooth not working
In-Reply-To: <49FA604C020000BF000290B6@mailgw2.hevs.ch>
Message-ID: <alpine.LNX.2.00.0905020019360.22532@wotan.suse.de>
References: <49FA604C020000BF000290B6@mailgw2.hevs.ch>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 1 May 2009, Marc Pignat wrote:

> Subject: bluetooth: Fix serialization when adding/deleting connections in hci_sysfs
> 
> add_conn and del_conn should be serialized, but flush_workqueue can't be used
> by the worker thread on it's own queue, so use flush_work to serialize add_conn
> and del_conn against each other.
> 
> Signed-off-by: Marc Pignat <marc.pignat@hevs.ch>

Acked-by: Jiri Kosina <jkosina@suse.cz>

FWIW.

-- 
Jiri Kosina
SUSE Labs
