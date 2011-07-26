Return-Path: <cyrus@holtmann.org>
Date: Tue, 26 Jul 2011 11:05:09 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] hcidump: parsing l2cap info rsp
Message-ID: <20110726080509.GC9775@dell>
References: <1309944083-1261-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1309944083-1261-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Wed, Jul 06, 2011, Emeltchenko Andrei wrote:
> Adds parsing l2cap extended feature mask.
> 
> before:
> hcidump -r /tmp/info-rsp.cap
> HCI sniffer - Bluetooth packet analyzer ver 2.1
> btsnoop version: 1 datalink type: 1002
> > ACL data: handle 11 flags 0x02 dlen 16
>     L2CAP(s): Info rsp: type 2 result 0
>       Extended feature mask 0x00b8
> ---
> after:
> src/hcidump -r /tmp/info-rsp.cap
> HCI sniffer - Bluetooth packet analyzer ver 2.1
> btsnoop version: 1 datalink type: 1002
> > ACL data: handle 11 flags 0x02 dlen 16
>     L2CAP(s): Info rsp: type 2 result 0
>       Extended feature mask 0x00b8
>         Enhanced Retransmission mode
>         Streaming mode
>         FCS Option
>         Fixed Channels
> ---
> ---
>  parser/l2cap.c |   39 +++++++++++++++++++++++++--------------
>  1 files changed, 25 insertions(+), 14 deletions(-)

Applied, thanks. I had to fix the commit message first though: git am
treats --- as the end of the message so when I first applied the second
part was left out.

Johan
