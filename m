Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 1/4] Add parsing of L2CAP Create/Move Channel signals
From: Marcel Holtmann <marcel@holtmann.org>
To: Peter Krystad <pkrystad@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, andrei.emeltchenko@intel.com
Date: Sat, 22 Oct 2011 09:21:58 +0200
In-Reply-To: <1319239802-22457-2-git-send-email-pkrystad@codeaurora.org>
References: <1319239802-22457-1-git-send-email-pkrystad@codeaurora.org>
	 <1319239802-22457-2-git-send-email-pkrystad@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1319268120.15441.216.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Peter,

> Add parsing of L2CAP Create/Move Channel signalling.
> Example output:
> 
> 2011-10-18 16:09:47.810208 > ACL data: handle 39 flags 0x02 dlen 13
>     L2CAP(s): Create req: psm 4097 scid 0x4201 id 17
> 2011-10-18 16:09:47.810269 < ACL data: handle 39 flags 0x00 dlen 16
>     L2CAP(s): Create rsp: dcid 0x0040 scid 0x4201 result 1 status 0
> 2011-10-18 16:09:47.898308 < ACL data: handle 39 flags 0x00 dlen 16
>     L2CAP(s): Create rsp: dcid 0x0040 scid 0x4201 result 0 status 0
> 
> ....
> 
> 2011-10-18 14:25:24.646869 > ACL data: handle 39 flags 0x02 dlen 11
>     L2CAP(s): Move req: icid 0x4000 id 17
> 2011-10-18 14:25:24.646987 < ACL data: handle 39 flags 0x00 dlen 12
>     L2CAP(s): Move rsp: icid 0x4000 result 1
> 2011-10-18 14:25:24.846873 < ACL data: handle 39 flags 0x00 dlen 12
>     L2CAP(s): Move rsp: icid 0x4000 result 0
> 2011-10-18 14:25:25.041844 > ACL data: handle 39 flags 0x02 dlen 12
>     L2CAP(s): Move cfm: icid 0x4000 result 0
> 2011-10-18 14:25:25.041945 < ACL data: handle 39 flags 0x00 dlen 10
>     L2CAP(s): Move cfm rsp: icid 0x4000
> ---
>  lib/l2cap.h    |   50 +++++++++++++++++++++++++++++
>  parser/l2cap.c |   97 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 147 insertions(+), 0 deletions(-)

same requirement as with Andrei's patches before. First get them
accepted into bluez.git and then we port them over here.

Regards

Marcel


