Return-Path: <cyrus@holtmann.org>
Date: Wed, 16 May 2012 11:30:31 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Decode A2MP Get AMP Assoc rsp
Message-ID: <20120516083031.GA9635@x220>
References: <20120516081203.GB28189@x220>
 <1337156812-16939-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1337156812-16939-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Wed, May 16, 2012, Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Adds decoding Assoc data:
> 
> ...
> > ACL data: handle 11 flags 0x02 dlen 53
>     A2MP: Get AMP Assoc rsp: id 1 status (0) Success
>       Assoc data [len 39]:
>         MAC: <address>
>         Preferred Chan List number of triplets 4
>           Country code: XXX
>           Reg ext id 201 reg class 254 coverage class 0
>           Channel 1 max power 20
>           Channels 2 - 12 max power 20
>           Channels 4 - 8 max power 0
>         PAL CAP: 00 00 00 00
>         PAL VER: 01 Comp ID: <id> SubVer: 0001
> ...
> ---
>  parser/l2cap.c |  101 +++++++++++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 92 insertions(+), 9 deletions(-)

Applied. Thanks.

Johan
