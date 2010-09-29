Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20100929134908.GB19362@jh-x301>
References: <1285696155-32766-1-git-send-email-claudio.takahasi@openbossa.org>
	<20100929134908.GB19362@jh-x301>
Date: Wed, 29 Sep 2010 11:52:43 -0300
Message-ID: <AANLkTi=1hKSL+2-DJ4SJkZJ+TaAzP1BUSh4FbiT=xg4g@mail.gmail.com>
Subject: Re: [PATCH 1/4] Add the Attribute interface to the API
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>,
	linux-bluetooth@vger.kernel.org,
	Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Sep 29, 2010 at 10:49 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi,
>
> On Tue, Sep 28, 2010, Claudio Takahasi wrote:
>> +Attribute Protocol hierarchy
>> +============================
>> +
>> +Service              org.bluez
>> +Interface    org.bluez.Attribute
>> +Object path  [prefix]/{hci0}/{device0}
>> +
>> +
>> +Methods              dict GetProperties()
>> +
>> +                     Returns all properties for the interface. See the
>> +                     properties section for available properties.
>> +
>> +Properties   array{object} Services
>> +
>> +                     List of all the Primary Services that this device
>> +                     implements.
>> +
>> +
>>  Device Service hierarchy
>>  ========================
>>
>> diff --git a/doc/device-api.txt b/doc/device-api.txt
>> index 95b5b22..b818299 100644
>> --- a/doc/device-api.txt
>> +++ b/doc/device-api.txt
>> @@ -139,10 +139,6 @@ Properties       string Address [readonly]
>>                       List of 128-bit UUIDs that represents the available
>>                       remote services.
>>
>> -             array{object} Services [readonly]
>> -
>> -                     List of characteristics based services.
>> -
>>               boolean Paired [readonly]
>>
>>                       Indicates if the remote device is paired.
>
> What's the motivation of moving this into its own D-Bus interface? I
> thought the plan was to abstract both traditional SDP and ATT behind the
> same API in which case having this in the Device interface makes more
> sense imho.
>
> Johan
>

Hi Johan,

we forgot the SDP integration plan. Forget this patch.

>From the implementation point of view, implement inside the attrib
client plugin was the easiest way, if we keep this property inside the
Device interface a new function needs to be created in device.h to
register the available primary services object paths.

Claudio.
