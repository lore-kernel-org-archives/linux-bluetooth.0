Return-Path: <cyrus@holtmann.org>
Message-ID: <4EDD0312.1080309@codeaurora.org>
Date: Mon, 05 Dec 2011 09:44:50 -0800
From: Brian Gix <bgix@codeaurora.org>
MIME-Version: 1.0
To: "Ganir, Chen" <chen.ganir@ti.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: SMP Key distribution
References: <F0070FBC0FB3174D8D11444EB2D5B02643FFBB@DNCE02.ent.ti.com> <4EDCE598.20808@codeaurora.org> <F0070FBC0FB3174D8D11444EB2D5B02644029C@DNCE02.ent.ti.com>
In-Reply-To: <F0070FBC0FB3174D8D11444EB2D5B02644029C@DNCE02.ent.ti.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chen,

On 12/5/2011 7:48 AM, Ganir, Chen wrote:
> Brian,
>
> I understand that we support only those keys, but I don't think that we can break the convention just because of our lack of support. We can ignore any other keys, but still we need to start distributing our keys only after the slave has finished sending all of his keys, and not do it automatically after the Master identification sent from the slave.
>

You are correct, and this is definitely one of the things I hope to 
address (if someone else doesn't beat me to it) once I get the MITM 
changes that I have submitted accepted into bluetooth-next.

> In addition, I believe there is a problem in the SMP code. In smp_cmd_master_ident, we do hci_add_ltk() with the conn->src instead of conn->dst, as in other places we call the hci_add_ltk():
>

This may or may not be a bug, depending on how you look at things.  When 
"Privacy" is implemented, it will be possible for a remote device to 
"change addresses" on us (either via the "Address Resolution" key 
distribution, or via the GAP primary service) and it becomes "more 
interesting" to keep track of who is who.  Saving the LTK with the SRC 
(local) address might work, because LTK resolution is suppose to be done 
by matching on the EDIV and Randomizer, not by address.

Having said that, however, If we are the Master (which most Dual mode 
devices will generally be) we still need to know the remote devices 
BDADDR, so that we can establish the connection, and thereafter kick off 
link encryption.  So yes, I would still consider that the Bug:  The 
Master gets an LTK+MID from the Slave, which will be used to encrypt 
links as long as those roles do not change.  Therefore, the Master 
should be storing the LTK+MID pair under that Slaves Identity (BDADDR).

One of the catches being however, that if we get Address Resolution 
keys, or the slaves GAP Primary Service tells us to use a different 
Address, this storage "key" will need to be adjusted.

> static int smp_cmd_master_ident(struct l2cap_conn *conn, struct sk_buff *skb)
> {
> 	struct smp_cmd_master_ident *rp = (void *) skb->data;
> 	struct smp_chan *smp = conn->smp_chan;
>
> 	skb_pull(skb, sizeof(*rp));
>
> 	hci_add_ltk(conn->hcon->hdev, 1, conn->src, smp->smp_key_size,
> 						rp->ediv, rp->rand, smp->tk);
>
> 	smp_distribute_keys(conn, 1);
>
> 	return 0;
> }
>
> In addition, we call the hci_add_ltk twice in this case - once from this function, and once from the smp_distribute_keys. Is this intentional or is this a bug ?

This is not actually a bug.  Or at least not what I would consider a 
serious bug.  The LTK key that the Slave sends to the Master, is 
distinct from the key the Master sends to the Slave.

However, as I indicated above, an LTK+MID pair that is distributed 
"outbound" should not be associated with the remote devices BDADDR. It 
should be stored using a lookup key that is the EDIV, which is 
authenticated with the Randomizer.

>
> Thanks,
> Chen Ganir.


-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
