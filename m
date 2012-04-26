Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120426143129.GA7588@x220.P-661HNU-F1>
References: <1333572353-10332-1-git-send-email-jefferson.delfes@openbossa.org>
 <1334350864-5509-1-git-send-email-jefferson.delfes@openbossa.org>
 <1334350864-5509-2-git-send-email-jefferson.delfes@openbossa.org> <20120426143129.GA7588@x220.P-661HNU-F1>
From: Jefferson Delfes <jefferson.delfes@openbossa.org>
Date: Thu, 26 Apr 2012 10:55:55 -0400
Message-ID: <CA+_d9qdnpHio47bRagEc=Q+1n=MQzcLD++fpSjvLOM4Rf+bRhQ@mail.gmail.com>
Subject: Re: [PATCHv2 BlueZ 1/2] GATT: Add support for find included services
To: Jefferson Delfes <jefferson.delfes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan.

On Thu, Apr 26, 2012 at 10:31 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Jefferson,
>
> On Fri, Apr 13, 2012, Jefferson Delfes wrote:
>> --- a/attrib/gatt.c
>> +++ b/attrib/gatt.c
>> @@ -47,6 +47,22 @@ struct discover_primary {
>>       void *user_data;
>>  };
>>
>> +struct find_included {
>> +     GAttrib         *attrib;
>> +     uint16_t        end;
>> +     GSList          *includes;
>> +     gatt_cb_t       cb;
>> +     void            *user_data;
>> +     uint16_t        missing_uuids;  /* number of missing 128-bit UUID */
>> +     gboolean        final;          /* final data flag */
>> +     unsigned int    err;
>> +};
>> +
>> +struct find_include_data {
>> +     struct find_included *find_incl;
>> +     struct gatt_included *gatt_incl;
>> +};
>
> The reason I didn't apply this immediately and instead put it aside (and
> then forgot about it) is that I'm having trouble figuring out these data
> structures, their purposes and their relation to each other. The first
> thing that starts off the confusion is that you've named than based on
> an action instead of something that could be considered an object.
>
> So please try to come up with better naming for them, and if the new
> names do not in themselves already explain most of the purpose then at
> least provide proper code comments to clarify this.

Hmm, ok. I will think up a better naming for them.

> Another thing that threw me off is the "fid" variable naming. The
> existing and most common use of "id" is a shorthand for "identifier". So
> what's "fid"? A file identifier? Please come up with better names for
> these things. In many cases the context is quite clear and if you can't
> come up with anything better simply "data" could be good enough.

Yeah, it seems ambiguous.

> Johan

Thanks for your feedback.
