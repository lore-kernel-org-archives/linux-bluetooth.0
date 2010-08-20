Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTikch9E6mw-YErX7-85yivWVAh2E2iRS3eBc1hp5@mail.gmail.com>
References: <AANLkTikW-OW+Rib6+d6J2vvLeGeTjhR26X2m4Rjnh0fr@mail.gmail.com>
	<AANLkTikch9E6mw-YErX7-85yivWVAh2E2iRS3eBc1hp5@mail.gmail.com>
Date: Fri, 20 Aug 2010 09:52:25 -0700
Message-ID: <AANLkTimZ3uYnpMtb8=RgKUjUM8T-7=C1Gjy4dbH_GXx4@mail.gmail.com>
Subject: Re: PAN performance
From: Han <keepsimple@gmail.com>
To: steven bluez <steven.bluez@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Aug 19, 2010 at 11:59 PM, steven bluez <steven.bluez@gmail.com> wrote:
>
> Hi Han,
> On Fri, Aug 20, 2010 at 9:27 AM, Han <keepsimple@gmail.com> wrote:
>>
>> Hi,
>> I have been using bluetooth PAN to run some personal programs. One
>> thing I noticed is that PAN seems to be very slow (i.e. not up to
>> 3Mbps for BT 2.0). I have bluetooth 2.0 adapters on my laptops and I
>> do SSH over PAN.  Whenever I run a GUI application (on sshd server), i
>> see the GUI response is very slow.  It is not video or anything so I
>> don't think it needs up to 3Mbps. Is this slowness over PAN expected?
>>
>> Thanks.
>> Han
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
>> in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> I think is depending upon the vendor you have. I had a chip which had no
> issues like yours and the 3mbps doesnt come into the scenario you expect
> instead you  get 1-2mbps in bluetooth. If it's bidi direction it might
> vary...My experience of pan would be around 1.5mpbs MAX

I noticed the difference between chips as well. But i saw the issue
even with one of mine better BT doggles ;-).  Btw,  I tried to use
"ssh -C -X"  options and now the latency is much better.

>
> Regards,
> Steven
>
