Return-Path: <cyrus@holtmann.org>
Date: Fri, 25 May 2012 10:39:22 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Paulo Alcantara <pcacjr@zytor.com>
Cc: paulo.alcantara@openbossa.org, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 00/15] Store address type on storage - remaining
 files
Message-ID: <20120525073922.GA13680@x220>
References: <1337798914-20974-1-git-send-email-paulo.alcantara@openbossa.org>
 <20120524075923.GA17458@x220>
 <20120524.145707.1901844181634748035.pcacjr@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120524.145707.1901844181634748035.pcacjr@zytor.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Paulo,

On Thu, May 24, 2012, Paulo Alcantara wrote:
> > On Wed, May 23, 2012, Paulo Alcantara wrote:
> > > This patchset contains the remaining changes for the new storage format
> > > used (bdaddr#type) on storage files (LE-only or shared files).
> > > 
> > > The files that have been changed so far are:
> > >     primaries, characteristics, appearance, ccc, names, aliases,
> > >     longtermkeys, attributes, blocked.
> > 
> > Any files that are used for BR/EDR would have to keep their backwards
> > compatibility. Otherwise someone who upgrades from 4.99 to 4.100 will
> > suddenly find that the device they had blocked is not blocked anymore
> > and none of their devices have any names. We can't break something like
> > that between 4.x versions. Are these patches guaranteeing this backwards
> > compatibility? Looking at the patches it doesn't look like they give
> > this guarantee.
> 
> Ok, you're right. The only file that we should keep backward compatibility on
> this series is the blocked file, since it's shared by both BR/EDR and LE devices.

The aliases and names files are also shared with BR/EDR. It seems your
patches do not take this into account.

Johan
