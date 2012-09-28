Return-Path: <cyrus@holtmann.org>
Date: Fri, 28 Sep 2012 12:47:57 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] proximity: Split profile driver into Monitor and
 Reporter
Message-ID: <20120928094757.GB2518@x220>
References: <1348064839-5602-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1348064839-5602-1-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Wed, Sep 19, 2012, Andrzej Kaczmarek wrote:
> Proximity Monitor interface is registered for each GATT device since profile
> driver matches by GATT_UUID which is intended only for Reporter role.
> 
> This patches splits Proximity profile driver into two separate drivers for
> Monitor and Reporter role to register interfaces properly.
> ---
>  profiles/proximity/manager.c  | 29 +++++++++++++++++++++--------
>  profiles/proximity/reporter.c |  2 +-
>  profiles/proximity/reporter.h |  2 +-
>  3 files changed, 23 insertions(+), 10 deletions(-)

Both of these patches have been applied after some rework to match the
newer profile API.

Johan
