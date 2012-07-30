Return-Path: <cyrus@holtmann.org>
Date: Mon, 30 Jul 2012 11:07:51 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 BlueZ 00/12] Store address type in BR/EDR and shared
 files
Message-ID: <20120730080751.GA6924@x220.ger.corp.intel.com>
References: <1343418203-15335-1-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1343418203-15335-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Fri, Jul 27, 2012, Vinicius Costa Gomes wrote:
> Just an updated version of the storage patches that Paulo Alcantara sent some
> time ago.
> 
> Changes from last version:
>  * delete_entry now has address and address type parameters;
>  * When removing entries, we also remove the entries that have the old format
>  (without address type);
> 
> Cheers,
> 
> 
> Claudio Takahasi (1):
>   storage: Store address type in "blocked" file
> 
> Paulo Alcantara (10):
>   storage: Store address type in "aliases" file
>   core: Fix reading from "aliases" and "names" file
>   storage: Store address type in "lastseen" file
>   storage: Store address type in "lastused" file
>   storage: Store address type in "profiles" file
>   storage: Store address type in "did" file
>   storage: Store address type in "linkkeys" file
>   storage: Store address type in "trusts" file
>   storage: Store address type in "eir" file
>   storage: Store address type in "sdp" file
> 
> Vinicius Costa Gomes (1):
>   storage: Make it clear that delete_entry only works for addresses
> 
>  profiles/input/device.c |    5 +-
>  src/adapter.c           |   41 +++++--
>  src/device.c            |   70 ++++++------
>  src/event.c             |   20 ++--
>  src/storage.c           |  286 ++++++++++++++++++++++++++++++++++-------------
>  src/storage.h           |   58 ++++++----
>  6 files changed, 330 insertions(+), 150 deletions(-)

All patches in this set have been applied. Thanks.

Johan
