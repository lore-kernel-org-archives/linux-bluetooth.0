Return-Path: <cyrus@holtmann.org>
Message-ID: <4B7CE30C.9060703@nokia.com>
Date: Thu, 18 Feb 2010 08:49:48 +0200
From: Ville Tervo <ville.tervo@nokia.com>
MIME-Version: 1.0
To: ext Marcel Holtmann <marcel@holtmann.org>
CC: Nick Pelly <npelly@google.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] Bluetooth: Allow SCO/eSCO packet type selection for
 outgoing SCO connections.
References: <1265918068-14721-1-git-send-email-npelly@google.com>	 <35c90d961002111159h6727bc2cw28b55ce6e919fb4f@mail.gmail.com>	 <35c90d961002151315i5fc0f5b9y36aaba4415987a2f@mail.gmail.com>	 <4B7BB746.1040806@nokia.com>	 <35c90d961002170849m1d13743fg725a87594d63b80c@mail.gmail.com> <1266427894.8849.66.camel@localhost.localdomain>
In-Reply-To: <1266427894.8849.66.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel and Nick,

ext Marcel Holtmann wrote:
> Hi Nick,
> 
>>>> As a first step, can we get consensus on the userspace API:
>>>>
>>>> --- a/include/net/bluetooth/hci.h
>>>> +++ b/include/net/bluetooth/hci.h
>>>> @@ -139,8 +139,11 @@ enum {
>>>> +#define ALL_SCO_PKTS   (SCO_ESCO_MASK | EDR_ESCO_MASK)
>>>> +#define ALL_ESCO_PKTS  (SCO_ESCO_MASK | ESCO_EV3 | ESCO_EV4 | ESCO_EV5)
>>>>
>>>> --- a/include/net/bluetooth/sco.h
>>>> +++ b/include/net/bluetooth/sco.h
>>>> @@ -37,6 +37,7 @@
>>>> struct sockaddr_sco {
>>>>       sa_family_t     sco_family;
>>>>       bdaddr_t        sco_bdaddr;
>>>> +       __u16           sco_pkt_type;
>>>> };
>>>>
>>>> This will at least unblock my work.
>>> Would it be better to add new sockopt for sco socket?
>> What advantage does that have?
>>

>> Putting it in struct sockaddr_sco seems to make more sense since
>> packet types can only be selected during SCO connection establishment.
>> They can't be changed once the socket is connected.

The idea was to not force user space developers to handle packet type 
decision. And still give opportunity to tune allowed packet types.

> 
> in theory you can change the allowed packet types for ACL, SCO and eSCO
> after the connection is active. However the usefulness here is fairly
> limited. In case of ACL it is purely academical and most link manager
> will just ignore you. Mainly because the host stack can't really make a
> good decision here anyway.
> 
> Personally I think it is a total brain dead concept to give this into
> the control of the host stack anyway. For eSCO packet types this make a
> bit more sense since you might wanna control the bandwidth. However
> changing them later is just pointless. And I don't recall of any profile
> actually mentioning about it. I think they had a great idea behind eSCO
> support, but since it is impossible to get the negotiation parts right,
> everybody sticks with simple eSCO channels and doesn't bother to change
> them.
> 
> And even if we would be going for a setsockopt(), that would be blocking
> and then again pretty much pointless API. The sockaddr is most logical
> thing that fits into what we wanna achieve. Disallow/allow certain
> packet types and essentially force SCO over eSCO.

My idea was to provide same functionality than through sockaddr. IOW 
just provide API to control packet types for connection creation/accept 
and not to change types during the connection.


Sockaddr sounds good. It fulfills current requirements.

-- 
Ville
