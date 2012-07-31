Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAHH5__59tO=+hzz=4gQtx+Eq5Pz7dQ6j1ynO_7_3dQqCMkehWw@mail.gmail.com>
References: <1343123700-23375-1-git-send-email-manojkr.sharma@stericsson.com>
	<1343138034.24426.55.camel@aeonflux>
	<CAHH5__6sQ2yyEpuDZYMd4mFmHJEJeRX4eKzVM47k9TQcSthywA@mail.gmail.com>
	<1343399863.1803.10.camel@aeonflux>
	<CAHH5__62w3gO6YMnyvEeo7Pug_C0FUVZTR6wGLDz9Tkn2cKeXA@mail.gmail.com>
	<CABBYNZ+CEJby4JJRd_+A+OjAXO=n8ZZpFqehADSAk-Lgq9A0Eg@mail.gmail.com>
	<CAHH5__59tO=+hzz=4gQtx+Eq5Pz7dQ6j1ynO_7_3dQqCMkehWw@mail.gmail.com>
Date: Tue, 31 Jul 2012 17:10:29 +0300
Message-ID: <CABBYNZ+zPxfKn--E6fSGF8gUj-jLN4MVbZqHcj=E4ZOgcft9tg@mail.gmail.com>
Subject: Re: [PATCH 0/2] Support for reserving bandwidth on L2CAP socket
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Manoj Sharma <ursmanoj@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org,
	Anurag Gupta <anurag.gupta@stericsson.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Manoj,

On Tue, Jul 31, 2012 at 2:30 PM, Manoj Sharma <ursmanoj@gmail.com> wrote:
> Hi Luiz,
>
> On 7/30/12, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
>> Hi Manoj,
>>
>> On Mon, Jul 30, 2012 at 9:30 AM, Manoj Sharma <ursmanoj@gmail.com> wrote:
>>> One problem which I have faced using SO_PRIORITY is explained below.
>>>
>>> Suppose we have 2 links A & B and link A has higher priority than link
>>> B. And outgoing data transfer is active on both links. Now if device
>>> on link A goes far, there would be lot of failures and number of
>>> re-transmissions would increase for link A. Consequently at any time
>>> host would have significant number of packets for link A, getting
>>> accumulated due to poor quality of link.But since link A packets have
>>> higher priority, link B packets would suffer infinitely as long as
>>> link A packet queue in host is non-empty. Thus link B protocols may
>>> fail due to timers expiring and finally disconnection at upper layers.
>>
>> There is a mechanism to avoid starvation, also apparently you didn't
>> study the code since the priority is per L2CAP channel not per link so
>> we are able to prioritize per profile.
>>
> I would check how starvation is avoided. But for your information I
> did observe starvation practically. And I know that priority is per
> L2CAP. I mentioned links based on assumption that AVDTP and OBEX are
> connected with different devices. Hence priority would result into
> priority of connections in such case ;).

There is no such thing of prioritize a connection, the algorithm used
always check every channel of each connection and prioritize the
channel. Maybe you are confusing what some controllers do, the
controller has no idea what L2CAP channel has been configured it only
knows about the ACL connections.

>>> Second problem:
>>> We have two links similar to above scenario. Say link A is being used
>>> by AVDTP and link B is being used by OBEX. Host can come across a
>>> situation where all controller buffers are used by OBEX and AVDTP is
>>> waiting for a free buffer. Now due to some reason (e.g. distance) OBEX
>>> link B goes weak. This results into delay in transmission of OBEX
>>> packets already held by controller and consequently AVDTP packets also
>>> get delayed which causes glitches in music streaming and user
>>> experience goes bad.
>>
>> That is exactly what SO_PRIORITY has fixed, by setting SO_PRIORITY you
>> prioritize AVDTP stream over OBEX which means AVDTP can use a bigger
>> part of the bandwidth while OBEX uses the remaining.
>>
> I disagree. Please try to understand the situation I explained again.
> There can be a scenario when host has only OBEX packets and no AVDTP,
> here irrespective of which channel has what priority OBEX may consume
> all ACL credits. At the same moment OBEX link goes weak (e.g.due to
> distance), this would delay the transmission of all OBEX packets held
> by controller. In the mean time, AVDTP packets reach Bluez but since
> there are no credits left, host would have to delay transmission of
> AVDTP until a OBEX packet is transferred and an NOCP is received. This
> would definitely cause a glitch on AVDTP streaming and end user
> experience would go bad. By reserving credits for AVDTP channel, we
> ensure that OBEX packets doesnt eat up all credits while AVDTP packets
> were absent.

Without the use of guaranteed channels you cannot really guarantee
anything, besides this would throttle OBEX transfer even when there is
nothing streaming on AVDTP which I don't thing is acceptable. Also Ive
never experience such a problem, you can start streaming while
transferring something and that never produced any artifacts in the
headsets I have, the only problem we have right now is paging another
device while AVDTP stream is active may cause some audio glitches and
even that could be avoided by tuning paging parameters while there is
a high priority channel active.

Btw, there is some lack of connection to the code, an OBEX packet
could be quite big but that is not transmitted as it is, it is
actually fragmented into L2CAP and then HCI frames, the HCI frames is
the one being sent to the controller, the moment the AVDTP socket
start producing another socket may be using some/all of the controller
buffers e.g. 8:1021 that is at most 8K bytes of latency to startup the
stream, in fact it is pretty common to audio to have some latency.

>> The credit based algorithmic actually complicates more than solves the
>> problems here because it should actually fail if there is no enough
>> bandwidth as requested, so we would actually need to query how much
>> credits are available, also any type of bandwidth reservation might be
>> overkill with things like variable bit rate where you actually need to
>> know what is maximum possible bandwidth you need to reserve before
>> hand and that credits cannot be reserved by anyone else.
>>
> I agree, but we can provide a mechanism to allow only one channel to
> reserve bandwidth. In most cases it would be AVDTP streaming channel.
> Reserving at least one credit would allow preventing cases where
> non-AVDTP channel eats all credits due to unavailability of AVDTP
> packets. Please mind that since OBEX packets would be reaching bluez
> much faster than AVDTP, such situation may arise very easily.

That raises my suspicious that you are not really testing against
PulseAudio and obexd, PA should be sending packets much faster than
obexd since its IO threads are realtime so it will most likely have
higher priority. Also the latency of OBEX packets are much greater as
each packet is normally 32k-64k compared to AVDTP stream which send
each packet individually (~700 bytes depending on the MTU).

>>> These are the basic problems which I have faced and hence felt
>>> necessity of a similar but different mechanism and came up with this
>>> solution. This solution fixes both of the problems explained above.
>>> Based on the explanation above your suggestion is required further.
>>
>> Could you please show us what system did you find this problem? We
>> could possible help you trying to figure out what is going wrong,
>> please note that SO_PRIORITY support was introduced in 3.0 and some
>> system don't actually use it, in fact so far I think only PulseAudio
>> make use of it.
>>
> Yes, but we forced Bluez AVDTP to use SO_PRIORITY on our system and
> faced the starvation problem explained above. Though I am going to
> study the priority patch again.

Im afraid the problem is not SO_PRIORITY but your audio subsystem
cannot keep up the socket buffer non-empty that would avoid OBEX
taking too much bandwidth, but again that is pretty strange as you
should be written much more frequently to the AVDTP socket to keep the
latency of the audio constant.

-- 
Luiz Augusto von Dentz
