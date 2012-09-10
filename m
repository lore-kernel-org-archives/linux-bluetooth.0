Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <504C3044.9000200@ti.com>
References: <1346325980-11411-1-git-send-email-chen.ganir@ti.com>
	<1346325980-11411-2-git-send-email-chen.ganir@ti.com>
	<CAKT1EBdo=yJX+DZmnFJoMydE4D_sD-CzOpYFwdKTXwKmcHQgAw@mail.gmail.com>
	<504C3044.9000200@ti.com>
Date: Mon, 10 Sep 2012 10:24:26 -0300
Message-ID: <CAKT1EBeeSPWqas=MC=caf0BXw1dgeY_9kM0EEOqRkW=OLphtpA@mail.gmail.com>
Subject: Re: [PATCH RFC] battery: Add generic device battery interface
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Chen Ganir <chen.ganir@ti.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chen Ganir:

On Sun, Sep 9, 2012 at 2:59 AM, Chen Ganir <chen.ganir@ti.com> wrote:
> Claudio,
>
>
> On 09/06/2012 10:34 PM, Claudio Takahasi wrote:
>>
>> Hi Chen Ganir:
>>
>> On Thu, Aug 30, 2012 at 8:26 AM,  <chen.ganir@ti.com> wrote:
>>>
>>> From: Chen Ganir <chen.ganir@ti.com>
>>>
>>> Add the D-Bus API documentation for the new generic device battery
>>> interface. This API provides generic access to peer devcice
>>> batteries.
>>> ---
>>>   doc/battery-api.txt |   34 ++++++++++++++++++++++++++++++++++
>>>   doc/device-api.txt  |    5 +++++
>>>   2 files changed, 39 insertions(+)
>>>   create mode 100644 doc/battery-api.txt
>>>
>>> diff --git a/doc/battery-api.txt b/doc/battery-api.txt
>>> new file mode 100644
>>> index 0000000..da82024
>>> --- /dev/null
>>> +++ b/doc/battery-api.txt
>>> @@ -0,0 +1,34 @@
>>> +BlueZ D-Bus Battery API description
>>> +****************************************
>>> +
>>> +       Texas Instruments, Inc. <chen.ganir@ti.com>
>>> +
>>> +Device Battery hierarchy
>>> +=====================================
>>> +
>>> +Service                org.bluez
>>> +Interface      org.bluez.Battery
>>> +Object path    [variable
>>> prefix]/{hci0,..}/dev_XX_XX_XX_XX_XX_XX/BATTYYYY
>>> +YYYY is numeric value between 0 and 9999.
>>> +
>>> +Methods        dict GetProperties()
>>> +
>>> +                       Returns all properties for the interface. See the
>>> +                       Properties section for the available properties.
>>> +
>>> +Signals                PropertyChanged(string name, variant value)
>>> +
>>> +               This signal indicates a changed value of the given
>>> +               property.
>>> +
>>> +Properties     uint16 Level [readonly]
>>> +
>>> +                       Battery level (0-100).
>>> +
>>> +               uint16 Description [readonly]
>>> +
>>> +                       Battery description.
>>> +
>>> +               uint16 Namespace [readonly]
>>> +
>>> +                       Battery Namespace.
>>
>>
>> IMO "Description" and "Namespace" should be string:
>> http://developer.bluetooth.org/gatt/Pages/GattNamespaceDescriptors.aspx
>>
>> For BLE Presentation Format is mandatory(Namespace and Description).
>> For AVRCP, probably it doesn't make sense. I recommend to include
>> additional description for these fields.
>>
> After discussing this issue with Johan, we decided to remove the Namespace
> and Description properties from the generic battery. Do you think we should
> have those properties or can we exclude them ? Do you see any use case for
> those properties?
>

IMO, we can remove them. It is easier to extend the API later than
remove properties from the API.
Those properties could be useful for PTS testing or qualification, but
we can use gatttool to discover and read descriptors.

Regards,
Claudio
