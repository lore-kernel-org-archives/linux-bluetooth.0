Return-Path: <cyrus@holtmann.org>
Date: Fri, 21 Oct 2011 13:48:26 +0300
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv6 hcidump 2/4] add fixed channel definitions
Message-ID: <20111021104818.GA3934@aemeltch-MOBL1>
References: <1319099414-27993-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1319099414-27993-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20111021083653.GA1800@fusion.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111021083653.GA1800@fusion.localdomain>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Fri, Oct 21, 2011 at 11:36:53AM +0300, Johan Hedberg wrote:
> Hi Andrei,
> 
> On Thu, Oct 20, 2011, Emeltchenko Andrei wrote:
> > ---
> >  lib/l2cap.h |    5 +++++
> >  1 files changed, 5 insertions(+), 0 deletions(-)
> > 
> > diff --git a/lib/l2cap.h b/lib/l2cap.h
> > index 47b3dc3..3880551 100644
> > --- a/lib/l2cap.h
> > +++ b/lib/l2cap.h
> > @@ -139,6 +139,11 @@ struct l2cap_conninfo {
> >  
> >  #define L2CAP_SDULEN_SIZE	2
> >  
> > +/* L2CAP fixed channels */
> > +#define L2CAP_FC_L2CAP		0x02
> > +#define L2CAP_FC_CONNLESS	0x04
> > +#define L2CAP_FC_A2MP		0x08
> > +
> >  /* L2CAP structures */
> >  typedef struct {
> >  	uint16_t	len;
> 
> The first two patches have been applied.
> 
> For the rest, like Marcel suggested, I think it'd be a good idea to have
> proper get_{le,be}{16,32,64} functions. Since we can use these both in
> hcidump and bluez I suppose libbluetooth is the appropriate place for
> them, however in that case (e.g. if you put them in lib/bluetooth.h) a
> _bt prefix should be added.

Would the following code be OK?

diff --git a/lib/bluetooth.h b/lib/bluetooth.h
index b0680e2..158103b 100644
--- a/lib/bluetooth.h
+++ b/lib/bluetooth.h
@@ -125,6 +125,30 @@ do {                                               \
        __p->__v = (val);                       \
 } while(0)
 
+#if __BYTE_ORDER == __LITTLE_ENDIAN
+inline uint64_t bt_get_le64(void *ptr)
+{
+       return bt_get_unaligned((uint64_t *) ptr);
+}
+
+inline uint64_t bt_get_be64(void *ptr)
+{
+       return bswap_64(bt_get_unaligned((uint64_t *) ptr));
+}
+#elif __BYTE_ORDER == __BIG_ENDIAN
+inline uint64_t bt_get_le64(void *ptr)
+{
+       return bswap_64(bt_get_unaligned((uint64_t *) ptr));
+}
+
+inline uint64_t bt_get_be64(void *ptr)
+{
+       return bt_get_unaligned((uint64_t *) ptr);
+}
+#else
+#error "Unknown byte order"
+#endif
+
 /* BD Address */
 typedef struct {
        uint8_t b[6];


Regards,
Andrei
