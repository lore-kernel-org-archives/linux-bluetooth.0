Return-Path: <cyrus@holtmann.org>
Date: Mon, 5 Dec 2011 13:49:45 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Slawomir Bochenski <lkslawek@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd] MAP: Skeleton of application parameters support
Message-ID: <20111205114945.GA24248@fusion.localdomain>
References: <1322224823-27366-1-git-send-email-lkslawek@gmail.com>
 <20111205092212.GA11653@fusion.localdomain>
 <CA+i+Aw3Y3n1Z-gpKi+quKQ=R7Nnvk28NWLtbCY8=OAS-ubvwPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CA+i+Aw3Y3n1Z-gpKi+quKQ=R7Nnvk28NWLtbCY8=OAS-ubvwPQ@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Slawek,

On Mon, Dec 05, 2011, Slawomir Bochenski wrote:
> >> +map_ap_t *map_ap_parse(const uint8_t *buffer, uint32_t len)
> >> +{
> >> +     return NULL;
> >> +}
> >> +
> >> +GString *map_ap_output(map_ap_t *ap)
> >> +{
> >> +     return NULL;
> >> +}
> >
> > Is map_ap_output supposed to be the inverse of map_ap_parse? Why const
> > uint8_t * for parse but GString * for output? Also (assuming that they
> > really are supposed to be inverses) encode/decode would be clearer.
> 
> Yes, map_ap_output is inverse of map_ap_parse. uint8_t was chosen
> after obex_get_apparam(). GString only as a convenience type that
> stores together buffer and length. Would you prefer it to return size
> and pass uint8_t ** to it (or reverse way)? Encode/decode is fine with
> me.

Let's go with:

map_ap_t *map_ap_decode(const uint8_t *buf, size_t len);
uint8_t *map_ap_encode(map_ap_t *ap, size_t *len);

> >> +gboolean map_ap_get(map_ap_t *ap, enum map_ap_tag tag, void *value)
> >> +{
> >> +     return FALSE;
> >> +}
> >> +
> >> +gboolean map_ap_set(map_ap_t *ap, enum map_ap_tag tag, void *value)
> >> +{
> >> +     return FALSE;
> >> +}
> >
> > In a way having these generic get/set functions keeps the API small and
> > clean, but then again there are only four possible types: 1, 2 and 4
> > byte uints and strings. If there were get_u32, get_string, set_string,
> > etc, you wouldn't e.g. need temporary variables to pass uints to the set
> > functions but could pass constants directly and you'd also get the
> > compiler to do some type checking for you (of course you still need to
> > have an internal table to check which type a specific tag should have).
> 
> Make the choice here. For me it doesn't make a big difference.

Let's go with individual get/set functions for each type then. How
about:

gboolean map_ap_get_u8(map_ap_t *ap, enum map_ap_tag tag, uint8_t *val);
gboolean map_ap_get_u16(map_ap_t *ap, enum map_ap_tag tag, uint16_t *val);
gboolean map_ap_get_u32(map_ap_t *ap, enum map_ap_tag tag, uint32_t *val);
const char *map_ap_get_string(map_ap_t *ap, enum map_ap_tag tag);

gboolean map_ap_set_u8(map_ap_t *ap, enum map_ap_tag tag, uint8_t val);
gboolean map_ap_set_u16(map_ap_t *ap, enum map_ap_tag tag, uint16_t val);
gboolean map_ap_set_u32(map_ap_t *ap, enum map_ap_tag tag, uint32_t val);
gboolean map_ap_set_string(map_ap_t *ap, enum map_ap_tag tag, const char *val);

> > Since we now have unit/* in place it'd be nice if you could also add
> > unit tests for this API as you go along implementing it.
> 
> Have they to be present already in this patch or can be added a bit later?

Not necessarily in this first patch which only adds a skeleton, but it
wouldn't hurt to have them part of subsequent patches which add the
actual implementation (after all you'll probably want to test and verify
the implementation before sending patches).

Johan
