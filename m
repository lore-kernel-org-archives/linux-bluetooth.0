Return-Path: <cyrus@holtmann.org>
Date: Fri, 28 Mar 2014 14:25:18 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v0 0/5] Add GATT Characteristic Flags
Message-ID: <20140328122518.GA11823@t440s.ger.corp.intel.com>
References: <1395926475-8841-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1395926475-8841-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Thu, Mar 27, 2014, Claudio Takahasi wrote:
> This patchset adds GattCharacteristic1 "Flags" property.
> 
> Extended properties are not supported yet.
> 
> Alvaro Silva (1):
>   test: Add permissions for Alert Level of gatt-service
> 
> Claudio Takahasi (4):
>   gatt: Add parsing GattCharacteristic1 Flags
>   gatt: Set read and write callbacks based on Flags
>   gatt: Make Characteristic Flags optional
>   doc: Remove Core SPEC page number from gatt-api.txt
> 
>  doc/gatt-api.txt     | 13 ++++----
>  src/gatt-dbus.c      | 93 +++++++++++++++++++++++++++++++++++++++++++++++++---
>  tools/gatt-service.c | 43 ++++++++++++++++++++----
>  3 files changed, 131 insertions(+), 18 deletions(-)

All patches have been applied. Thanks.

Johan
