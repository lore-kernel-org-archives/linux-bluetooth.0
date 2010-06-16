Return-Path: <cyrus@holtmann.org>
Message-ID: <4C18F1A9.2080409@Atheros.com>
Date: Wed, 16 Jun 2010 21:15:45 +0530
From: Suraj <suraj@Atheros.com>
MIME-Version: 1.0
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: Suraj Sumangala <Suraj.Sumangala@Atheros.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Nick Pelly <npelly@google.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: RFC: Allow Bluez to select flushable or non-flushable ACL packets
 	with L2CAP_LM_RELIABLE
References: <35c90d960912081950t135e3f10m8848e54fde1e596f@mail.gmail.com>	<1260335175.2901.20.camel@violet>	<35c90d960912082213s26fb0ebse75ce85d43213d9@mail.gmail.com>	<1260482634.2901.70.camel@violet>	<35c90d960912161359u2b3f9b2fi875288896a7a8478@mail.gmail.com>	<35c90d961003091207u66571bt789461dcc7972693@mail.gmail.com>	<1268167524.3712.61.camel@localhost.localdomain>	<AANLkTinOFG0NcADz2ewxyaPWiLpe52MFLP8GCEvFna2a@mail.gmail.com>	<4C18BDDF.7030002@Atheros.com> <AANLkTimZB71m9zGxTjmKjTiKNo-hDHsrCLrOLXr1EjyY@mail.gmail.com>
In-Reply-To: <AANLkTimZB71m9zGxTjmKjTiKNo-hDHsrCLrOLXr1EjyY@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
On 6/16/2010 8:44 PM, Luiz Augusto von Dentz wrote:
> Hi,
>
> On Wed, Jun 16, 2010 at 3:04 PM, Suraj<suraj@atheros.com>  wrote:
>> Hi Luis,
>>
>> On 6/16/2010 5:10 PM, Luiz Augusto von Dentz wrote:
>>>
>>> Hi,
>>>
>>> On Tue, Mar 9, 2010 at 11:45 PM, Marcel Holtmann<marcel@holtmann.org>
>>>   wrote:
>>>>
>>>> Hi Nick,
>>>>
>>>>>>>>>> Right now Bluez always requests flushable ACL packets (but does not
>>>>>>>>>> set a flush timeout, so effectively they are non-flushable):
>>>>>>>>>>
>>>>>>>>>> However it is desirable to use an ACL flush timeout on A2DP packets
>>>>>>>>>> so
>>>>>>>>>> that if the ACL packets block for some reason then the LM can flush
>>>>>>>>>> them to make room for newer packets.
>>>>>>>>>>
>>>>>>>>>> Is it reasonable for Bluez to use the 0x00 ACL packet boundary flag
>>>>>>>>>> by
>>>>>>>>>> default (non-flushable packet), and let userspace request flushable
>>>>>>>>>> packets on A2DP L2CAP sockets with the socket option
>>>>>>>>>> L2CAP_LM_RELIABLE.
>>>>>>>>>
>>>>>>>>> the reliable option has a different meaning. It comes back from the
>>>>>>>>> old
>>>>>>>>> Bluetooth 1.1 qualification days where we had to tests on L2CAP that
>>>>>>>>> had
>>>>>>>>> to confirm that we can detect malformed packets and report them.
>>>>>>>>> These
>>>>>>>>> days it is just fine to drop them.
>>>>>>>>
>>>>>>>> Got it, how about introducing
>>>>>>>>
>>>>>>>> #define L2CAP_LM_FLUSHABLE 0x0040
>>>>>>>
>>>>>>> that l2cap_sock_setsockopt_old() sets this didn't give you a hint that
>>>>>>> we might wanna deprecate this socket options ;)
>>>>>>>
>>>>>>> I need to read up on the flushable stuff, but in the end it deserves
>>>>>>> its
>>>>>>> own socket option. Also an ioctl() to actually trigger Enhanced flush
>>>>>>> might be needed.
>>>>>>>
>>>>>>>> struct l2cap_pinfo {
>>>>>>>>     ...
>>>>>>>>     __u8 flushable;
>>>>>>>> }
>>>>>>>
>>>>>>> Sure. In the long run we need to turn this into a bitmask. We are just
>>>>>>> wasting memory here.
>>>>>>
>>>>>> Attached is an updated patch, that checks the LMP features bitmask
>>>>>> before using the new non-flushable packet type.
>>>>>>
>>>>>> I am still using L2CAP_LM_FLUSHABLE socket option in
>>>>>> l2cap_sock_setsockopt_old(), which I don't think you are happy with.
>>>>>> So how about a new option:
>>>>>>
>>>>>> SOL_L2CAP, L2CAP_ACL_FLUSH
>>>>>> which has a default value of 0, and can be set to 1 to make the ACL
>>>>>> data sent by this L2CAP socket flushable.
>>>>>>
>>>>>> In a later commit we would then add
>>>>>> SOL_ACL, ACL_FLUSH_TIMEOUT
>>>>>> That is used to set an automatic flush timeout for the ACL link on a
>>>>>> L2CAP socket. Note that SOL_ACL is new.
>>>>>>
>>>>>> But maybe this is not what you had in mind, so I'm looking for your
>>>>>> advice before I implement this.
>>>>>
>>>>> Attached an updated patch for 2.6.32 kernel. We've been using this
>>>>> patch successfully on production devices.
>>>>
>>>> can see anything wrong with that patch. However we need to use
>>>> SOL_BLUETOOTH for it of course. So we need to come up with something to
>>>> make this simple.
>>>>
>>>> An additional change I like to see is to use flags for booleans like
>>>> flushable in the structures. Can you work on changing that.
>>>>
>>>> Also do we have decoding support for this in hcidump. It might be nice
>>>> to include some really simple examples in the commit message.
>>>>
>>>> Regards
>>>
>>> I would like to play a little bit with this, so is there any missing
>>> updates?
>>>
>> This is not exactly something related to your question, but there is another
>> side effect for the current implementation.
>>
>> Assume you have 2 ACL links, FTP and A2DP. A2DP streaming and FTP doing FTP
>> Put.
>> When the A2DP packets start blocking, it effectively start blocking the
>> packets available for FTP too. But, the host has no idea about it and keep
>> pumping in A2DP data until all available buffers are blocked. Effectively
>> blocking both A2DP and FTP.
>>
>> So at the user level you will see your FTP connection stalling as long your
>> A2DP connection is stalled (out of range). FTP will restart as soon as A2DP
>> comes back in range.
>>
>> I had raised this issue sometime before, but could not follow it up.
>
> I got the impression that we can still control which packets are
> Automatically-Flushable and which are not, so even thought we set the
> timeout in a per ACL link fashion we can still mark which packets
> should be flushable in a per socket basis.
>
> Is that correct, Nick?
>

Yes, it is possible to flush packets selectively. But the buffer 
management is between Host and Controller, not per ACL link.

The root cause of the issue is that A2DP packets are not at all flushed 
and keeps clogging the available buffers.

So, Implementing option to actually flush A2DP packet should solve the 
above mentioned problem.

Regards
Suraj

