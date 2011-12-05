Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20111205092212.GA11653@fusion.localdomain>
References: <1322224823-27366-1-git-send-email-lkslawek@gmail.com>
	<20111205092212.GA11653@fusion.localdomain>
Date: Mon, 5 Dec 2011 10:55:50 +0100
Message-ID: <CA+i+Aw3Y3n1Z-gpKi+quKQ=R7Nnvk28NWLtbCY8=OAS-ubvwPQ@mail.gmail.com>
Subject: Re: [PATCH obexd] MAP: Skeleton of application parameters support
From: Slawomir Bochenski <lkslawek@gmail.com>
To: Slawomir Bochenski <lkslawek@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Dec 5, 2011 at 10:22 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Slawek,
>
> On Fri, Nov 25, 2011, Slawomir Bochenski wrote:
>> + *  Author: Slawomir Bochenski <lkslawek@gmail.com>
>
> We don't have this convention in other files either so let's not break
> the consistency. We have the AUTHORS file and the git commit history to
> get this kind of info anyway.
>
>> +map_ap_t *map_ap_new(void)
>> +{
>> +     return NULL;
>> +}
>> +
>> +void map_ap_free(map_ap_t *ap)
>> +{
>> +}
>> +
>> +map_ap_t *map_ap_parse(const uint8_t *buffer, uint32_t len)
>> +{
>> +     return NULL;
>> +}
>> +
>> +GString *map_ap_output(map_ap_t *ap)
>> +{
>> +     return NULL;
>> +}
>
> Is map_ap_output supposed to be the inverse of map_ap_parse? Why const
> uint8_t * for parse but GString * for output? Also (assuming that they
> really are supposed to be inverses) encode/decode would be clearer.

Yes, map_ap_output is inverse of map_ap_parse. uint8_t was chosen
after obex_get_apparam(). GString only as a convenience type that
stores together buffer and length. Would you prefer it to return size
and pass uint8_t ** to it (or reverse way)? Encode/decode is fine with
me.

>> +gboolean map_ap_get(map_ap_t *ap, enum map_ap_tag tag, void *value)
>> +{
>> +     return FALSE;
>> +}
>> +
>> +gboolean map_ap_set(map_ap_t *ap, enum map_ap_tag tag, void *value)
>> +{
>> +     return FALSE;
>> +}
>
> In a way having these generic get/set functions keeps the API small and
> clean, but then again there are only four possible types: 1, 2 and 4
> byte uints and strings. If there were get_u32, get_string, set_string,
> etc, you wouldn't e.g. need temporary variables to pass uints to the set
> functions but could pass constants directly and you'd also get the
> compiler to do some type checking for you (of course you still need to
> have an internal table to check which type a specific tag should have).

Make the choice here. For me it doesn't make a big difference.

> Btw, I assume that you've planned the API to take care of the big-endian
> conversion internally?

True. This is mentioned in documentation comment for map_ap_parse.

>> +     MAP_AP_INVALID                  = 0x100,
>
> Where do you plan to use this value?

This is leftover of implementation detail. I use it as a guard for
array storing parameter types definitions.

> Since we now have unit/* in place it'd be nice if you could also add
> unit tests for this API as you go along implementing it.

Have they to be present already in this patch or can be added a bit later?

-- 
Slawomir Bochenski
