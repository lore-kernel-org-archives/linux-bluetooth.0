Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <76D0096D2AE844EC9E2A4834E474AE0B@freqoneremote>
References: <201108201753.32608.dstockwell@frequency-one.com>
 <20110822103632.GC9949@dell> <76D0096D2AE844EC9E2A4834E474AE0B@freqoneremote>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Mon, 22 Aug 2011 11:42:31 -0300
Message-ID: <CAMOw1v7U3p99h+WA8U-Hp_fb37jZDsv+i--TSKAViyB-stAZ7Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] AVRCP: Corrected metadata: Playing Time
To: David Stockwell <dstockwell@frequency-one.com>
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	BlueZ devel list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

On Mon, Aug 22, 2011 at 8:58 AM, David Stockwell
<dstockwell@frequency-one.com> wrote:
> Btw, it looked like this avrcp_handle_get_element_attributes function
> might not be properly checking the amount of actually received data in
> all necessary places before accessing the buffer (i.e. having the risk
> of remotely triggered buffer overflows). Could you please verify this
> and fix it if the issue really exists.
>
> +++++ I will take a look this afternoon and either send a fix, or send a
> note that it looks OK.

As I answered to Johan before seeing your response, it does have this
problem. I have the PDU-continuation pending here in which I fix this.
I'll probably send it by tomorrow. If you are into it and want to send
a fix, I'm ok with that.

regards,
Lucas De Marchi
