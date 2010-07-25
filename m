Return-Path: <cyrus@holtmann.org>
Message-ID: <b622ef9ae078ace2da7a8a6748823d2f.squirrel@www.codeaurora.org>
In-Reply-To: <20100723084300.GA14443@jh-x301>
References: <1279814780-29673-1-git-send-email-ingas@codeaurora.org>
    <20100723082045.GA1600@jh-x301> <20100723082754.GA12563@jh-x301>
    <20100723084300.GA14443@jh-x301>
Date: Sun, 25 Jul 2010 15:48:13 -0700 (PDT)
Subject: Re: [PATCH v4 0/5] Enhanced support for extended inquiry response
From: ingas@codeaurora.org
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
 rshaffer@codeaurora.org,
 marcel@holtmann.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Hi,
>
> On Fri, Jul 23, 2010, Johan Hedberg wrote:
>> On Fri, Jul 23, 2010, Johan Hedberg wrote:
>> > Could you explain to me why this is needed. With the current git
>> > (without your patches) the local EIR data seems to be correctly
>> updated
>> > whenever the SDP database changes. Are there some scenarios when this
>> > doesn't happen? I did a quick test with sdptool add/del while
>> bluetoothd
>> > was running and I could see the appropriate "Write Extended Inquiry
>> > Response" commands with hcidump.
>>
>> It seems currently this only happens when a local record change causes
>> the service class bits of the class of device to be updated too. If the
>> record change doesn't affect the class of device then it seems the EIR
>> data isn't modified accordingly. Is this correct? If so, could you
>> please add that information to your commit message so that it's clear
>> why the patch is needed.
>
> Even with your patch it seems this still doesn't work. If I I don't have
> any OBEX servers running and I do "sdptool add OPUSH" I get the
> apropriate EIR update with the OPP UUID (0x1105) added to the list, but
> if I do a consecutive "sdptool add FTP" 0x1106 doesn't get added even
> though it should. Then when I do sdptool del for the OPP record the UUID
> doesn't get removed from the EIR data. So it seems some things still
> need fixing.
>
> Also, could you somehow try to avoid the multiple "Write Extended
> Inquiry Response" commands while bluetoothd is probing drivers for an
> adapter that entered the UP state? With the class of device this is done
> through adapter->cache_enable, so maybe some more generic system could
> be used for all HCI trafic related to probing drivers.
>
> Johan
>

Thank you for your comments.

It seems my comment for this patch submisiion was not specific enough (my
apologies). The extended support for EIR update was meant for the cases
when d-bus methods "AddRecord", "RemoveRecord" and "Update Record" were
called. I did verify the problems that you indicated in EIR update when
using sdptool. However, this is a pre-existing condition not related to
the extensions that I submitted. sdptool uses different mechanism for EIR
update that was not affected by my changes. That needs to be fixed in a
separate patch set, IMO.

Testing of EIR being updated when calling the above mentioned d-bus
methods can be done using d-feet interface to call the methods with
subsequent call to hcitool to execute "Read EIR" command ($hcitool -i
hci<n> cmd 0x03 0x0051).

I do need to change the comments on the patches to expalin better what has
been added. Will that be sufficient?

Regards,

Inga
