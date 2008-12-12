Return-Path: <cyrus@holtmann.org>
Message-ID: <d89ddf300812121119o601fe1acs229741960a98835c@mail.gmail.com>
Date: Fri, 12 Dec 2008 12:19:20 -0700
From: "Brad Midgley" <bmidgley@gmail.com>
To: "Siarhei Siamashka" <siarhei.siamashka@nokia.com>
Subject: Re: [RFC/PATCH] sbc: new filtering function for 8 band fixed point encoding
Cc: "Jaska Uimonen" <jaska.uimonen@nokia.com>,
	linux-bluetooth@vger.kernel.org
In-Reply-To: <200812121914.48340.siarhei.siamashka@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1227879337.20555.12.camel@esdhcp03999.research.nokia.com>
	 <Pine.LNX.4.64.0812021203290.6346@xena.cft.ca.us>
	 <200812121914.48340.siarhei.siamashka@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Guys

One mistake we made was not keeping track of what functions we were
applying to the published tables as we worked things to look less and
less like the pseudocode in the spec. So if you start again from one
of the tables in the spec, keep a comment like

/* ourtable(x) = (int32)(table1(x) << 16) */

Which in this case would mean that in ourtable we've shifted the
original table1 float value left 16 bits and truncated it to an int32.

I also combined tables or split tables to simplify our loop logic or
eliminate operations; an explanation in a comment would have been
appropriate.

Brad

On Fri, Dec 12, 2008 at 10:14 AM, Siarhei Siamashka
<siarhei.siamashka@nokia.com> wrote:
> On Fri, 28 Nov 2008, Jaska Uimonen wrote:
>> I did some testing on the current 8 band fixed point
>> encoding and it seems to attenuate frequencies below 800Hz
>> and above 18kHz. There might be some other stuff happening
>> also, because at least to me the bass seemed to lack some
>> "definition".
>> I didn't quite understand how the current tables are calculated
>> and how the filtering works so I wrote a new filtering function
>> and calculated new filter tables for it. It is written
>> using 16 bit fixed point without any platform specific optimizations.
>> I only unrolled some loops etc. I tried to follow the
>> flow chart in MPEG-1 annex c.
>
>> +/*
>> + * to produce this Q15 format table:
>> + *
>> + * Get the filter coeffs from the spec and multiply them by 2^15.
>> + */
>> +static const signed short _sbc_proto_fixed8[80] = {
>> +       0, 5, 11, 18, 26, 37, 48, 58, 65, 68,
>> +       65, 52, 29, -5, -54, -114, 185, 263, 342, 417,
>> +       480, 521, 531, 501, 423, 290, 95, -161, -479, -855,
>> +       -1280, -1742, 2228, 2719, 3197, 3643, 4039, 4366, 4612, 4764,
>> +       4815, 4764, 4612, 4366, 4039, 3643, 3197, 2719, -2228, -1742,
>> +       -1280, -855, -479, -161, 95, 290, 423, 501, 531, 521,
>> +       480, 417, 342, 263, -185, -114, -54, -5, 29, 52,
>> +       65, 68, 65, 58, 48, 37, 26, 18, 11, 5
>> +};
>
> Just remembered to check this. Precision and audio quality should be a bit
> better if the original floating values are not truncated, but rounded when put
> into tables.
>
> For example, the fifth element is 26 in _sbc_proto_fixed8 table, but it was
> 26.998194372608 after multiplication and before conversion to integer.
> Using 27 would have been a bit more correct here.
>
> --
> Best regards,
> Siarhei Siamashka
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
Brad Midgley
