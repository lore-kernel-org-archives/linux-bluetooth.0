Return-Path: <cyrus@holtmann.org>
Date: Tue, 31 May 2011 22:41:45 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: VISHWANATH KM <a21174@motorola.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: remote name request missing for incoming connections in newer
 Bluez 4.93
Message-ID: <20110531194145.GA30020@dell.ger.corp.intel.com>
References: <BANLkTi=LMR0vRhyUm22vVodJzFPw=Rbi=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BANLkTi=LMR0vRhyUm22vVodJzFPw=Rbi=A@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Jun 01, 2011, VISHWANATH KM wrote:
> In newer versions of Bluez version 4.93, after the ACL established,
> remote name request is not issued , due to which device name is not
> present in case of incoming connections. Please confirm if anybody
> observed this issue. thanks
> 
> Bluez 4.93
> src/event.c  btd_event_conn_complete ( Does not issue remote name req )
> 
> Bluez 4.69
> src/security.c conn_complete  (issues remote name req )

Interesting that someone finally noticed :)

This has been removed since the kernel is now days doing the automated
name request. The feature is present from 2.6.37 onwards. Since there's
no clean & simple way of detecting whether a recent enough kernel is
present and some controllers will get confused if bombarded with too
many requests this was simply removed from user space.

Seems like not too many people have missed this feature since the change
was done already end of last year. Typically BlueZ is the initiator of
the first connection to a device and so you get the name through the
device discovery process anyway.

Johan
