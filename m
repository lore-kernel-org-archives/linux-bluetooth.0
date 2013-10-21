Return-Path: <cyrus@holtmann.org>
Date: Mon, 21 Oct 2013 16:26:16 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] core: Fix not forwarding errors caused by SDP
 search properly
Message-ID: <20131021132616.GB31014@x220.p-661hnu-f1>
References: <1382360648-5167-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1382360648-5167-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Mon, Oct 21, 2013, Luiz Augusto von Dentz wrote:
> In case bt_search_service fails while processing (e.g. connection is
> dropped) the error forward is a positive value leading
> btd_service_connecting_complete to not change any state at all.
> 
> Futhermore the error from sdp_process was completely ignored which may
> cause problems as well.
> ---
>  src/sdp-client.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Applied. Thanks.

Johan
