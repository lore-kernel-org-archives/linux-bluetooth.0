Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZJTQfVRd5DLUmfDS7J_K_zD4qDEft6B2Jiu9WdwgX+7Uw@mail.gmail.com>
References: <1524578447-17347-1-git-send-email-jaganathx.kanakkassery@intel.com>
 <CAJzH+bq-oH2ne260GgO0ehke1NZfHmRh2QFoyQn5sj84xHX46A@mail.gmail.com> <CABBYNZJTQfVRd5DLUmfDS7J_K_zD4qDEft6B2Jiu9WdwgX+7Uw@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 13 Jun 2018 11:22:07 +0300
Message-ID: <CABBYNZ+rNx9+nzJ24en3hwSKVKgrgPfE=FgE9d08CqVXHrZV1Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 00/11] Extended Adv, Scan, Connection and PHY support
To: Jaganath K <jaganath.k.os@gmail.com>
Cc: "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Jun 13, 2018 at 11:09 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Jaganath,
>
> On Wed, Jun 6, 2018 at 8:50 AM, Jaganath K <jaganath.k.os@gmail.com> wrote:
>> Hi,
>>
>> Ping
>>
>> On Tue, Apr 24, 2018 at 7:30 PM, Jaganath Kanakkassery
>> <jaganath.k.os@gmail.com> wrote:
>>> This patch set adds new mgmt APIs for Get / Set PHY contiguration,
>>> Set PHY in Advertising, added mgmt-tester for the new commands,
>>> and also added btmgmt and monitor changes for the new commands
>>> and events
>>>
>>> v2: Made emulator changes onto a seperate patch
>
> One thing Im missing here is the introduction of HCI command decoders
> into the monitor since these changes appear to only introduce the mgmt
> commands. Those could be pushed right away.

Nevermind, the HCI command decoding is already part of the monitor, so
if there is no opposition Id like to push the patches up to the
emulator since that one I think need some work.

>>> Jaganath Kanakkassery (11):
>>>   doc/mgmt-api: Add support for Set Phy Configuration command
>>>   doc/mgmt-api: Add advertising phys support to flags
>>>   monitor: Add support PHY management commands and event
>>>   btmgmt: Add PHY configuration get/set commands
>>>   monitor: Add support for Secondary PHY flags in Add Advertising
>>>   btmgmt: Add support for setting PHY in add-adv
>>>   emulator: Add 5.0 feature support
>>>   mgmt-tester: Add extended advertising test cases
>>>   mgmt-tester: Add PHY Configuration test cases
>>>   mgmt-tester: Add tests for extended scanning and device found
>>>   mgmt-tester: Add support ext create connection and enh conn complete
>>>
>>>  doc/mgmt-api.txt    |  106 +++
>>>  emulator/btdev.c    |  458 ++++++++++-
>>>  emulator/btdev.h    |    1 +
>>>  emulator/bthost.c   |   99 +++
>>>  emulator/bthost.h   |    7 +
>>>  emulator/hciemu.c   |    3 +
>>>  emulator/hciemu.h   |    1 +
>>>  lib/mgmt.h          |   36 +
>>>  monitor/bt.h        |    1 +
>>>  monitor/packet.c    |   68 ++
>>>  tools/btmgmt.c      |  145 +++-
>>>  tools/mgmt-tester.c | 2253 ++++++++++++++++++++++++++++++++++++++++++++++++---
>>>  12 files changed, 3073 insertions(+), 105 deletions(-)
>>>  mode change 100644 => 100755 tools/btmgmt.c
>>>
>>> --
>>> 2.7.4
>>>
>>
>> Thanks,
>> Jaganath
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
