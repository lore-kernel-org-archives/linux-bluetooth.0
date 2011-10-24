Return-Path: <cyrus@holtmann.org>
Date: Mon, 24 Oct 2011 13:26:06 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Vinicius Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH bluez] add get_le/get_be helpers
Message-ID: <20111024102603.GD31896@aemeltch-MOBL1>
References: <1319448004-8513-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <CAE6HaMkxvTPa1eTj1Og7Lvqn=PvieuKJyzugPouwiUTOsnnW_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAE6HaMkxvTPa1eTj1Og7Lvqn=PvieuKJyzugPouwiUTOsnnW_g@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Mon, Oct 24, 2011 at 12:13:43PM +0200, Vinicius Gomes wrote:
> Hi Andrei,
> 
> On Mon, Oct 24, 2011 at 11:20 AM, Emeltchenko Andrei
> <Andrei.Emeltchenko.news@gmail.com> wrote:
> > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> >
> > Helpers to access LE / BE values. In bluetooth there is a mixture
> > of LE / BE network byte order.
> > ---
> 
> Sorry if this comes too late, but here's an idea:
> 
> How about changing the name of the functions to something a little
> more high level, for example: in attrib/att.h we have
> att_{get,put}_u16() that uses the byte order defined in the ATT spec
> (little endian).
> 
> So my suggestion is to have bt_{get,put}_u*() and sdp_{get,put}_u*
> functions (perhaps also no_{get,put}_u* for cases when we use the host
> byte order). The bt_ functions will be used for everything that uses
> the Bluetooth byte order and the sdp_ ones for SDP, which is the only

maybe we can define bt_{get,put}_u*() as bt_{get,put}_le*() and be with
SDP?

Best regards 
Andrei Emeltchenko 

> case of Big Endian defined by Bluetooth, correct me if I am wrong.
> 
> What do you think?
> 
> >  lib/bluetooth.h |   64 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 files changed, 64 insertions(+), 0 deletions(-)
> >
> > diff --git a/lib/bluetooth.h b/lib/bluetooth.h
> > index b0680e2..5bd4f03 100644
> > --- a/lib/bluetooth.h
> > +++ b/lib/bluetooth.h
> > @@ -125,6 +125,70 @@ do {                                               \
> >        __p->__v = (val);                       \
> >  } while(0)
> >
> > +#if __BYTE_ORDER == __LITTLE_ENDIAN
> > +static inline uint64_t bt_get_le64(void *ptr)
> > +{
> > +       return bt_get_unaligned((uint64_t *) ptr);
> > +}
> > +
> > +static inline uint64_t bt_get_be64(void *ptr)
> > +{
> > +       return bswap_64(bt_get_unaligned((uint64_t *) ptr));
> > +}
> > +
> > +static inline uint32_t bt_get_le32(void *ptr)
> > +{
> > +       return bt_get_unaligned((uint32_t *) ptr);
> > +}
> > +
> > +static inline uint32_t bt_get_be32(void *ptr)
> > +{
> > +       return bswap_32(bt_get_unaligned((uint32_t *) ptr));
> > +}
> > +
> > +static inline uint16_t bt_get_le16(void *ptr)
> > +{
> > +       return bt_get_unaligned((uint16_t *) ptr);
> > +}
> > +
> > +static inline uint16_t bt_get_be16(void *ptr)
> > +{
> > +       return bswap_16(bt_get_unaligned((uint16_t *) ptr));
> > +}
> > +#elif __BYTE_ORDER == __BIG_ENDIAN
> > +static inline uint64_t bt_get_le64(void *ptr)
> > +{
> > +       return bswap_64(bt_get_unaligned((uint64_t *) ptr));
> > +}
> > +
> > +static inline uint64_t bt_get_be64(void *ptr)
> > +{
> > +       return bt_get_unaligned((uint64_t *) ptr);
> > +}
> > +
> > +static inline uint32_t bt_get_le32(void *ptr)
> > +{
> > +       return bswap_32(bt_get_unaligned((uint32_t *) ptr));
> > +}
> > +
> > +static inline uint32_t bt_get_be32(void *ptr)
> > +{
> > +       return bt_get_unaligned((uint32_t *) ptr);
> > +}
> > +
> > +static inline uint16_t bt_get_le16(void *ptr)
> > +{
> > +       return bswap_16(bt_get_unaligned((uint16_t *) ptr));
> > +}
> > +
> > +static inline uint16_t bt_get_be16(void *ptr)
> > +{
> > +       return bt_get_unaligned((uint16_t *) ptr);
> > +}
> > +#else
> > +#error "Unknown byte order"
> > +#endif
> > +
> >  /* BD Address */
> >  typedef struct {
> >        uint8_t b[6];
> > --
> > 1.7.4.1
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> 
> 
> Cheers,
> -- 
> Vinicius
