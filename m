Return-Path: <cyrus@holtmann.org>
Message-ID: <50B5D6A5.8070806@invoxia.com>
Date: Wed, 28 Nov 2012 10:17:25 +0100
From: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: eSCO latency configuration
References: <4E64AD1D.6000609@invoxia.com> <20121127111241.GA24125@x220>
In-Reply-To: <20121127111241.GA24125@x220>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On 11/27/2012 12:12 PM, Johan Hedberg wrote:
> Hi Arnaud,
>
> On Mon, Sep 05, 2011, Arnaud Mouiche wrote:
>> What could be a way to add the feature without breaking any API
>> 1) use the MTU of the socket or hdev ?
>> 2) add hdev entry for sco latency (which can be configured with
>> hciconfig like voice settings)
>> 3) something else ...
>> or
>> 4) no one cares about latency...
>>
>> PS: the same way, the retransmit effort is not configurable today.
> I'm assuming this is for HFP or HSP? At least I'm not aware of other
> significant profiles using (e)SCO. Since the HFP specification defines a
> set of recommended parameter combinations I don't think we necessarily
> need any user-space facing interface for this (with the exception of the
> mSBC/CVSD codec selection which is needed for HFP 1.6).
>
> Instead, the kernel could simply start with the S3 settings and fall
> back to S2 and finally S1 if failures are encountered during the
> connection setup. For mSBC the starting point would be T2 with a
> fallback to T1 in case of failure. Do you agree that this would be an
> acceptable solution?
> Johan

yes, I'm concerned by the HFP with mSBC/CVSD case, with multiple 
concurrent HFP sessions. So there is a need to avoid race conditions of 
the configuration (ie no configuration at the adapter level).

I found the BT_DEFER_SETUP feature from Frédéric to be a nice solution, 
since it gives more flexibility to the userland for this kind of 
configuration.
(up to now for my tests, I'm doing ugly things like forcing the kernel 
to not respond the eSCO setup, and do the response from userland.... )

I'm pretty busy at this time, but my goal may be to propose a way to 
configure the eSCO response on top of the BT_DEFER_SETUP.
With BT_DEFER_SETUP, accepting is done on the first 'recvmsg'. May be we 
can configure the socket (setsockopt, ioctl...) just before this first 
'recvmsg' to tell the kernel the real purpose of the socket.
For example, userland can provide the expected set of configuration 
(latency, bandwith, retransmissions, packets, voice settings). But I 
don't have a clear of how handling fallback indeed.

I'll be also interested to be able to reject the connection_request for 
"Limited Resources" reasons. The scenario using this feature is when 
multiple active calls are already managed by the device, and
routing a new voice stream is simply not possible (for the hardware 
and/or for the user).
(note: one limitation of the HFP specs is that the routing is not really 
agreed before opening the link. only the codec selection is negociated, 
but specifications are clear that we can't reject the CVSD codec, so a 
real rejection of the route is not possible)


just a [raw] idea I just have:

Module   --------------- Kernel --------------------------------- Userland

setsockopt( DEFER )
listen()

                            <-- socket in listen mode with DEFER option ---

   -- Connection_request -->
                             --- socket accept available ----------------->

A) [ accept case ] 
.............................................................
accept()

send() or
ioctl() or
setsockopt() or
better
                             <-------- provide the set of configuration 
items

recv()
  <-- Accept_synchronous_connection
-- Synchronous Connection Complete (OK or rjected) -->
-------------------------------> in case of failure
need to know the reason
for selecting a fallback
on next connection_request
attempt.




B) [ userland reject case ] 
.............................................................

accept()
close()

  <-- Reject_synchronous_connection (Limited Resources)





Note: Michael Knudsen seems to want to push also things concerning CSA2 
for codec configuration. I'm not really aware of what it imply and why 
it should be managed by the kernel. So I don't know how to put those 
things in the picture.


Arnaud

