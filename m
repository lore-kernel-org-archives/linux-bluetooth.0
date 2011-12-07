Return-Path: <cyrus@holtmann.org>
Date: Tue, 6 Dec 2011 21:54:16 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Brian Gix <bgix@codeaurora.org>
Cc: "Ganir, Chen" <chen.ganir@ti.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: SMP Key distribution
Message-ID: <20111207005416.GA15766@samus>
References: <F0070FBC0FB3174D8D11444EB2D5B02643FFBB@DNCE02.ent.ti.com>
 <4EDCE598.20808@codeaurora.org>
 <F0070FBC0FB3174D8D11444EB2D5B02644029C@DNCE02.ent.ti.com>
 <4EDD0312.1080309@codeaurora.org>
 <F0070FBC0FB3174D8D11444EB2D5B0264404E9@DNCE02.ent.ti.com>
 <4EDE5BF5.3040309@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4EDE5BF5.3040309@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 10:16 Tue 06 Dec, Brian Gix wrote:
> Hi Chen,
> 
> On 12/5/2011 11:43 PM, Ganir, Chen wrote:
> >Brian,
> >
> [...]
> >>You are correct, and this is definitely one of the things I hope to
> >>address (if someone else doesn't beat me to it) once I get the MITM
> >>changes that I have submitted accepted into bluetooth-next.
> >>
> >So basically what we need to do is listen for the SMP_CMD_MASTER_IDENT, SMP_CMD_IDENT_INFO, SMP_CMD_IDENT_ADDR_INFO and SMP_CMD_SIGN_INFO, and check the slave key distribution options to see how many keys he is sending. If we get one of these and it is actually the last key from the slave, and then distribute the master keys with the smp_distribute_keys (simply call a new function like smp_check_last_slave_key() which will do this work). Am I correct ?
> 
> Basically, Yes.
> 
> This will be necessary once support is added for those key types.
> Until then, it is desirable, but not critical for correct
> "over-the-air" operation.
> 
> >>>In addition, I believe there is a problem in the SMP code. In
> >>smp_cmd_master_ident, we do hci_add_ltk() with the conn->src instead of
> >>conn->dst, as in other places we call the hci_add_ltk():
> >>>
> >>
> >>This may or may not be a bug, depending on how you look at things.
> >>When
> >>"Privacy" is implemented, it will be possible for a remote device to
> >>"change addresses" on us (either via the "Address Resolution" key
> >>distribution, or via the GAP primary service) and it becomes "more
> >>interesting" to keep track of who is who.  Saving the LTK with the SRC
> >>(local) address might work, because LTK resolution is suppose to be
> >>done
> >>by matching on the EDIV and Randomizer, not by address.
> >>
> >>Having said that, however, If we are the Master (which most Dual mode
> >>devices will generally be) we still need to know the remote devices
> >>BDADDR, so that we can establish the connection, and thereafter kick
> >>off
> >>link encryption.  So yes, I would still consider that the Bug:  The
> >>Master gets an LTK+MID from the Slave, which will be used to encrypt
> >>links as long as those roles do not change.  Therefore, the Master
> >>should be storing the LTK+MID pair under that Slaves Identity (BDADDR).
> >>
> >>One of the catches being however, that if we get Address Resolution
> >>keys, or the slaves GAP Primary Service tells us to use a different
> >>Address, this storage "key" will need to be adjusted.
> >>
> >Calling the hci_add_ltk with the conn->src actually causes the code to call mgmt_new_link_key with the local and remote addresses to be the same, which then causes the btd_event_link_key_notify(...) ->  get_adapter_and_device(...) ->  adapter_get_device(...) ->  adapter_create_device(...) to create a new device, with the local address instead of the remote one. This is mostly due to the fact that get_adapter_and_device is called with the create flag hard coded as TRUE, even for this problematic key. What do you think about this ?
> 
> 
> I'm sure that this needs to be worked on, and I am not suprised if
> this is not currently working correctly. Our code over on
> codeauroraforum.org already has made that equivilent change (to use
> the dst addr instead of the local), but I have not submitted it here
> yet, because I am trying to single-thread the changes versus fixes,
> to simplify the upstreaming process (and for my own personal
> sanity). If you were to submit it as a patch, you would have my full
> support :-)

I agree that it should work better.

When implementing it I was trying to avoid creating many custom
types for each key, seems that it ended complicating things more
than necessary.

Having more specific type for each type of key seems to solve the
problems, and will make userspace life easier, please take a look
at the RFC that I just sent, and see what do you think.

> 
> 
> 
> 
> -- 
> Brian Gix
> bgix@codeaurora.org
> Employee of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Cheers,
-- 
Vinicius
