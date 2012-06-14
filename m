Return-Path: <cyrus@holtmann.org>
Date: Thu, 14 Jun 2012 15:18:14 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: Gustavo Padovan <gustavo@padovan.org>,
	linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: Re: [PATCH 00/21] BlueZ 5.0 patches
Message-ID: <20120614121814.GA3850@x220>
References: <1339620223-6639-1-git-send-email-gustavo@padovan.org>
 <1339665747.3987.73.camel@novo.hadess.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1339665747.3987.73.camel@novo.hadess.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

On Thu, Jun 14, 2012, Bastien Nocera wrote:
> > compat/hidd.1                      |   41 -
> > compat/hidd.c                      |  848 --------
> 
> We need something to replace hidd --show, for debugging purposes.

All that does is call a simple ioctl and print its result, requiring
maybe 10 lines of code or so. What we could do is add a small tool under
tools/ that can do the same task.

> > compat/fakehid.c                   |  669 ------
> 
> Is there something to replace the support for those devices? Nobody
> seems to have added the support to input/fakehid.c which would be the
> logical place.

Yep, seems like the logical place to me too. Do we have any actual
users/developers of this device that would be willing to step up to do
this code merge and test that everything still works?

Johan
