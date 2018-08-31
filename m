Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+ae4m5p6MroLovcEAM32daUQekDNDa9-RDq-K69H5DLQ@mail.gmail.com>
References: <BN7PR07MB4305F612204DE3F155FDF7329D310@BN7PR07MB4305.namprd07.prod.outlook.com>
 <BN7PR07MB430554B9AF5693730B7A4F6C9D0F0@BN7PR07MB4305.namprd07.prod.outlook.com>
 <CABBYNZ+ae4m5p6MroLovcEAM32daUQekDNDa9-RDq-K69H5DLQ@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 31 Aug 2018 17:03:36 +0300
Message-ID: <CABBYNZLAypMvpL-U7Mm=T4r=fabQ+4nLwUcBj5QYHsPi9Wt_Jg@mail.gmail.com>
Subject: Re: [External] [PATCH BlueZ v2 0/2] Change ConnectDevice to connect a
 subset of services
To: "Karabin, Josh" <George.Karabin@honeywell.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Josh,

On Fri, Aug 31, 2018 at 4:58 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Josh,
>
> On Fri, Aug 31, 2018 at 4:47 PM, Karabin, Josh
> <George.Karabin@honeywell.com> wrote:
>> Hello all - I would like to point your attention to this
>> patch set again. I realize it's more complicated than v1, and likely
>> needs more time for review.
>
> Could you please add description to each patch, also is your email correct?

I forgot to mention that the documentation should come first and
perhaps it makes send that we use ConnectDevice in bluetoothctl, may
add an optional parameter for UUIDs list which in case it is set the
use Adapter.ConnectDevice instead of Device.Connect.

>>> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
>>> owner@vger.kernel.org] On Behalf Of Karabin, Josh
>>> Sent: Tuesday, August 21, 2018 11:37 AM
>>> To: linux-bluetooth@vger.kernel.org
>>> Subject: [External] [PATCH BlueZ v2 0/2] Change ConnectDevice to connect a
>>> subset of services
>>>
>>> This patch set makes it possible to use the experimental Adapter1
>>> ConnectDevice DBUS API to connect to a device without also
>>> connecting each of the device's services. This enables the out-of-band
>>> discovery of an address and expected service set without a
>>> general discovery procedure.
>>>
>>> This patch builds on this previous commit:
>>>
>>> commit c3f7b6733c5f ("adapter: Add ConnectDevice method")
>>>
>>> and review feedback on an earlier patch here:
>>>
>>> https://marc.info/?l=linux-bluetooth&m=153451634605069&w=2
>>>
>>> George Josh Karabin (2):
>>>   Allow Adapter1 ConnectDevice method to connect a limited set of
>>>     service UUIDs
>>>   Update the Adapter1 API to match the change to ConnectDevice.
>>>
>>> George Josh Karabin (2):
>>>   Allow Adapter1 ConnectDevice method to connect a limited set of
>>>     service UUIDs
>>>   Update the Adapter1 API to match the change to ConnectDevice.
>>>
>>>  doc/adapter-api.txt | 16 +++++---
>>>  src/adapter.c       | 91 +++++++++++++++++++++++++++++++++++++++++--
>>> --
>>>  2 files changed, 95 insertions(+), 12 deletions(-)
>>>
>>> --
>>> 2.17.1
>
>
>
> --
> Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
