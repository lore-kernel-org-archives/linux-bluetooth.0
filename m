Return-Path: <cyrus@holtmann.org>
Date: Tue, 31 Jul 2012 09:58:58 -0700 (PDT)
From: Mat Martineau <mathewm@codeaurora.org>
To: Manoj Sharma <ursmanoj@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
cc: Marcel Holtmann <marcel@holtmann.org>,
	linux-bluetooth@vger.kernel.org,
	Anurag Gupta <anurag.gupta@stericsson.com>
Subject: Re: [PATCH 0/2] Support for reserving bandwidth on L2CAP socket
In-Reply-To: <CABBYNZ+zPxfKn--E6fSGF8gUj-jLN4MVbZqHcj=E4ZOgcft9tg@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1207310813420.1055@mathewm-linux>
References: <1343123700-23375-1-git-send-email-manojkr.sharma@stericsson.com> <1343138034.24426.55.camel@aeonflux> <CAHH5__6sQ2yyEpuDZYMd4mFmHJEJeRX4eKzVM47k9TQcSthywA@mail.gmail.com> <1343399863.1803.10.camel@aeonflux> <CAHH5__62w3gO6YMnyvEeo7Pug_C0FUVZTR6wGLDz9Tkn2cKeXA@mail.gmail.com>
 <CABBYNZ+CEJby4JJRd_+A+OjAXO=n8ZZpFqehADSAk-Lgq9A0Eg@mail.gmail.com> <CAHH5__59tO=+hzz=4gQtx+Eq5Pz7dQ6j1ynO_7_3dQqCMkehWw@mail.gmail.com> <CABBYNZ+zPxfKn--E6fSGF8gUj-jLN4MVbZqHcj=E4ZOgcft9tg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Manoj and Luiz -

On Tue, 31 Jul 2012, Luiz Augusto von Dentz wrote:

> Hi Manoj,
>
> On Tue, Jul 31, 2012 at 2:30 PM, Manoj Sharma <ursmanoj@gmail.com> wrote:
>> Hi Luiz,
>>
>> On 7/30/12, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
>>> Hi Manoj,
>>>
>>> On Mon, Jul 30, 2012 at 9:30 AM, Manoj Sharma <ursmanoj@gmail.com> wrote:
>>>> One problem which I have faced using SO_PRIORITY is explained below.
>>>>
>>>> Suppose we have 2 links A & B and link A has higher priority than link
>>>> B. And outgoing data transfer is active on both links. Now if device
>>>> on link A goes far, there would be lot of failures and number of
>>>> re-transmissions would increase for link A. Consequently at any time
>>>> host would have significant number of packets for link A, getting
>>>> accumulated due to poor quality of link.But since link A packets have
>>>> higher priority, link B packets would suffer infinitely as long as
>>>> link A packet queue in host is non-empty. Thus link B protocols may
>>>> fail due to timers expiring and finally disconnection at upper layers.
>>>
>>> There is a mechanism to avoid starvation, also apparently you didn't
>>> study the code since the priority is per L2CAP channel not per link so
>>> we are able to prioritize per profile.
>>>
>> I would check how starvation is avoided. But for your information I
>> did observe starvation practically. And I know that priority is per
>> L2CAP. I mentioned links based on assumption that AVDTP and OBEX are
>> connected with different devices. Hence priority would result into
>> priority of connections in such case ;).
>
> There is no such thing of prioritize a connection, the algorithm used
> always check every channel of each connection and prioritize the
> channel. Maybe you are confusing what some controllers do, the
> controller has no idea what L2CAP channel has been configured it only
> knows about the ACL connections.

The current starvation avoidance algorithm works well as long as there 
is data queued for all of the L2CAP channels and the controller is 
sending packets regularly.  It does seem to break down when the 
controller queue gets stuck (see below).

>>>> Second problem:
>>>> We have two links similar to above scenario. Say link A is being used
>>>> by AVDTP and link B is being used by OBEX. Host can come across a
>>>> situation where all controller buffers are used by OBEX and AVDTP is
>>>> waiting for a free buffer. Now due to some reason (e.g. distance) OBEX
>>>> link B goes weak. This results into delay in transmission of OBEX
>>>> packets already held by controller and consequently AVDTP packets also
>>>> get delayed which causes glitches in music streaming and user
>>>> experience goes bad.
>>>
>>> That is exactly what SO_PRIORITY has fixed, by setting SO_PRIORITY you
>>> prioritize AVDTP stream over OBEX which means AVDTP can use a bigger
>>> part of the bandwidth while OBEX uses the remaining.
>>>
>> I disagree. Please try to understand the situation I explained again.
>> There can be a scenario when host has only OBEX packets and no AVDTP,
>> here irrespective of which channel has what priority OBEX may consume
>> all ACL credits. At the same moment OBEX link goes weak (e.g.due to
>> distance), this would delay the transmission of all OBEX packets held
>> by controller. In the mean time, AVDTP packets reach Bluez but since
>> there are no credits left, host would have to delay transmission of
>> AVDTP until a OBEX packet is transferred and an NOCP is received. This
>> would definitely cause a glitch on AVDTP streaming and end user
>> experience would go bad. By reserving credits for AVDTP channel, we
>> ensure that OBEX packets doesnt eat up all credits while AVDTP packets
>> were absent.
>
> Without the use of guaranteed channels you cannot really guarantee
> anything, besides this would throttle OBEX transfer even when there is
> nothing streaming on AVDTP which I don't thing is acceptable. Also Ive
> never experience such a problem, you can start streaming while
> transferring something and that never produced any artifacts in the
> headsets I have, the only problem we have right now is paging another
> device while AVDTP stream is active may cause some audio glitches and
> even that could be avoided by tuning paging parameters while there is
> a high priority channel active.
>
> Btw, there is some lack of connection to the code, an OBEX packet
> could be quite big but that is not transmitted as it is, it is
> actually fragmented into L2CAP and then HCI frames, the HCI frames is
> the one being sent to the controller, the moment the AVDTP socket
> start producing another socket may be using some/all of the controller
> buffers e.g. 8:1021 that is at most 8K bytes of latency to startup the
> stream, in fact it is pretty common to audio to have some latency.

It's true that the amount of latency due to buffering in the 
controller is minimal, and would not in itself cause streaming issues 
*if* the controller is able to consume packets from the buffer.

I do see where a bad situation arises when the OBEX connection is 
stalled and only queued OBEX data is available to the host stack HCI 
scheduler at that instant.  In that case, the controller queue could 
be completely consumed by data for the stalled channel no matter what 
the priorities are.  This could even happen when audio data is passed 
to the socket at exactly the right time.

If you're using OBEX-over-L2CAP, this could be partially addressed by 
setting a flush timeout.  However, it would still be possible to fill 
the buffers with OBEX packets because non-flushable ERTM s-frames 
would accumulate in the controller buffer.

For traditional OBEX-over-RFCOMM, an OBEX packet sizes that are 
smaller than the controller buffer could help.  This is a tradeoff 
against throughput.  It could work to send smaller OBEX packets when 
an AVDTP stream is active, even if a larger OBEX MTU was negotiated.

It would be a big help if Manoj could post kernel logs showing us how 
the HCI scheduler is actually behaving in the problem case.


While I'm convinced that a problem exists here, I think it can be 
addressed using existing interfaces instead of adding a new one.  For 
example, it may be reasonable to not fully utilize the controller 
buffer with data for just one ACL, or to use priority when looking at 
controller buffer utilization.  Maybe an ACL could use all but one 
slot in the controller buffer, maybe it could only use half if there 
are multiple ACLs open.  I don't think it would throttle throughput 
unless the system was so heavily loaded that it couldn't respond to 
number-of-completed-packets in time at BR/EDR data rates, and in that 
case there are bigger problems.  It's pretty easy to test with 
hdev->acl_pkts set to different values to see if using less of the 
buffer impacts throughput.

Right now, one stalled ACL disrupts all data flow through the 
controller.  And that seems like a problem worth solving.


>>> The credit based algorithmic actually complicates more than solves the
>>> problems here because it should actually fail if there is no enough
>>> bandwidth as requested, so we would actually need to query how much
>>> credits are available, also any type of bandwidth reservation might be
>>> overkill with things like variable bit rate where you actually need to
>>> know what is maximum possible bandwidth you need to reserve before
>>> hand and that credits cannot be reserved by anyone else.
>>>
>> I agree, but we can provide a mechanism to allow only one channel to
>> reserve bandwidth. In most cases it would be AVDTP streaming channel.
>> Reserving at least one credit would allow preventing cases where
>> non-AVDTP channel eats all credits due to unavailability of AVDTP
>> packets. Please mind that since OBEX packets would be reaching bluez
>> much faster than AVDTP, such situation may arise very easily.
>
> That raises my suspicious that you are not really testing against
> PulseAudio and obexd, PA should be sending packets much faster than
> obexd since its IO threads are realtime so it will most likely have
> higher priority. Also the latency of OBEX packets are much greater as
> each packet is normally 32k-64k compared to AVDTP stream which send
> each packet individually (~700 bytes depending on the MTU).
>
>>>> These are the basic problems which I have faced and hence felt
>>>> necessity of a similar but different mechanism and came up with this
>>>> solution. This solution fixes both of the problems explained above.
>>>> Based on the explanation above your suggestion is required further.
>>>
>>> Could you please show us what system did you find this problem? We
>>> could possible help you trying to figure out what is going wrong,
>>> please note that SO_PRIORITY support was introduced in 3.0 and some
>>> system don't actually use it, in fact so far I think only PulseAudio
>>> make use of it.
>>>
>> Yes, but we forced Bluez AVDTP to use SO_PRIORITY on our system and
>> faced the starvation problem explained above. Though I am going to
>> study the priority patch again.
>
> Im afraid the problem is not SO_PRIORITY but your audio subsystem
> cannot keep up the socket buffer non-empty that would avoid OBEX
> taking too much bandwidth, but again that is pretty strange as you
> should be written much more frequently to the AVDTP socket to keep the
> latency of the audio constant.

I agree that SO_PRIORITY is not the problem, but I don't think this 
can be fixed at the audio subsystem level either.

Regards,

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

