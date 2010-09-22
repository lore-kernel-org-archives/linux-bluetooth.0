Return-Path: <cyrus@holtmann.org>
Date: Wed, 22 Sep 2010 22:24:36 +0300
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Pull request:
 git://gitorious.org/~vudentz/bluez/vudentzs-clone.git for-upstream
Message-ID: <20100922192436.GB20756@jh-x301>
References: <AANLkTikKc3E3wPkkP3U+mbZUa6UyqCAeRoPhEhwY0AAb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTikKc3E3wPkkP3U+mbZUa6UyqCAeRoPhEhwY0AAb@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Wed, Sep 22, 2010, Luiz Augusto von Dentz wrote:
> The following changes since commit cca89b3d5c78c29065a88ce099dea36137bea225:
> 
>   Release 4.72 (2010-09-22 19:48:34 +0900)
> 
> are available in the git repository at:
>   git://gitorious.org/~vudentz/bluez/vudentzs-clone.git for-upstream
> 
> Luiz Augusto von Dentz (5):
>       Fix registering local endpoints when Socket interface is disabled
>       Remove ReadLock and WriteLock from MediaTransport properties
>       Replace use of term 'Renderer' with 'Owner'
>       Make MediaEndpoint.SetConfiguration to take all transport properties
>       Make MediaEndpoint.ClearConfiguration to take transport path
> 
>  audio/a2dp.c      |   13 ++++++++++++-
>  audio/media.c     |   22 ++++++++++++++--------
>  audio/transport.c |   43 ++++++++++++++++++++++---------------------
>  audio/transport.h |    2 ++
>  doc/media-api.txt |    6 +++---
>  5 files changed, 53 insertions(+), 33 deletions(-)

Thanks. All patches have been pushed upstream.

Johan
