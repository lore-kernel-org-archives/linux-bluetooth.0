Return-Path: <cyrus@holtmann.org>
Date: Tue, 12 Aug 2014 12:04:49 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2 01/10] monitor: Fix segmentation fault with malformed
 packet
Message-ID: <20140812090449.GA18519@t440s.ger.corp.intel.com>
References: <1407743445-1329-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20140811132233.GA27174@t440s>
 <20140812075535.GC10034@aemeltch-MOBL1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140812075535.GC10034@aemeltch-MOBL1>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Tue, Aug 12, 2014, Andrei Emeltchenko wrote:
> MAX_PACKET_SIZE is defined in many places and NEVER explained.
> 
>    1     45  android/bluetoothd-snoop.c <<MAX_PACKET_SIZE>>
>              #define MAX_PACKET_SIZE (1486 + 4)
>    2     42  monitor/analyze.c <<MAX_PACKET_SIZE>>
>              #define MAX_PACKET_SIZE (1486 + 4)
>    3     55  monitor/control.c <<MAX_PACKET_SIZE>>
>              #define MAX_PACKET_SIZE (1486 + 4)
>    4     47  src/shared/btsnoop.h <<MAX_PACKET_SIZE>>
>              #define MAX_PACKET_SIZE (1486 + 4)

Let's fix that then and explain it in the code.

> Maybe insetad of btsnoop.h I define it in src/shared/btsnoop.c

Sounds to me like all those places include btsnoop.h, meaning a common
define in btsnoop.h might be the best way forward.

Johan
