Return-Path: <cyrus@holtmann.org>
Date: Fri, 27 Apr 2012 15:15:30 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: Hemant Gupta <hemant.gupta@stericsson.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Store LE device address type with primary list
Message-ID: <20120427121530.GA24803@x220.P-661HNU-F1>
References: <1335360420-23445-1-git-send-email-hemant.gupta@stericsson.com>
 <20120426093203.GB18380@x220>
 <CAKT1EBc6inPjxW0QqT7MQAvt0iad2cZs59MC_W4NExtyBUkXqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAKT1EBc6inPjxW0QqT7MQAvt0iad2cZs59MC_W4NExtyBUkXqw@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Thu, Apr 26, 2012, Claudio Takahasi wrote:
> On Thu, Apr 26, 2012 at 6:32 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> > Hi Hemant,
> >
> > On Wed, Apr 25, 2012, Hemant Gupta wrote:
> >> This patch stores the address type while storing the primary services
> >> of LE Device which is later used for re-creating device from primary
> >> service database.
> >> ---
> >>  src/adapter.c |   10 ++++++++--
> >>  src/device.c  |    9 +++++++--
> >>  2 files changed, 15 insertions(+), 4 deletions(-)
> >
> > Would it make more sense (and I'm not asking just you but also the
> > INdTers) to have the address type as part of the key instead of the
> > value. After all it's basically an extension to the address and that way
> > tightly bound to it. Maybe something like the following:
> >
> > 11:22:33:44:55:66|1 <value1>
> > aa:bb:cc:dd:ee:ff|0 <value2>
> >
> > The same should then also be considered for the longtermkeys file.
> >
> > Johan
> 
> I agree if we append the address type for all LE/GATT storage
> files(not only for primary and longtermkeys).
> Probably we will have minor problems between BlueZ releases, but IMO
> it is acceptable since LE it is not officially supported.
> btw: the separator commonly used in the storage files is "#" instead of "|".

I'm fine with using # and yes all LE related files should use this
convention. And if possible these changes should go in before the next
BlueZ release.

Johan
