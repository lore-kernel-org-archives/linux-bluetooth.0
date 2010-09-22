Return-Path: <cyrus@holtmann.org>
Date: Wed, 22 Sep 2010 22:39:49 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Pull request:
 git://gitorious.org/~lizardo/bluez/lizardo-bluez.git for-upstream
Message-ID: <20100922193949.GA21903@jh-x301>
References: <AANLkTikcG2XRNDKSiq5b==JXo+YtPVJy9y4QWkBR9zdR@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTikcG2XRNDKSiq5b==JXo+YtPVJy9y4QWkBR9zdR@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

On Wed, Sep 22, 2010, Anderson Lizardo wrote:
> The following changes since commit ec901c2428324ea2fe7d1bc2a2f3171ac5ed1950:
>   Johan Hedberg (1):
>         Fix reading local name from command complete event
> 
> are available in the git repository at:
> 
>   git://gitorious.org/~lizardo/bluez/lizardo-bluez.git for-upstream
> 
> Claudio Takahasi (9):
>       Update characteristic value when a notification is received
>       Return an error if the path doesn't exist when registering a watcher
>       Add watcher's characteristic path verification before notify changes
>       Watchers don't need to reply for characteristic value updates
>       Change notification/indication output formating on gatttool
>       Report attribute changes for the Battery Service
>       Add missing response for handle value indication on attribute client
>       Remove forward declaration on gattrib source
>       Fix uninitialised value warning
> 
> Vinicius Costa Gomes (6):
>       Add encoders/decoders for Indication/Confirmation
>       Add support to the server to sending Indications
>       Add support for Indications to gatttool
>       Add support for Indications to the client
>       Add support for actively updating the watcher
>       Add a way to unregister GAttrib events
> 
>  attrib/att.c        |   50 +++++++++++++++++
>  attrib/att.h        |    3 +
>  attrib/client.c     |  113 +++++++++++++++++++++++++++++++++++++--
>  attrib/example.c    |   19 +++----
>  attrib/gattrib.c    |  150 ++++++++++++++++++++++++++++++++-------------------
>  attrib/gatttool.c   |   40 +++++++++-----
>  src/attrib-server.c |   28 ++++++++++
>  7 files changed, 320 insertions(+), 83 deletions(-)

Thanks. All patches have been merged upstream.

Johan
