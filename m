Return-Path: <cyrus@holtmann.org>
Date: Tue, 9 Oct 2012 11:30:12 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 0/9] Remove some old code
Message-ID: <20121009143011.GA2148@samus>
References: <1349784722-14578-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1349784722-14578-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On 14:11 Tue 09 Oct, Szymon Janc wrote:
> This removes some unused or not needed old code.
> 
> Szymon Janc (9):
>   Simplify checking if found device is legacy
>   Pass confirm name as gboolean value
>   event: Don't store EIR in btd_event_device_found
>   storage: Remove not used read_remote_eir
>   storage: Remove not used write_version_info
>   storage: Remove not used write_features_info
>   storage: Remove not used read_remote_features
>   adapter: Remove not used btd_adapter_switch_{online,offline}
>     functions
>   device: Remove not used device_set_class function
> 
>  src/adapter.c |   95 +++++------------------------------
>  src/adapter.h |    8 ++-
>  src/device.c  |   12 -----
>  src/device.h  |    1 -
>  src/event.c   |   27 ++--------
>  src/event.h   |    6 +--
>  src/mgmt.c    |   13 ++---
>  src/storage.c |  156 ---------------------------------------------------------
>  src/storage.h |   11 ----
>  9 files changed, 26 insertions(+), 303 deletions(-)

Ack.

> 
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Cheers,
-- 
Vinicius
