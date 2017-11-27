Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20171127133255.GA24336@x1c.home>
References: <1511173617-25442-1-git-send-email-jaganathx.kanakkassery@intel.com>
 <1511173617-25442-4-git-send-email-jaganathx.kanakkassery@intel.com> <20171127133255.GA24336@x1c.home>
From: Jaganath K <jaganath.k.os@gmail.com>
Date: Mon, 27 Nov 2017 20:12:19 +0530
Message-ID: <CAJzH+boV9t4T_zEwmB+Lm97x9gf5TsMh1i468jdK9XBo9rTq6g@mail.gmail.com>
Subject: Re: [PATCH 3/3 v2] doc/mgmt-api: Add advertising phys support to flags
To: Jaganath Kanakkassery <jaganath.k.os@gmail.com>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,


> Hi Jaganath,
>
> On Mon, Nov 20, 2017, Jaganath Kanakkassery wrote:
>> @@ -2613,6 +2625,9 @@ Add Advertising Command
>>               4       Add TX Power field to Adv_Data
>>               5       Add Appearance field to Scan_Rsp
>>               6       Add Local Name in Scan_Rsp
>> +             7       Secondary Channel with LE 1M
>> +             8       Secondary Channel with LE 2M
>> +             9       Secondary Channel with LE Coded
>>
>>       When the connectable flag is set, then the controller will use
>>       undirected connectable advertising. The value of the connectable
>> @@ -2640,6 +2655,13 @@ Add Advertising Command
>>       supported to provide less air traffic for devices implementing
>>       broadcaster role.
>>
>> +     Secondary channel flags can be used to advertise in secondary
>> +     channel with the corresponding PHYs. In case of 2M, the primary
>> +     channel used would be 1M. If none of them are set then secondary
>> +     channel advertising would be disabled for this instance which is as
>> +     good as legacy advertising. Combining the sets would result in
>> +     multiple advertising sets being created.
>
> What kind of combination of parameters would we select LE Coded for the
> primary channel? Don't we need a flag for it? It should either way be
> documented when LE Coded gets used for the primary PHY.
>

Primary channel can be both 1M or CODED and secondary channel can be
either 1M, 2M or CODED. As per spec all the permutation and combination of
the above values is possible with Primary and secondary channel.

But in the current interface all the combinations are not supported
right now since
atleast i dont find the use case for all of them, for example if we
use CODED for
any of primary or secondary channel then the scanner is intended to be
in Long range
and using any other PHY on the other does not make sense.

So basically if "Secondary Channel with LE Coded" is selected then both primary
and secondary will be set as LE Coded.

I will raise a patch to document it if there is no objection to this assumption.

Thanks,
Jaganath
