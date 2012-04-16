Return-Path: <cyrus@holtmann.org>
Date: Mon, 16 Apr 2012 13:29:16 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Mike <puffy.taco@gmail.com>
Cc: Hemant Gupta <hemantgupta.ste@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>, gustavo@padovan.org,
	linux-bluetooth@vger.kernel.org,
	Hemant Gupta <hemant.gupta@stericsson.com>
Subject: Re: [PATCH v4] Bluetooth: Fix packet type for ESCO Link
Message-ID: <20120416102916.GA28314@x220.P-661HNU-F1>
References: <1334116936-16171-1-git-send-email-hemant.gupta@stericsson.com>
 <CACj007krmYyNtOdwjOb3JPyP7yLgEpsceo02JXm4Wrn+pNyQDg@mail.gmail.com>
 <CAB7rCTiTVC2do6ttmGz_uMDn-M79Q+B00fsfDUtH+psqcJ85SA@mail.gmail.com>
 <CAB7rCTiW1g3O=V+Tf2ncN6pJK3EqZjqrfL0aD=md-NAY7j1E3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAB7rCTiW1g3O=V+Tf2ncN6pJK3EqZjqrfL0aD=md-NAY7j1E3w@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Apr 12, 2012, Mike wrote:
> > On Tue, Apr 10, 2012 at 11:13 PM, Hemant Gupta
> > <hemantgupta.ste@gmail.com> wrote:
> >> Hi Marcel, Johan, Gustavo,
> >>
> >> On Wed, Apr 11, 2012 at 9:32 AM, Hemant Gupta
> >> <hemant.gupta@stericsson.com> wrote:
> >>> This patch uses the corect packet type for ESCO Link.
> >>> Without this patch esco packet types were anded with ~EDR_ESCO_MASK
> >>> resulting in setting bits that are not supported by controller
> >>> to 0 which means that corresponding EDR ESCO packet type is
> >>> supported(EDR Packet types are inverted as per BT Spec) which might
> >>> not be the case.
> >>>
> >>> For eg:
> >>> Local Controller supports only 3-EV5, 2-EV5 and 3-EV3 of the EDR eSCO
> >>> packet types and does not support 2-EV3 packet type. This would mean
> >>> that while creating the esco_type in function
> >>> hci_cc_read_local_features() the ESCO_2EV3 bit would not be set and
> >>> all other EDR eSCO bits would be set resulting in
> >>> hdev->esco_type = 0x0380
> >>>
> >>> Now in hci_conn_add() when the pkt_type is being calculated for eSCO
> >>> Link, wrong calculation would take place as below:
> >>>
> >>> conn->pkt_type = hdev->esco_type & ~EDR_ESCO_MASK;
> >>>                = 0x0380 & ~0x03C0 = 0x0380 & 0xFC3F
> >>>               = 0x0000
> >>> Since the EDR eSCO bits are inverted, this would indicate that all
> >>> EDR eSCO packet types are supported, which is not correct as local
> >>> controller is not supporting the 2-EV3 packet type.
> >>>
> >>> As per calculations of the patch
> >>> conn->pkt_type = hdev->esco_type ^ EDR_ESCO_MASK;
> >>>                = 0x0380 ^ 0x03C0
> >>>               = 0x0040
> >>> which correctly indicates that packet type used excludes the 2-EV3
> >>> packet type not supported by local controller.
> >>>
> >>> Signed-off-by: Hemant Gupta <hemant.gupta@stericsson.com>
> >>> Acked-by: Marcel Holtmann <marcel@holtmann.org>
> >>> ---
> >>>  net/bluetooth/hci_conn.c |    2 +-
> >>>  1 files changed, 1 insertions(+), 1 deletions(-)
> >>>
> >>> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> >>> index 947172b..1060fb6 100644
> >>> --- a/net/bluetooth/hci_conn.c
> >>> +++ b/net/bluetooth/hci_conn.c
> >>> @@ -396,7 +396,7 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst)
> >>>                        conn->pkt_type = hdev->pkt_type & SCO_PTYPE_MASK;
> >>>                break;
> >>>        case ESCO_LINK:
> >>> -               conn->pkt_type = hdev->esco_type & ~EDR_ESCO_MASK;
> >>> +               conn->pkt_type = hdev->esco_type ^ EDR_ESCO_MASK;
> >>>                break;
> >>>        }
> >>>
> >>> --
> >>> 1.7.0.4
> >>>
> >>
> >> Resending the patch with Marcel's ACK, because I am not sure if it
> >> made to the mailing list again or not.
> >
> > While this is better, it does not appear complete based on my
> > analysis.  The spec reads as such:
> >
> > The Packet_Type parameter is a bit mask specifying the syn-
> > chronous packet types that are allowed on the link and shall be met. The
> > reserved bits in the Packet_Type field shall be set to one. If all
> > bits are set in
> > the packet type field then all packets types shall be allowed.
> >
> > So, in addition to this problem, the code does not set the reserved
> > bits to 1.  I think that packet_type should be set to 0xFFC0 by
> > default, and then explicitly enable data rates as appropriate.  In
> > this case, the code would then be:
> >
> > conn->pkt_type = 0xFFC0; // before the switch statement
> > conn->pkt_type ^= hdev->esco_type & EDR_ESCO_MASK; // in place of
> > proposed change above
> 
> Ah, this would actually be bad because EV3/4/5 are not part of any
> mask and would then get lost.  Perhaps it would be better to invert
> the defines so that they are named like ESCO_NO_2EV3 and then we
> wouldn't need such funny math?  Then EV3/4/5 could be added to the
> mask.
> 
> > This would also need to be corrected for the other case statements.
> 
> The SCO_LINK case should not include the (hdev->esco_type &
> EDR_ESCO_MASK) because EDR rates are not supported for SCO.  I'm not
> sure what the intended math was there (just happens in the case that
> all are supported that they are listed as not supported if link is
> SCO_LINK).  Similarly for SCO_LINK in hci_event.c
> hci_sync_conn_complete_evt where the pkt_type is redefined.  But it
> still also does not follow spec on reserved bits.

So what's the status with the evolution of this patch. Should the v4 be
applied and improvements be done on top of that, or is there a v5 coming
up soon, or what?

Johan
