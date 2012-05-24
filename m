Return-Path: <cyrus@holtmann.org>
Date: Thu, 24 May 2012 14:57:07 -0300 (BRT)
Message-Id: <20120524.145707.1901844181634748035.pcacjr@zytor.com>
To: johan.hedberg@gmail.com
Cc: paulo.alcantara@openbossa.org, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 00/15] Store address type on storage - remaining
 files
From: Paulo Alcantara <pcacjr@zytor.com>
In-Reply-To: <20120524075923.GA17458@x220>
References: <1337798914-20974-1-git-send-email-paulo.alcantara@openbossa.org>
	<20120524075923.GA17458@x220>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

From: Johan Hedberg <johan.hedberg@gmail.com>
Date: Thu, 24 May 2012 10:59:23 +0300

> Hi Paulo,
> 
> On Wed, May 23, 2012, Paulo Alcantara wrote:
> > This patchset contains the remaining changes for the new storage format
> > used (bdaddr#type) on storage files (LE-only or shared files).
> > 
> > The files that have been changed so far are:
> >     primaries, characteristics, appearance, ccc, names, aliases,
> >     longtermkeys, attributes, blocked.
> 
> Any files that are used for BR/EDR would have to keep their backwards
> compatibility. Otherwise someone who upgrades from 4.99 to 4.100 will
> suddenly find that the device they had blocked is not blocked anymore
> and none of their devices have any names. We can't break something like
> that between 4.x versions. Are these patches guaranteeing this backwards
> compatibility? Looking at the patches it doesn't look like they give
> this guarantee.

Ok, you're right. The only file that we should keep backward compatibility on
this series is the blocked file, since it's shared by both BR/EDR and LE devices.

I've just made a patch that ensures that we're keeping backward compatibility
with this file (16/16).

> I could have gone ahead and just applied the patches that are strictly
> LE-only and gone ahead with the 4.100 release, but since you've mixed a
> BR/EDR change and an LE change in 15/15 I can't do that. I think the way
> to proceed is to just do this storage change for LE-only files and then
> with 5.0 convert the others.

I think you missed anything when looking at this patch. Note that the key
variable initially contains only the bdaddr (but not the #type appended), so we
can call delete_entry() for the BR/EDR-only files just before the sprintf() call
(if the condition on if-statement gets true) which appends the "#type" in the
key variable, thus avoiding to set the NULL byte at index 17 of the key variable
for deleting the entries of the BR/EDR-only files.


    	     	 Paulo
