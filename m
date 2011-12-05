Return-Path: <cyrus@holtmann.org>
From: "Ganir, Chen" <chen.ganir@ti.com>
To: Brian Gix <bgix@codeaurora.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: SMP Key distribution
Date: Mon, 5 Dec 2011 15:48:31 +0000
Message-ID: <F0070FBC0FB3174D8D11444EB2D5B02644029C@DNCE02.ent.ti.com>
References: <F0070FBC0FB3174D8D11444EB2D5B02643FFBB@DNCE02.ent.ti.com>
 <4EDCE598.20808@codeaurora.org>
In-Reply-To: <4EDCE598.20808@codeaurora.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Brian,
 
> -----Original Message-----
> From: Brian Gix [mailto:bgix@codeaurora.org]
> Sent: Monday, December 05, 2011 5:39 PM
> To: Ganir, Chen
> Cc: linux-bluetooth@vger.kernel.org
> Subject: Re: SMP Key distribution
> 
> Hi Chen,
> 
> On 12/5/2011 1:02 AM, Ganir, Chen wrote:
> > Hi.
> >
> > According to the SMP spec (Vol3, Part H, Appendix 5.3.4), keys are
> distributed in a specific order, where the slave first sends its
> LTK,EDIV, RAND , IRK, ADDR TYPE and signature key (according to the key
> distribution parameter. Only when the slave completes its key
> distribution, the master then starts distributing its own keys (same
> order, according to the master key distribution options). In the
> current implementation in the smp.c, it seems that we start
> distributing our keys too early (after the MASTER IDENTIFICATION
> message, ignoring the possibility of Addr type and signature keys which
> may come from the slave. This may break the key distribution phase.
> >
> > Has anyone seen this or has anything to comment on that ?
> >
> 
> Currently the SMP code is hard coded to only support a single key,
> which
> is the LTK+MID from the Slave to the Master.
> 
> You are correct that we will need to ensure that all of the keys are
> handled correctly, including ensuring proper order, once we add support
> for additional key distribution.  At the moment though, that is a moot
> question.
> 
> 
> --
> Brian Gix
> bgix@codeaurora.org
> Employee of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

I understand that we support only those keys, but I don't think that we can break the convention just because of our lack of support. We can ignore any other keys, but still we need to start distributing our keys only after the slave has finished sending all of his keys, and not do it automatically after the Master identification sent from the slave.

In addition, I believe there is a problem in the SMP code. In smp_cmd_master_ident, we do hci_add_ltk() with the conn->src instead of conn->dst, as in other places we call the hci_add_ltk():

static int smp_cmd_master_ident(struct l2cap_conn *conn, struct sk_buff *skb)
{
	struct smp_cmd_master_ident *rp = (void *) skb->data;
	struct smp_chan *smp = conn->smp_chan;

	skb_pull(skb, sizeof(*rp));

	hci_add_ltk(conn->hcon->hdev, 1, conn->src, smp->smp_key_size,
						rp->ediv, rp->rand, smp->tk);

	smp_distribute_keys(conn, 1);

	return 0;
}

In addition, we call the hci_add_ltk twice in this case - once from this function, and once from the smp_distribute_keys. Is this intentional or is this a bug ?

Thanks,
Chen Ganir.
