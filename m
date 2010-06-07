Return-Path: <cyrus@holtmann.org>
Message-ID: <4C0C72ED.6050406@Atheros.com>
Date: Mon, 7 Jun 2010 09:47:49 +0530
From: Suraj <suraj@Atheros.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: Suraj Sumangala <Suraj.Sumangala@Atheros.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, "Luis
 Rodriguez" <Luis.Rodriguez@Atheros.com>, Jothikumar Mothilal
	<Jothikumar.Mothilal@Atheros.com>
Subject: Re: [PATCH v2] frame reassembly implementation for data stream
References: <1275467080.13946.3.camel@atheros013-desktop>	 <1275490955.2182.21.camel@localhost.localdomain>	 <4C071A73.70407@Atheros.com> <1275547087.2182.28.camel@localhost.localdomain> <4C0754CD.7020902@Atheros.com>
In-Reply-To: <4C0754CD.7020902@Atheros.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On 6/3/2010 12:37 PM, Suraj wrote:
> Hi Marcel,
>
> On 6/3/2010 12:08 PM, Marcel Holtmann wrote:
>> Hi Suraj,
>>
>>>> I don't like this implementation at all. The biggest problem is that you
>>>> are misusing __reassembly(hdev, HCI_ACLDATA_PKT) for getting your SKB. I
>>>> don't wanna intermix this. I am also missing checks for the packet
>>>> length matching or when packets are too big or the header size is not
>>>> matching up.
>>>>
>>>> So in theory both functions do exactly the same. Only minor exception is
>>>> that one knows the packet type up-front, the other has to read it from
>>>> the stream as a 1-byte header. I don't wanna maintain two functions that
>>>> do exactly the same.
>>>>
>>>> Creating an internal helper function that can maintain the current state
>>>> of the reassembly sounds a lot better. Then re-use that function and
>>>> ensure that the reassembly logic is inside the helper.
>>>
>>> I appreciate if you can take a closer look at the patch and compare it
>>> with  hci_recv_fragment implementation.
>>> Eventhough it looks similar, there are major differences on the way data
>>> is reassembled. It would not have worked if I had reused the same code
>>> from  hci_recv_fragment().
>>>
>>> Having a common reassembly helper could work. But I am not sure whether
>>> that would be a better solution.
>>
>> I did have a closer look at it already. I clearly see possibilities to
>> combine them into a more generic helper and not to maintain two
>> different functions that do exactly the same.
>
> The cases that the reassembly code has to consider are
>
> 1. We receive only packet type in one fragment
> 2. packet header is fragmented
> 3. packet data is fragmented
> 4. We receive multiple frames in one fragment.
>
> hci_recv_fragment(), handles only case 3 and 4 as it always knows the
> packet type and the full packet header in one call itself.
>
> For stream reassembly we need to take care of all cases 1-4 . This is
> where both functions differ.
>
> This actually makes a lot of difference in the way reassembly is done.
>
> Now regarding having a common helper function. I agree to the fact that
> it makes sense to have a helper function.
>
> My points against a common helper function are
>
> 1. It has to cover all 1-4 cases. This make it bit inefficient for USB
> as not considering 1 and 2 saves a lot of effort( allocating buffer
> before knowing the length, trying to verify if we have received the
> packet header or not etc etc.).
>
> 2. For case 4: the helper will not know from which context it was called.
> If it was called from a stream context, it will have to take the first
> byte of the next frame as packet type and do reassembly accordingly.
> This involves the caller telling the helper function from what context
> it was called. Which IMHO makes it less generic
>
> I understand that these issues can be worked around, but I believe makes
> the generic implementation kind of "trying to do too many things" helper.
>
Do let me know if you still think that having a generic function makes 
more sense, then I can go ahead and implement it.

Regards
Suraj
