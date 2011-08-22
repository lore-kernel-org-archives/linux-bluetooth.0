Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <165376978.336156.1314031379433.JavaMail.open-xchange@oxusltgw02.schlund.de>
References: <201108201753.32608.dstockwell@frequency-one.com>
 <20110822103632.GC9949@dell> <76D0096D2AE844EC9E2A4834E474AE0B@freqoneremote>
 <CAMOw1v7U3p99h+WA8U-Hp_fb37jZDsv+i--TSKAViyB-stAZ7Q@mail.gmail.com> <165376978.336156.1314031379433.JavaMail.open-xchange@oxusltgw02.schlund.de>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Mon, 22 Aug 2011 16:55:47 -0300
Message-ID: <CAMOw1v6YJAn_p=5S6reDGeX2NdM5kP_XjAT_2wGj0SXV7MuO7A@mail.gmail.com>
Subject: Re: [PATCH 3/3] AVRCP: Corrected metadata: Playing Time
To: "dstockwell@frequency-one.com" <dstockwell@frequency-one.com>
Cc: BlueZ devel list <linux-bluetooth@vger.kernel.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Aug 22, 2011 at 1:42 PM, dstockwell@frequency-one.com
<dstockwell@frequency-one.com> wrote:
> Hello Lucas
>
> On August 22, 2011 at 10:42 AM Lucas De Marchi
> <lucas.demarchi@profusion.mobi> wrote:
>
>> Hi David,
>>
>> On Mon, Aug 22, 2011 at 8:58 AM, David Stockwell
>> <dstockwell@frequency-one.com> wrote:
>> > Btw, it looked like this avrcp_handle_get_element_attributes function
>> > might not be properly checking the amount of actually received data in
>> > all necessary places before accessing the buffer (i.e. having the risk
>> > of remotely triggered buffer overflows). Could you please verify this
>> > and fix it if the issue really exists.
>> >
>> > +++++ I will take a look this afternoon and either send a fix, or send a
>> > note that it looks OK.
>>
>> As I answered to Johan before seeing your response, it does have this
>> problem. I have the PDU-continuation pending here in which I fix this.
>> I&apos;ll probably send it by tomorrow. If you are into it and want to
>> send
>> a fix, I&apos;m ok with that.
>
>
>
> If you already have a fix for that function, go ahead and submit it.
>
>
>
> Wondering what you mean by "PDU-continuation pending", though.  Does it have
>
> to do with AVRCP-level RequestContinuingResponse (and Abort)?  Or
> AVCTP-layer
>
> fragmentation?


AVRCP-level RequestContinuingResponse (and Abort)


regards,
Lucas De Marchi
