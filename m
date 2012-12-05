Return-Path: <cyrus@holtmann.org>
Date: Wed, 5 Dec 2012 19:25:41 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: Re: [PATCH v1 0/6] Remove access rights from MediaTransport
Message-ID: <20121205172541.GB18564@x220.P-661HNU-F1>
References: <1354724134-7354-1-git-send-email-mikel.astiz.oss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1354724134-7354-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Wed, Dec 05, 2012, Mikel Astiz wrote:
> v1 proposes TryAcquire() instead of Acquire(TRUE), as suggested by
> Johan.
> 
> From original cover-letter:
> 
> The accessrights used in the Acquire() method are not very useful and
> can thus be removed. This simplifies both the D-Bus API and the
> internal implementation significantly.
> 
> Mikel Astiz (6):
>   media: Remove transport access type from D-Bus API
>   media: Remove internal transport locks
>   media: Remove transport owner list
>   media: Add MediaTransport.TryAcquire()
>   media: Trivial style fix
>   media: Add version suffix to all media interfaces
> 
>  doc/audio-telephony-design.txt |   4 +-
>  doc/media-api.txt              |  46 +++----
>  profiles/audio/media.c         |   8 +-
>  profiles/audio/player.c        |   2 +-
>  profiles/audio/transport.c     | 264 ++++++++++++-----------------------------
>  test/mpris-player.c            |  14 +--
>  6 files changed, 108 insertions(+), 230 deletions(-)

All patches in this set have been applied. Thanks.

Johan
