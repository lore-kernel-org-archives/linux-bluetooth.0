Return-Path: <cyrus@holtmann.org>
Date: Mon, 24 Mar 2014 11:03:41 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v0 1/4] gatt: Fix coding style when testing pointers
Message-ID: <20140324090341.GC26197@t440s.lan>
References: <1395429633-656-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1395429633-656-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Fri, Mar 21, 2014, Claudio Takahasi wrote:
> Use !ptr instead of ptr == NULL
> ---
>  src/gatt-dbus.c | 10 +++++-----
>  src/gatt.c      |  8 ++++----
>  2 files changed, 9 insertions(+), 9 deletions(-)

I've applied patches 2 and 3 from this set. The other two didn't apply
cleanly.

Johan
