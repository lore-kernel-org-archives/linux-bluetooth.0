Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
References: <1525248985-10990-1-git-send-email-nagaraj.dr@samsung.com>
 <CGME20180502081635epcas2p170eb2b4ed9336425921119b66e554fef@epcms5p6>
 <CABBYNZ++cdKY256edfNkMU6tsaccRrqg6eN9scdTK5m8t2Okxw@mail.gmail.com> <20180502121827epcms5p6a7927635ac30d7f3cacb0e1d9ccfe467@epcms5p6>
In-Reply-To: <20180502121827epcms5p6a7927635ac30d7f3cacb0e1d9ccfe467@epcms5p6>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 02 May 2018 12:41:38 +0000
Message-ID: <CABBYNZKNy2jV3YhPB0+1GC0OuDimgQ8XRRwC_i9PCNQEm354EA@mail.gmail.com>
Subject: Re: Re: [PATCH] src/device.c : Fix BREDR-ATT MTU issue
To: nagaraj.dr@samsung.com
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Syam Sidhardhan <s.syam@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Nagaraj,
On Wed, May 2, 2018 at 3:18 PM Nagaraj D R <nagaraj.dr@samsung.com> wrote:

> Hello Luiz

> Sender : Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> >Hi Nagaraj,
> >On Wed, May 2, 2018 at 11:40 AM Nagaraj D R <nagaraj.dr@samsung.com>
wrote:

> >> For BREDR-ATT, according to spec, ATT MTU is same has
> >> L2CAP configured MTU on which ATT is running. So, set the MTU to
> >> L2CAP configuration and for LE-ATT adjust the ATT MTU based on
> >> EXCHANGE_MTU request and response.
> >> ---
> >>   src/device.c              | 2 +-
> >>   src/shared/gatt-helpers.c | 1 +
> >>   2 files changed, 2 insertions(+), 1 deletion(-)

> >> diff --git a/src/device.c b/src/device.c
> >> index f693b70..cf4c8df 100644
> >> --- a/src/device.c
> >> +++ b/src/device.c
> >> @@ -4922,7 +4922,7 @@ bool device_attach_att(struct btd_device *dev,
> GIOChannel *io)
> >>          }

> >>          dev->att_mtu = MIN(mtu, BT_ATT_MAX_LE_MTU);
> >> -       attrib = g_attrib_new(io, BT_ATT_DEFAULT_LE_MTU, false);
> >> +       attrib = g_attrib_new(io, dev->att_mtu, false);

> >This would actually undo the following patch:

> >     src/device: Use BT_ATT_DEFAULT_LE_MTU as default MTU

> >   Use the default MTU until an MTU exchange has taken place and
> >     something else has been negotiated. If either side does not support
> >    MTU exchange, the connection shall continue to use this default
> >     value instead of the device maximum which was the previous behavior.

> >We should probably check if the cid is for LE or not and reset mtu to
> >BT_ATT_DEFAULT_LE_MTU that way att_mtu should be valid for either LE or
> >BR/EDR.

> I agree, we should check for CID.
> If it is BREDR-ATT connection only then consider L2CAP MTU otherwise
> set the MTU to min value and set it through ATT_MTU exchange.

> >>          if (!attrib) {
> >>                  error("Unable to create new GAttrib instance");
> >>                  return false;
> >> diff --git a/src/shared/gatt-helpers.c b/src/shared/gatt-helpers.c
> >> index 6b39bb1..8ec65be 100644
> >> --- a/src/shared/gatt-helpers.c
> >> +++ b/src/shared/gatt-helpers.c
> >> @@ -517,6 +517,7 @@ static void mtu_cb(uint8_t opcode, const void *pdu,
> uint16_t length,
> >>          if (opcode == BT_ATT_OP_ERROR_RSP) {
> >>                  success = false;
> >>                  att_ecode = process_error(pdu, length);
> >> +               bt_att_set_mtu(op->att, BT_ATT_DEFAULT_LE_MTU);

> >I not following this one, we only really use bt_att_set_mtu if the
command
> >succeeds so this should not be necessary, or this is due Exchange being
> >used multiple times? I recall the spec not allowing that to happen, and
if
> >does Im not sure why we would have to return to the default instead of
the
> >value previously set in case the of error response.

> This change was in connection with my proposed change.
> i.e We set the MTU to L2CAP-MTU (for both LE-ATT and BREDR-ATT)
> In case of LE-ATT, if remote does not support the ATT-MTU exchange
procedure,
> then it will return "BT_ATT_OP_ERROR_RSP" and we will fall back to
default-MTU

> With CID check that you advised, this change won't be necessary.

Ok now it is clear, so I suppose you will be sending a v2 shortly?





-- 
Luiz Augusto von Dentz
