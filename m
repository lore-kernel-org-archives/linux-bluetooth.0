Return-Path: <cyrus@holtmann.org>
Date: Wed, 23 May 2012 17:05:07 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Paulo Alcantara <paulo.alcantara@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v3 0/3] Store address type on storage
Message-ID: <20120523140507.GA11158@x220.P-661HNU-F1>
References: <1337374667-17802-1-git-send-email-paulo.alcantara@openbossa.org>
 <1337715927-8821-1-git-send-email-paulo.alcantara@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1337715927-8821-1-git-send-email-paulo.alcantara@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Paulo,

On Tue, May 22, 2012, Paulo Alcantara wrote:
> BLE devices have two different address types: public or
> random. So we need to provide this address type on keys
> in the "primary" file to avoid duplicate BLE address types
> around the BlueZ.
> 
> This series changes the storage to store the address type
> together with the device address.
> 
> Hemant Gupta has been working on this on "Store LE device address
> type with primary list" but his patch hasn't been accepted and
> he didn't send a new reviewed version of that patch.
> 
> I have patches for the other storage files as well, I'll
> send them soon. There is a potential problem in
> device_address_cmp() function which checks the address only.
> I am investigating how to fix it to compare address and type
> without breaking the current code.
> 
> v3's changes:
>      - (1/3): Remove unnecessary comment about the new storage
>        	      format and code that leads with the old storage
> 	      format.
> 
>      - (2/3): Just use the initial version of this patch (the
>        	      returning < 2 check in sscanf() function).
> 
>      - (3/3): New patch that fixes removing device services from
>        	      "primary" file by passing a key with the new
> 	      storage format in delete_device_service(). Note
> 	      also that this function was modified to only treat
> 	      the primary case - since we have old storage format
> 	      still being used in the other LE-related storage
> 	      files. So, it will need to be modified in order to
> 	      delete device services of other files (characteristics,
> 	      ccc, etc) on other series.
> 
> 
> Claudio Takahasi (1):
>   core: Fix creating device from "primary" file
> 
> Paulo Alcantara (2):
>   storage: Store BLE address type in "primary" file
>   core: Fix removing device services from "primary" file
> 
>  src/adapter.c |   10 +++++++---
>  src/device.c  |    4 ++--
>  src/storage.c |   45 ++++++++++++++++++++++++++-------------------
>  src/storage.h |    8 +++++---
>  4 files changed, 40 insertions(+), 27 deletions(-)

All three patches have been applied. Thanks.

Johan
