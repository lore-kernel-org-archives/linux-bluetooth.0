Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZLRdFMBtGJLmoMy4QhKaHs3RuHpyqdtsYF9SKC7Y6SGLg@mail.gmail.com>
References: <1343123700-23375-1-git-send-email-manojkr.sharma@stericsson.com>
	<1343138034.24426.55.camel@aeonflux>
	<CAHH5__6sQ2yyEpuDZYMd4mFmHJEJeRX4eKzVM47k9TQcSthywA@mail.gmail.com>
	<1343399863.1803.10.camel@aeonflux>
	<CAHH5__62w3gO6YMnyvEeo7Pug_C0FUVZTR6wGLDz9Tkn2cKeXA@mail.gmail.com>
	<CABBYNZ+CEJby4JJRd_+A+OjAXO=n8ZZpFqehADSAk-Lgq9A0Eg@mail.gmail.com>
	<CAHH5__59tO=+hzz=4gQtx+Eq5Pz7dQ6j1ynO_7_3dQqCMkehWw@mail.gmail.com>
	<CABBYNZ+zPxfKn--E6fSGF8gUj-jLN4MVbZqHcj=E4ZOgcft9tg@mail.gmail.com>
	<alpine.DEB.2.02.1207310813420.1055@mathewm-linux>
	<CABBYNZLRdFMBtGJLmoMy4QhKaHs3RuHpyqdtsYF9SKC7Y6SGLg@mail.gmail.com>
Date: Mon, 13 Aug 2012 11:44:25 +0530
Message-ID: <CAHH5__6Y_QAh9C3yrzUzo3Qdr4mjk-V-c8ZHRO9oYYqKGh25Vg@mail.gmail.com>
Subject: Re: [PATCH 0/2] Support for reserving bandwidth on L2CAP socket
From: Manoj Sharma <ursmanoj@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Mat Martineau <mathewm@codeaurora.org>, Marcel Holtmann <marcel@holtmann.org>,
	linux-bluetooth@vger.kernel.org, Anurag Gupta <anurag.gupta@stericsson.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz & Mat,
Sorry for responding late.

On 8/1/12, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
> Hi Mat,
>
> On Tue, Jul 31, 2012 at 7:58 PM, Mat Martineau <mathewm@codeaurora.org>
> wrote:
>>
>> Manoj and Luiz -
>>
>>
>> On Tue, 31 Jul 2012, Luiz Augusto von Dentz wrote:
>>
>>> Hi Manoj,
>>>
>>> On Tue, Jul 31, 2012 at 2:30 PM, Manoj Sharma <ursmanoj@gmail.com>
>>> wrote:
>>>>
>>>> Hi Luiz,
>>>>
>>>> On 7/30/12, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
>>>>>
>>>>> Hi Manoj,
>>>>>
>>>>> On Mon, Jul 30, 2012 at 9:30 AM, Manoj Sharma <ursmanoj@gmail.com>
>>>>> wrote:
>>>>>>
>>>>>> One problem which I have faced using SO_PRIORITY is explained below.
>>>>>>
>>>>>> Suppose we have 2 links A & B and link A has higher priority than
>>>>>> link
>>>>>> B. And outgoing data transfer is active on both links. Now if device
>>>>>> on link A goes far, there would be lot of failures and number of
>>>>>> re-transmissions would increase for link A. Consequently at any time
>>>>>> host would have significant number of packets for link A, getting
>>>>>> accumulated due to poor quality of link.But since link A packets have
>>>>>> higher priority, link B packets would suffer infinitely as long as
>>>>>> link A packet queue in host is non-empty. Thus link B protocols may
>>>>>> fail due to timers expiring and finally disconnection at upper
>>>>>> layers.
>>>>>
>>>>>
>>>>> There is a mechanism to avoid starvation, also apparently you didn't
>>>>> study the code since the priority is per L2CAP channel not per link so
>>>>> we are able to prioritize per profile.
>>>>>
>>>> I would check how starvation is avoided. But for your information I
>>>> did observe starvation practically. And I know that priority is per
>>>> L2CAP. I mentioned links based on assumption that AVDTP and OBEX are
>>>> connected with different devices. Hence priority would result into
>>>> priority of connections in such case ;).
>>>
>>>
>>> There is no such thing of prioritize a connection, the algorithm used
>>> always check every channel of each connection and prioritize the
>>> channel. Maybe you are confusing what some controllers do, the
>>> controller has no idea what L2CAP channel has been configured it only
>>> knows about the ACL connections.
>>
>>
>> The current starvation avoidance algorithm works well as long as there is
>> data queued for all of the L2CAP channels and the controller is sending
>> packets regularly.  It does seem to break down when the controller queue
>> gets stuck (see below).
>
> Indeed, but that is not the host stack fault, in fact it less likely
> that controller queue gonna get stuck with AVDTP than with OBEX since
> the latter tend to push data as fast as it can, also for AVDTP it
> should be possible to set a sensible flushable timeout. Maybe we could
> make use of SO_SNDTIMEO to actually set the flushable timeout?
>
>> I do see where a bad situation arises when the OBEX connection is stalled
>> and only queued OBEX data is available to the host stack HCI scheduler at
>> that instant.  In that case, the controller queue could be completely
>> consumed by data for the stalled channel no matter what the priorities
>> are.
>> This could even happen when audio data is passed to the socket at exactly
>> the right time.
>>
>> If you're using OBEX-over-L2CAP, this could be partially addressed by
>> setting a flush timeout.  However, it would still be possible to fill the
>> buffers with OBEX packets because non-flushable ERTM s-frames would
>> accumulate in the controller buffer.
>>
>> For traditional OBEX-over-RFCOMM, an OBEX packet sizes that are smaller
>> than
>> the controller buffer could help.  This is a tradeoff against throughput.
>> It could work to send smaller OBEX packets when an AVDTP stream is
>> active,
>> even if a larger OBEX MTU was negotiated.
>
> Yep, in certain situations this may actually be unavoidable like in
> link loss, although we might be able to have a very small link
> supervision timeout.
>
>> It would be a big help if Manoj could post kernel logs showing us how the
>> HCI scheduler is actually behaving in the problem case.
>
> Good point.
>
>>
>> While I'm convinced that a problem exists here, I think it can be
>> addressed
>> using existing interfaces instead of adding a new one.  For example, it
>> may
>> be reasonable to not fully utilize the controller buffer with data for
>> just
>> one ACL, or to use priority when looking at controller buffer
>> utilization.
>> Maybe an ACL could use all but one slot in the controller buffer, maybe
>> it
>> could only use half if there are multiple ACLs open.  I don't think it
>> would
>> throttle throughput unless the system was so heavily loaded that it
>> couldn't
>> respond to number-of-completed-packets in time at BR/EDR data rates, and
>> in
>> that case there are bigger problems.  It's pretty easy to test with
>> hdev->acl_pkts set to different values to see if using less of the buffer
>> impacts throughput.
>
> Well the problem may exist but as I said credit based algorithm would
> probably be overkill, in the other hand it maybe be useful to leave at
> least one slot for each connection whenever possible, but iirc it does
> impact the throughput specially on controller that does have big
> buffers.
>
>> Right now, one stalled ACL disrupts all data flow through the controller.
>> And that seems like a problem worth solving.
>
> I would go with link supervision timeout, specially in case of audio
> if the ACL got stalled for more than 2 seconds there is probably a
> problem and in most cases it is better to disconnect and route the
> audio back to the speakers.
>
This point is my whole concern. In the situation I faced, stalled ACL
(OBEX) was causing disruption to the flow of A2DP traffic, here even
high priority of AVDTP channel doesn't work once OBEX ACL has taken
all data credits.
Therefore we do need to devise a mechanism where one stalled ACL does
not disrupt other ACLs.
As per my understanding if there are any delays caused by stalled ACL
on others ACLs carrying non-AVDTP data, such delays are not quickly
visible to end user. E.g. in case of FTP user may feel that data
transfer is slow, however it may be understood to him that since he is
using two devices at a time, it is ok. But if the stalled ACL is
impacting other ACL carrying AVDTP data, delays caused would be
immediately visible to end-user in form of glitches in music
streaming.
Hence in my opinion if we simply provide a mechanism to avoid AVDTP
being impacted by stalled ACLs, we are done. I gave this solution by
providing L2CAP socket option to reserve a credit for AVDTP channel.
First please comment if reserving a credit for AVDTP channel is a bad
solution and if we can devise a better solution for seamless streaming
of AVDTP.
Of course we can find better ways to facilitate reservation for AVDTP
channels i.e. other than socket option. In this regard also,
suggestion or even direct solution is welcome.

>>
>> I agree that SO_PRIORITY is not the problem, but I don't think this can
>> be
>> fixed at the audio subsystem level either.
>>
>
> Im not absolutely sure, but it has been quite some time I don't
> experience such problems and I do use A2DP/AVDTP a lot, in fact last
> week Ive setup both sink and source simultaneously (phone -> pc ->
> headset) together with a file transfer and I didn't notice any
> problems.
>
> --
> Luiz Augusto von Dentz
>
Best regards,
Manoj
