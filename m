Return-Path: <cyrus@holtmann.org>
Date: Mon, 24 Jun 2013 11:19:05 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: Re: [PATCH BlueZ v0 0/6] Exploit btd_service's userdata pointer
Message-ID: <20130624081905.GA23515@x220>
References: <1369656249-27980-1-git-send-email-mikel.astiz.oss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1369656249-27980-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Mon, May 27, 2013, Mikel Astiz wrote:
> With the adoption of btd_service, profile implementations can benefit
> from the provided userdata pointer which can replace the previously
> necessary lists to associate services with custom private types.
> 
> The proposed change not only removes boilerplate code but also data
> redundancy, presumably making the codebase more robust.
> 
> This patchset addresses the first examples which looked like more
> obvious to refactor. Note that some of the profiles were not tested
> due to lack of hardware.
> 
> Patch 2/6 fixes an issue that I came across during this work.
> 
> Mikel Astiz (6):
>   network: Remove duplicated search
>   network: Fix missing NULL check for given UUID
>   network: Remove find_connection()
>   deviceinfo: Use btd_service userdata pointer
>   scanparam: Use btd_service userdata pointer
>   input: Use btd_service userdata pointer
> 
>  profiles/deviceinfo/deviceinfo.c | 46 ++++++----------------------------------
>  profiles/input/device.c          | 37 +++++++++-----------------------
>  profiles/network/connection.c    | 38 ++++++++++++---------------------
>  profiles/scanparam/scan.c        | 36 ++++++-------------------------
>  4 files changed, 35 insertions(+), 122 deletions(-)

Sorry for the delay in processing this set. It looks fine to me and all
patches in it have now been pushed upstream.

Johan
