Return-Path: <cyrus@holtmann.org>
Date: Mon, 14 Nov 2011 20:54:15 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v2 0/2] CCC for bonded devices
Message-ID: <20111114185415.GB12675@fusion.localdomain>
References: <1318517589-17372-1-git-send-email-claudio.takahasi@openbossa.org>
 <1320674942-23004-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1320674942-23004-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Mon, Nov 07, 2011, Claudio Takahasi wrote:
> Changes from previous version: rebase only
> 
> According to BT spec, CCC is persistent for bonded devices only.
> If the device is NOT bonded, CCC entry is removed from the storage
> when the connection is established. This approach is simpler than
> keep different list/storage(and logic) for bonded and non-bonded devices.
> 
> Dependency:
> [PATCH BlueZ 0/7] CCC persistence
> 
> Claudio Takahasi (2):
>   Add storage function to remove CCC of a device
>   Remove CCC if the device is not bonded
> 
>  src/attrib-server.c |   15 +++++++++++++++
>  src/storage.c       |   11 +++++++++++
>  src/storage.h       |    1 +
>  3 files changed, 27 insertions(+), 0 deletions(-)

Applied. Thanks.

Johan
