Return-Path: <cyrus@holtmann.org>
Message-ID: <ac7ff8702ceb37a52f2c389f5156d8e5.squirrel@www.codeaurora.org>
In-Reply-To: <AANLkTiny5zM=1vEPyn6iE9cJqi0v_o_i12GOUg=n=Dc7@mail.gmail.com>
References: <4C5F6B58.6000702@codeaurora.org> <20100810220238.GB3203@vigoh>
    <alpine.DEB.2.00.1008101925000.6276@linux-sea-02>
    <20100811031551.GA8985@vigoh>
    <AANLkTiny5zM=1vEPyn6iE9cJqi0v_o_i12GOUg=n=Dc7@mail.gmail.com>
Date: Thu, 12 Aug 2010 12:53:25 -0700 (PDT)
Subject: Re: QuiC AMP development
From: "Peter Krystad" <pkrystad@codeaurora.org>
To: "sober song" <sobersong2001@gmail.com>
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	"Mat Martineau" <mathewm@codeaurora.org>,
	"Ron Shaffer" <rshaffer@codeaurora.org>,
	linux-bluetooth@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Hi Sober,

Be careful not to top-post on this mailing list.

> Hi Shaffer/Peter
>
> static inline int send_a2mp_cmd(struct amp_mgr *mgr, u8 ident, u8
> code, u16 len, void *data) {
> 	struct a2mp_cmd_hdr *hdr;
> 	int plen;
> 	u8 *buf;
>
> 	BT_DBG("ident %d code %d", ident, code);
> 	plen = sizeof(*hdr) + len;
> 	buf = kzalloc(plen, GFP_ATOMIC);
> 	if (!buf)
> 		return -ENOMEM;
> 	hdr = (struct a2mp_cmd_hdr *) buf;
> 	hdr->code  = code;
> 	hdr->ident = ident;
> 	hdr->len   = cpu_to_le16(len);
> 	buf += sizeof(*hdr);
> 	memcpy(buf, data, len);
> 	return send_a2mp(mgr->a2mp_sock, (u8 *) hdr, plen);
> }
>
> I see that here have a malloc, but i don't see free, doesn't it cause
> memleak?
>

Looks like it, thanks. As Mat and I explained to Kevin and Dan at the
mini-summit the git repo we posted is a snapshot of our development tree,
and was provided so interested parties could review our approach. As we
post patches to the mailing list your review will be much appreciated.

> Regards
> sober
>
>

>>> >
>>> >* Ron Shaffer <rshaffer@codeaurora.org> [2010-08-08 21:43:36 -0500]:
>>> >
>>> >>As requested in today's summit discussions, here's a link that can be
>>> >>used to inspect the code we've done to add AMP support on the latest
>>> >>next tree.
>>> >>
>>> >>https://www.codeaurora.org/gitweb/quic/bluetooth/?p=bluetooth-next-2.6.git;a=summary
>>> >>branch pk-upstream
>>> >
>>> >


Peter.

-- 

Peter Krystad

Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum


