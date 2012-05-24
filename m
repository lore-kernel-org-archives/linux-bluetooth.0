Return-Path: <cyrus@holtmann.org>
Date: Thu, 24 May 2012 10:59:23 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Paulo Alcantara <paulo.alcantara@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 00/15] Store address type on storage - remaining
 files
Message-ID: <20120524075923.GA17458@x220>
References: <1337798914-20974-1-git-send-email-paulo.alcantara@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1337798914-20974-1-git-send-email-paulo.alcantara@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Paulo,

On Wed, May 23, 2012, Paulo Alcantara wrote:
> This patchset contains the remaining changes for the new storage format
> used (bdaddr#type) on storage files (LE-only or shared files).
> 
> The files that have been changed so far are:
>     primaries, characteristics, appearance, ccc, names, aliases,
>     longtermkeys, attributes, blocked.

Any files that are used for BR/EDR would have to keep their backwards
compatibility. Otherwise someone who upgrades from 4.99 to 4.100 will
suddenly find that the device they had blocked is not blocked anymore
and none of their devices have any names. We can't break something like
that between 4.x versions. Are these patches guaranteeing this backwards
compatibility? Looking at the patches it doesn't look like they give
this guarantee.

I thought I made it clear that we can break something like this only for
LE (since 4.100 is the first version to be considered officially
supporting LE) but not for BR/EDR.

I could have gone ahead and just applied the patches that are strictly
LE-only and gone ahead with the 4.100 release, but since you've mixed a
BR/EDR change and an LE change in 15/15 I can't do that. I think the way
to proceed is to just do this storage change for LE-only files and then
with 5.0 convert the others.

One thing left for debate is do we still in 5.0 want to avoid a messed
up system where someone has storage files from 4.x times and therefore
gets incomplete device objects (created out of linkkeys files but most
other data is missing, like names, etc). Probably we should ensure that
either devices created out of such storage have all info or then the
devices aren't created at all (meaning we may need to change the key
format even for BR/EDR-only files like linkkeys).

Johan
