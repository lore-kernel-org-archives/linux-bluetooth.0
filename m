Return-Path: <cyrus@holtmann.org>
Date: Mon, 14 Nov 2011 20:54:01 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v2 0/7] CCC persistence
Message-ID: <20111114185401.GA12675@fusion.localdomain>
References: <1318517004-17003-1-git-send-email-claudio.takahasi@openbossa.org>
 <1320674367-22529-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1320674367-22529-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

HI Claudio,

On Mon, Nov 07, 2011, Claudio Takahasi wrote:
> Changes from previous version: rebase only
> 
> The following patches implement the storage of the Client Characteristic
> Configuration: controls notification & indication.
> 
> Bonding verification is coming in the next patch series.
> 
> Based on the requirements of the available profiles attrib server will
> require some changes. The future plan is to move attribute values to
> plugins (eg: time) and keep only the attribute declaration in the attrib
> server.
> 
> Claudio Takahasi (6):
>   Remove CCC for read by group
>   Remove CCC for read by type
>   Add CCC persistence in attrib server
>   Remove notification and indication from server
>   Remove CCC entries when device is removed
>   Add generic function to delete by pattern
> 
> Vinicius Costa Gomes (1):
>   Add storage functions to deal with CCC
> 
>  src/attrib-server.c |  217 ++++++++++-----------------------------------------
>  src/storage.c       |  100 +++++++++++++++++-------
>  src/storage.h       |    4 +
>  3 files changed, 116 insertions(+), 205 deletions(-)

Applied. Thanks.

Johan
