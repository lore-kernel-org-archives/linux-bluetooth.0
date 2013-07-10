Return-Path: <cyrus@holtmann.org>
Date: Wed, 10 Jul 2013 12:37:15 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] lib: Add range check for
 SDP_SVC_ATTR_RSP/SDP_SVC_SEARCH_ATTR_RSP
Message-ID: <20130710093715.GA7781@x220.p-661hnu-f1>
References: <1372278395-22582-1-git-send-email-szymon.janc@gmail.com>
 <105649341.YkdKDHxtUP@athlon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <105649341.YkdKDHxtUP@athlon>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Tue, Jul 09, 2013, Szymon Janc wrote:
> On Wednesday 26 June 2013 22:26:35 Szymon Janc wrote:
> > This is an improved version of recently reverted commit 1796f00e8465.
> > Response size is verified against minimal allowed value only if it is
> > complete response. If response is partial it is allowed by spec that
> > it will be split in arbitrary manner.
> > 
> > Verified against Nokia BH217 on which original commit caused
> > regression.
> > ---
> >  lib/sdp.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/lib/sdp.c b/lib/sdp.c
> > index d8bfc51..54a99b6 100644
> > --- a/lib/sdp.c
> > +++ b/lib/sdp.c
> > @@ -4243,6 +4243,14 @@ int sdp_process(sdp_session_t *session)
> >  		rsp_count = bt_get_be16(pdata);
> >  		SDPDBG("Attrlist byte count : %d", rsp_count);
> > 
> > +		/* Valid range for rsp_count is 0x0002-0xFFFF */
> > +		if (t->rsp_concat_buf.data_size == 0 && rsp_count < 0x0002) {
> > +			t->err = EPROTO;
> > +			SDPERR("Protocol error: invalid AttrList size");
> > +			status = SDP_INVALID_PDU_SIZE;
> > +			goto end;
> > +		}
> > +
> >  		/*
> >  		 * Number of bytes in the AttributeLists parameter(without
> >  		 * continuation state) + AttributeListsByteCount field size.
> 
> ping

Sorry for the delay. The patch has now been pushed upstream. Thanks.

Johan
