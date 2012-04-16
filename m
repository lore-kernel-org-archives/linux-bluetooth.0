Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120416091944.GA25476@x220.P-661HNU-F1>
References: <1334567093-15058-1-git-send-email-hemant.gupta@stericsson.com>
	<20120416091944.GA25476@x220.P-661HNU-F1>
Date: Mon, 16 Apr 2012 14:51:51 +0530
Message-ID: <CACj007ntAOqYCo0fs7a2TeXGTitxB3RfTAu+obgN9VJuxiXNkA@mail.gmail.com>
Subject: Re: [PATCH v1 0/1] Bluetooth: mgmt: Add helper function for Address Type
From: Hemant Gupta <hemantgupta.ste@gmail.com>
To: Hemant Gupta <hemant.gupta@stericsson.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Mon, Apr 16, 2012 at 2:49 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Hemant,
>
> On Mon, Apr 16, 2012, Hemant Gupta wrote:
>> +static u8 mgmt_to_link(u8 link_type, u8 addr_type)
>> +{
>> +     switch (link_type) {
>> +     case LE_LINK:
>> +             switch (addr_type) {
>> +             case MGMT_ADDR_LE_PUBLIC:
>> +                     return ADDR_LE_DEV_PUBLIC;
>> +
>> +             default:
>> +                     /* Fallback to LE Random address type */
>> +                     return ADDR_LE_DEV_RANDOM;
>> +             }
>> +
>> +     default:
>> +             /* Fallback to BR/EDR type */
>> +             return ACL_LINK;
>> +     }
>> +}
>
> This isn't right. The mgmt address type includes all possible address
> types in it, i.e. the input to this function should be a single value
> and the output should be two separate values (just like link_to_mgmt has
> two inputs and one output).
>
> However, I'm not sure you even need this generic helper here since you
> only have a single user for it and it's restricted to LE only. If we get
> more users then we can consider it, but for now either do the conversion
> inline or do an LE specific helper:
>
> static u8 mgmt_to_le(u8 mgmt_type)
> {
>        switch (mgmt_type) {
>        case MGMT_ADDR_LE_PUBLIC:
>                return ADDR_LE_DEV_PUBLIC;
>        case MGMT_ADDR_LE_RANDOM:
>        default:
>                return ADDR_LE_DEV_RANDOM;
> }
>
Thanks for the comemnts, will send new patch shortly.
> Johan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Hemant Gupta
ST-Ericsson India
