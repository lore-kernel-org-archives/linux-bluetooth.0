Return-Path: <cyrus@holtmann.org>
Message-ID: <5050135C.4010801@ti.com>
Date: Wed, 12 Sep 2012 07:45:16 +0300
From: Chen Ganir <chen.ganir@ti.com>
MIME-Version: 1.0
To: Joao Paulo Rechi Vita <jprvita@openbossa.org>
CC: <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 01/10] battery: Add generic device battery documentation
References: <1347349100-24228-1-git-send-email-chen.ganir@ti.com> <1347349100-24228-2-git-send-email-chen.ganir@ti.com> <CAAngNMaSq2e7XXdLWOSbegOcgmqFaLzGZmGivRn9ERo-YL57JQ@mail.gmail.com>
In-Reply-To: <CAAngNMaSq2e7XXdLWOSbegOcgmqFaLzGZmGivRn9ERo-YL57JQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Joao,

On 09/11/2012 06:34 PM, Joao Paulo Rechi Vita wrote:
> Hello Chen,
>
> On Tue, Sep 11, 2012 at 4:38 AM,  <chen.ganir@ti.com> wrote:
>> From: Chen Ganir <chen.ganir@ti.com>
>>
>> Add documentation for the generic battery D-Bus interface.
>> ---
>>   doc/battery-api.txt |   33 +++++++++++++++++++++++++++++++++
>>   doc/device-api.txt  |    5 +++++
>>   2 files changed, 38 insertions(+)
>>   create mode 100644 doc/battery-api.txt
>>
>> diff --git a/doc/battery-api.txt b/doc/battery-api.txt
>> new file mode 100644
>> index 0000000..d5ef5ed
>> --- /dev/null
>> +++ b/doc/battery-api.txt
>> @@ -0,0 +1,33 @@
>> +BlueZ D-Bus Battery API description
>> +****************************************
>> +
>> +       Texas Instruments, Inc. <chen.ganir@ti.com>
>> +
>> +Device Battery hierarchy
>> +=====================================
>> +
>> +Service                org.bluez
>> +Interface      org.bluez.Battery
>> +Object path    [variable prefix]/{hci0,..}/dev_XX_XX_XX_XX_XX_XX/BATTYYYY
>> +YYYY is numeric value between 0 and 9999.
>> +
>> +Methods        dict GetProperties()
>> +
>> +                       Returns all properties for the interface. See the
>> +                       Properties section for the available properties.
>> +
>> +               void Refresh()
>> +
>> +                       Refresh the batterty level. If the battery level changed, the
>> +                       PropertyChanged signal will be sent with the new value.
>> +
>> +Signals                PropertyChanged(string name, variant value)
>> +
>> +                       This signal indicates a changed value of the given
>> +                       property.
>> +
>> +Properties     uint16 Level [readonly]
>> +
>> +                       Battery level (0-100).
>> +
>> +
>
> Can you please remove these two blank lines on the end of the file?
>
Ok.

>> diff --git a/doc/device-api.txt b/doc/device-api.txt
>> index 1f0dc96..c98d539 100644
>> --- a/doc/device-api.txt
>> +++ b/doc/device-api.txt
>> @@ -179,3 +179,8 @@ Properties  string Address [readonly]
>>                          Note that this property can exhibit false-positives
>>                          in the case of Bluetooth 2.1 (or newer) devices that
>>                          have disabled Extended Inquiry Response support.
>> +
>> +               array{object} Batteries [readonly]
>> +
>> +                       List of device battery object paths that represents the available
>> +                       batteries on the remote device.
>> --
>> 1.7.9.5
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>

Thanks for the review.

-- 
BR,
Chen Ganir

