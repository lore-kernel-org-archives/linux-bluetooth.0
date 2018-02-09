Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZLux4Lg9iKxdbBuxQ2OKZqnfFMrbJDTPOkebERToV9Jrw@mail.gmail.com>
References: <1511938373-22396-1-git-send-email-jaganathx.kanakkassery@intel.com>
 <1511938373-22396-2-git-send-email-jaganathx.kanakkassery@intel.com> <CABBYNZLux4Lg9iKxdbBuxQ2OKZqnfFMrbJDTPOkebERToV9Jrw@mail.gmail.com>
From: Jaganath K <jaganath.k.os@gmail.com>
Date: Fri, 9 Feb 2018 20:13:46 +0530
Message-ID: <CAJzH+bo55vabGyUeZWPVu2JY567A3TUtirKW7AFRph_or6xSbg@mail.gmail.com>
Subject: Re: [PATCH 1/4 v4] doc/mgmt-api: Add support for Get PHY
 Configuration command
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,


> Hi Jaganath,
>
> On Wed, Nov 29, 2017 at 4:52 AM, Jaganath Kanakkassery
> <jaganath.k.os@gmail.com> wrote:
>> ---
>>  doc/mgmt-api.txt | 28 ++++++++++++++++++++++++++++
>>  1 file changed, 28 insertions(+)
>>
>> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
>> index 8e7de14..c07c48c 100644
>> --- a/doc/mgmt-api.txt
>> +++ b/doc/mgmt-api.txt
>> @@ -2871,6 +2871,7 @@ Read Extended Controller Information Command
>>                 13      Privacy
>>                 14      Controller Configuration
>>                 15      Static Address
>> +               16      PHY configuration
>>
>>         The EIR_Data field contains information about class of device,
>>         local name and other values. Not all of them might be present. For
>> @@ -2916,6 +2917,33 @@ Set Appearance Command
>>                                 Invalid Parameters
>>                                 Invalid Index
>>
>> +Get PHY Configuration Command
>> +==========================
>> +
>> +       Command Code:           0x0043
>> +       Controller Index:       <controller id>
>> +       Command Parameters:
>> +       Return Parameters:      Supported_phys (2 Octet)
>> +                               Selected_phys (2 Octet)
>> +
>> +       This command is used to retrieve the supported PHYs and currently
>> +       selected PHYs.
>> +
>> +       Supported_phys and Selected_phys is a bitmask with the following bits.
>> +               0       LE 1M TX
>> +               1       LE 1M RX
>> +               2       LE 2M TX
>> +               3       LE 2M RX
>> +               4       LE CODED TX
>> +               5       LE CODED RX
>> +
>> +       LE 1M TX and LE 1M RX would be supported by default.
>> +
>> +       This command is only available for LE capable controllers.
>> +       It will return Not Supported otherwise.
>> +
>> +       Possible errors:        Not Supported
>> +                               Invalid Index
>>
>>  Command Complete Event
>>  ======================
>> --
>> 2.7.4
>
> Are you still working on this, these perhaps we should integrate and
> start working on setting 2M whenever available.

Yes, actually i had already raised RFC patches for these.
I will raise non RFC patches in a while.

Thanks,
Jaganath
