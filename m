Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <35c90d960907140915u71f20473x83b25579c4117a2d@mail.gmail.com>
References: <35c90d960905191820g4e3ee434hfd0060815540a4e0@mail.gmail.com>
	<1242787757.3147.13.camel@localhost.localdomain> <35c90d960905201457i508c678fqeb696cce32ae63be@mail.gmail.com>
	<35c90d960907061155t7349cc90p2e58a09a310b8926@mail.gmail.com>
	<35c90d960907091237o72228b0v57ad2556d77f4857@mail.gmail.com>
	<35c90d960907130846v2320de88pd6f34b8aabfdbb9e@mail.gmail.com>
	<2d5a2c100907131427x18f26f82g405a781cd8670b88@mail.gmail.com>
	<35c90d960907140915u71f20473x83b25579c4117a2d@mail.gmail.com>
From: Nick Pelly <npelly@google.com>
Date: Wed, 15 Jul 2009 15:11:23 -0700
Message-ID: <35c90d960907151511u3a49f1d3obea010371a031cd2@mail.gmail.com>
Subject: Re: bug? kernel does not send HCI Create Connection Cancel Command on
	shutdown() or close() of a connecting rfcomm socket
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Jul 14, 2009 at 9:15 AM, Nick Pelly<npelly@google.com> wrote:
> On Mon, Jul 13, 2009 at 2:27 PM, Luiz Augusto von
> Dentz<luiz.dentz@gmail.com> wrote:
>> Hi Nick,
>>
>> On Mon, Jul 13, 2009 at 12:46 PM, Nick Pelly<npelly@google.com> wrote:
>>> Any comments on this patch?
>>>
>>> It works for me, but my understanding of the RFCOMM state machine is naive.
>>>
>>
>> iirc BT_CONFIG(PN frame) means the DLC is being configured than we got
>> into connecting phase (BT_CONNECT) and send SABM frame. Only when
>> receiving UA frame DLC is consider connected (BT_CONNECTED), so your
>> patch seems good by assuming that we don't need to send a DISC for a
>> DLC not connected. But there is still a good use for it to cancel the
>> DLC connection attempt, so perhaps a better alternative would be to
>> use a much shorter timeout in those cases.
>
> Thanks for the advice.
>
> I have prepared a new patch which uses a very short timeout (10ms) on
> the DLC disconnect when in BT_CONFIG. I have tested this patch and it
> also resolves the issue. Patch attached.

ping

I will be offline for 2 weeks from tomorrow, so if there is further
testing or patches you would like me to try then I won't be able to
help after tomorrow.

Nick
