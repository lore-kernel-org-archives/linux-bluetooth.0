Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH] mgmt-api: Add support to get connection characteristics
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAF3PWx0DdnuMmbb8d_0grm-8QH-Pa6OTO9KOfvj03obwSV2hsQ@mail.gmail.com>
Date: Wed, 7 May 2014 00:48:25 -0700
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <51FD0F51-8A29-453A-9799-B0F4763D5CB1@holtmann.org>
References: <1399420690-21653-1-git-send-email-lukasz.rymanowski@tieto.com> <BC6B9000-DD5A-4BA4-91B3-F68776872D78@holtmann.org> <CAF3PWx0DdnuMmbb8d_0grm-8QH-Pa6OTO9KOfvj03obwSV2hsQ@mail.gmail.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

>>> This patch introduces Get Connection Characteristics command.
>>> ---
>>> doc/mgmt-api.txt | 36 ++++++++++++++++++++++++++++++++++++
>>> 1 file changed, 36 insertions(+)
>>> 
>>> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
>>> index cd5cd24..5d31a90 100644
>>> --- a/doc/mgmt-api.txt
>>> +++ b/doc/mgmt-api.txt
>>> @@ -1679,6 +1679,42 @@ Load Identity Resolving Keys Command
>>>                              Invalid Index
>>> 
>>> 
>>> +Get Connection Characteristics Command
>>> +======================================
>> 
>> we might need to discuss if we better call it “Get Connection Information”. I wait for other people to comment here.
> 
> I like it, should be also nicer to put in code - 'characteristics' is
> horrible to combine into variable names and abbreviate ;-)
> 
>>> +
>>> +     Command Code:           0x0031
>>> +     Controller Index:       <controller id>
>>> +     Command Parameters:     Address (6 Octets)
>>> +                             Address_Type (1 Octet)
>>> +                             Requested_Characteristics (4 Octet)
>> 
>> Maybe just calling this Data_Types is better. Not that it matters much, but the field name Requested_Characteristics sound a bit too much.
>> 
>>> +
>> 
>> Remove this extra empty line.
>> 
>>> +     Return Parameters:      Address (6 Octets)
>>> +                             Address_Type (1 Octet)
>>> +                             RSSI (1 Octet)
>> 
>> Add the Flags (4 Octets) value here. We want to be flexible and being able to indicate certain flags might come in handy at some point.
>> 
>>> +                             EIR_Data_Length (2 Octets)
>>> +                             EIR_Data (0-65535 Octets)
>>> +
>>> +     This command is used to get connection characteristics information.
>>> +
>>> +     Requested_Characteristics parameter is a bitmask with currently the
>>> +     following available bits:
>>> +
>>> +             0       RSSI
>>> +             1       TX Power
>> 
>> Start with 0 = TX Power here. There is pretty much no point for RSSI since that will always be returned.
> 
> There will always be RSSI parameter in response but it does not need
> to be valid (perhaps we can use Flags for this) unless we query for
> RSSI on every request from user-space or poll for RSSI in background,
> but I don't think this is what we really want here.

if it is invalid we can return -127 or whatever value is defined for invalid.

> As I understand we want to minimize requests to controller so we do
> something like: have timestamps for most recent RSSI and TX power
> received and once information is requested, check which one can be
> answered from cache and query controller only for missing one. This
> implies that both values don't need to be from exactly the same point
> of time but they both are no-older-than some interval. Does this make
> sense?

We can have a single timestamp here. No need to be super smart. At least not in the initial implementation.

The one thing I really want is that we do not bring the controller out of sniff mode for this. The host will be woken up anyway. So it is not a big deal if we request both values.

>> Also we need to note that all other bits are reserved and shall be set to zero. Unknown bits will be ignored by the kernel on reception.
>> 
>>> +     All the requested characteristics other than RSSI are returned in
>>> +     EIR_Data.
>>> +
>>> +     This command generates a Command Complete event on success and
>>> +     on failure.
>>> +
>>> +     Possible errors:        Busy
>>> +                             Not Connected
>>> +                             Not Powered
>>> +                             Invalid Parameters
>>> +                             Invalid Index
>> 
>> How can this return Busy? As I said before, we need to just have an internal configured via debugfs in which this command will return the cached values. So even if you call this twice in a row or at the same time, we should just return quickly.
> 
> In case requested values cannot be answered from cache we need to
> query for them and when this is in ongoing we'll request Busy for
> other requests. Or we can just queue requests and answer them when
> response arrive so we don't need to return Busy.

Actually I am more thinking that if we already have an ongoing request from one client, just let the second one wait and return responses to both requests at the same time once the initial one finishes. It is an async API afterall.

The one thing I do not want, hey, busy, lets poll again, busy again, lets poll again. Implementing a back off algorithm in the client seems like a pretty stupid idea.

Regards

Marcel

