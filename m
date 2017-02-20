Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170216180315.30531-1-eu@felipetonello.com>
References: <20170216180315.30531-1-eu@felipetonello.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 20 Feb 2017 17:21:10 +0200
Message-ID: <CABBYNZL7W15pdvZLezBO146RXw8ADNXcatiuU2XhEA9A0tzSMA@mail.gmail.com>
Subject: Re: [PATCH v2 BlueZ 0/7] Improvements on connection parameters update
To: "Felipe F. Tonello" <eu@felipetonello.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Felipe,

On Thu, Feb 16, 2017 at 8:03 PM, Felipe F. Tonello <eu@felipetonello.com> wrote:
> This is one of the parts of a series of patches related to connection
> parameters update.
>
> This initial implementation adds supports to GAP Peripheral Preferred
> Connection Parameters (PPCP) characteristic and the Slave Connection Interval
> Range Advertising Data (AD).


Are there any devices implementing these? Id like to do a some testing
but haven't find anything implementing this, or well I can generate
the PPCP but the SCRAD is probably a waste of AD since that is pretty
limited in size.

> There is a problem described in #4 that due to a limitation of the BlueZ API
> it is not possible to update the current connection with specific parameters.
> I am working on a socket option API to allow something similar. Hopefully I
> will be able to write something that covers this use-case as well. This
> problem also applies to patch #6.
>
> Changes from v1:
>  * Added Slave Connection Interval Range AD support;
>  * Unit tests for connection interval.
>
> Felipe F. Tonello (7):
>   profiles/gap: Some code cleanup
>   src/adapter: Added connection parameter load/store functions
>   src/device: Added function to set connection parameters
>   profiles/gap: Added support for PPCP characteristic
>   src/eir: Added support for Slave Connection Interval Range AD
>   src/adapter: Store Slave Connection Interval Range
>   unit/test-eir: Added tests for connection interval
>
>  profiles/gap/gas.c | 111 +++++++++++++++++++++++++++++++++++++++++++----------
>  src/adapter.c      |  46 +++++++++++++++++++++-
>  src/adapter.h      |   9 +++++
>  src/device.c       |  16 ++++++++
>  src/device.h       |   4 ++
>  src/eir.c          |   7 ++++
>  src/eir.h          |   3 ++
>  unit/test-eir.c    |  26 +++++++++++--
>  8 files changed, 196 insertions(+), 26 deletions(-)
>
> --
> 2.11.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
