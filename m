Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Mon, 18 Dec 2017 13:17:50 +0100
From: Johan Hedberg <johan.hedberg@gmail.com>
To: sbrown@cortland.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH V4 0/9] mesh: Add configuration commands to meshctl
Message-ID: <20171218121750.GA25598@x1c>
References: <20171217105249.7592-1-sbrown@cortland.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171217105249.7592-1-sbrown@cortland.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Steve,

On Sun, Dec 17, 2017, sbrown@cortland.com wrote:
> This complements the Zephyr application located in the Zephyr tree at
> zephyr/samples/boards/nrf52/mesh/onoff-app
> 
> V2: Break each command into a separate commit
> V3: Correct CID usage in pub-set and pub-get
> V4: Correct 7/9 missing break in ident status case stmt
>             compile problem going from V2 to V3
> 
> Steve Brown (9):
>   mesh: meshctl: Change command names to <cmd>-<get/set>
>   mesh: meshctl: Add add/get subscribe
>   mesh: meshctl: Add set heartbeat publish
>   mesh: meshctl: Add get app keys
>   mesh: meshctl: Add get publish
>   mesh: meshctl: Add set/get proxy
>   mesh: meshctl: Add get/set identity
>   mesh: meshctl: Add get/set relay
>   mesh: meshctl: Add Company ID parameter to pub-set and pub-get
> 
>  mesh/config-client.c | 454 ++++++++++++++++++++++++++++++++++++++++++++++++---
>  mesh/net.c           |  20 ++-
>  2 files changed, 448 insertions(+), 26 deletions(-)

Both my and Inga's comments seem to be covered now, so I went ahead and
applied the entire set. Thanks.

Johan
