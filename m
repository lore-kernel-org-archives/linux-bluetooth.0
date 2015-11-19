Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Subject: Re: [PATCH] BNEP multicast filter is filtering multicast addresses in default case although differently specified
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <564C792B.3040300@proofnet.de>
Date: Thu, 19 Nov 2015 14:28:49 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <BD2BD640-83BE-45B8-AADD-468289508432@holtmann.org>
References: <564C6C35.4030305@proofnet.de> <F6214B06-650D-4DE0-A375-49652B8124A5@holtmann.org> <564C792B.3040300@proofnet.de>
To: Danny Schweizer <danny.schweizer@proofnet.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Danny,

>>> This patch fixes the Bug 106691 by changing the default multicast filter
>>> to not filter out any multicast addresses.
>>> 
>>> ---
>>> net/bluetooth/bnep/core.c | 2 +-
>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>> 
>>> diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
>>> index 1641367..ba2467a 100644
>>> --- a/net/bluetooth/bnep/core.c
>>> +++ b/net/bluetooth/bnep/core.c
>>> @@ -609,7 +609,7 @@ int bnep_add_connection(struct bnep_connadd_req
>>> *req, struct socket *sock)
>>> 
>>> #ifdef CONFIG_BT_BNEP_MC_FILTER
>>> 	/* Set default mc filter */
>>> -	set_bit(bnep_mc_hash(dev->broadcast), (ulong *) &s->mc_filter);
>>> +	s->mc_filter = ~0LL;
>>> #endif
>> 
>> I am not convinced that these two are actually the same expressions. You need to explain this a lot more in detail on why this change is correct.
>> 
> 
> The new expression should set the default mc_filter such that it does
> not filter out any multicast addresses (it sets the mc_filter to all
> ones). Up to now, the default mc_filter filters out all multicast
> addresses except for the broadcast address. The reason why this is
> needed is explained in the description of bug 106691. I will copy it here:
> 
> A Linux PC is connected with another device over Bluetooth PAN using a
> BNEP interface.
> 
> Whenever a packet is tried to be sent over the BNEP interface, the
> function "bnep_net_xmit()" in "net/bluetooth/bnep/netdev.c" is called.
> This function calls "bnep_net_mc_filter()", which checks (if the
> destination address is multicast) if the address is set in a certain
> multicast filter (&s->mc_filter). If it is not, then it is not sent out.
> 
> This filter is only changed in two other functions, found in
> net/bluetooth/bnep/core.c": in "bnep_ctrl_set_mc_filter()", which is
> only called if a message of type "BNEP_FILTER_MULTI_ADDR_SET" is
> received. Otherwise, it is set in "bnep_add_connection()", where it is
> set to a default value which only adds the broadcast address to the filter:
> 
> set_bit(bnep_mc_hash(dev->broadcast), (ulong *) &s->mc_filter);
> 
> 
> To sum up, if the BNEP interface does not receive any message of type
> "BNEP_FILTER_MULTI_ADDR_SET", it will not send out any messages with
> multicast destination addresses except for broadcast.
> 
> 
> However, in the BNEP specification (page 27 in
> http://grouper.ieee.org/groups/802/15/Bluetooth/BNEP.pdf), it is said
> that per default, all multicast addresses should not be filtered, i.e.
> the BNEP interface should be able to send packets with any multicast
> destination address.
> 
> It seems that the default case is wrong: the multicast filter should not
> block almost all multicast addresses, but should not filter out any.
> 
> This leads to the problem that e.g. Neighbor Solicitation messages sent
> with Bluetooth PAN over the BNEP interface to a multicast destination
> address other than broadcast are blocked and not sent out.

and something along these lines should be in the commit message as explanation for your change. And the reference to the specification should be added as an extra comment in the code.

Regards

Marcel

