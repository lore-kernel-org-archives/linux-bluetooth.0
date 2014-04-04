Return-Path: <cyrus@holtmann.org>
Date: Fri, 4 Apr 2014 10:30:10 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v1 0/3] Add removing GATT services
Message-ID: <20140404073010.GC16753@t440s.lan>
References: <1396463426-7268-1-git-send-email-claudio.takahasi@openbossa.org>
 <1396554412-2057-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1396554412-2057-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Thu, Apr 03, 2014, Claudio Takahasi wrote:
> This patchset implements GattManager1.UnregisterService(), and low-level
> functions to remove service declarations (and its attributes) from the
> attribute database.
> 
> Changes v1-v0:
>  * Fix potential invalid memory access
>  * Cleanup of external service when registration fails
> 
> Claudio Takahasi (3):
>   gatt: Add removing service from the database
>   gatt: Fix possibly lost block when bluetoothd exits
>   doc: Add InvalidArguments to UnregisterService() errors
> 
>  doc/gatt-api.txt |  3 ++-
>  src/gatt-dbus.c  | 51 +++++++++++++++++++++++++++++++++++++++++----------
>  2 files changed, 43 insertions(+), 11 deletions(-)

All three patches have been applied. Thanks.

Johan
