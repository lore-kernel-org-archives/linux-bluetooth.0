Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <7560B49A-22C4-4A62-AE3F-B1AFA4712B30@intel.com>
References: <CAFxSrVsZcJxkgAFL8yoSK9buoSzFJryNT18mGSRUUq17VPdOEg@mail.gmail.com>
 <7560B49A-22C4-4A62-AE3F-B1AFA4712B30@intel.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Sun, 17 Sep 2017 20:48:30 +0300
Message-ID: <CABBYNZL5Q-szxged20DgzBnvJnf6AhVkCaQJEM3Ztg4Z1fPy1g@mail.gmail.com>
Subject: Re: meshctl fails on rpi 3
To: "Gix, Brian" <brian.gix@intel.com>
Cc: Laczen JMS <laczenjms@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Sun, Sep 17, 2017 at 7:50 PM, Gix, Brian <brian.gix@intel.com> wrote:
> Hi Jehudi,
>
> Meshctl' crypto does depend on a lot of Kernel based crypto... pretty much everything except for the AES-CCM.

We might want to update
https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/test-runner.txt
if that is not covering the mesh crypto.

> Sent from my iPhone
>
>> On Sep 17, 2017, at 8:42 AM, Laczen JMS <laczenjms@gmail.com> wrote:
>>
>> After downloading and compiling bluez 5.47 on raspberry pi 3 (raspbian
>> 2017-09-07), it is not possible to run meshctl on the raspberry pi.
>> Meshctl fails at loading the prov_db.
>>
>> After some further testing I have found that the loading fails in the
>> crypto functions at binding the AF_ALG in line 178 of crypto.c. Has
>> this something to do with cryptographic modules being unavailable on
>> the rpi 3?
>>
>> If so, what crypto module is required and what is the best way to add
>> these modules ?
>>
>> Kind regards,
>>
>> Jehudi
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
