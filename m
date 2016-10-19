Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAEJBh+vOrDA_bbj7e8zhyZS+0pWBnN7wOa0Huv3PGkDWUwvSA@mail.gmail.com>
References: <1476817861-24158-1-git-send-email-puthik@chromium.org>
 <1476817861-24158-3-git-send-email-puthik@chromium.org> <CABBYNZ+_E_T-iDXQMDteZQKg+qmkZhyiPRZnX-j-UgzvUvk0ow@mail.gmail.com>
 <CAAEJBh+vOrDA_bbj7e8zhyZS+0pWBnN7wOa0Huv3PGkDWUwvSA@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 19 Oct 2016 19:21:53 +0300
Message-ID: <CABBYNZJMncaA0pgOx5DvGS5=Mfy=Q0bp=CfPDKtg2Bif7rB-gQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] doc/device-api: Add AdvertisingFlags
To: Szymon Janc <szymon.janc@codecoup.pl>
Cc: puthik@chromium.org,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Wed, Oct 19, 2016 at 7:15 PM, Szymon Janc <szymon.janc@codecoup.pl> wrote:
> Hi,
>
> On 19 October 2016 at 09:19, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> Hi,
>>
>> On Tue, Oct 18, 2016 at 10:10 PM,  <puthik@chromium.org> wrote:
>>> From: Puthikorn Voravootivat <puthik@chromium.org>
>>>
>>> This exposed Advertising Flags to BlueZ Device API
>>>
>>> Signed-off-by: Puthikorn Voravootivat <puthik@chromium.org>
>>> ---
>>>  doc/device-api.txt | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/doc/device-api.txt b/doc/device-api.txt
>>> index f5cac49..1985698 100644
>>> --- a/doc/device-api.txt
>>> +++ b/doc/device-api.txt
>>> @@ -230,3 +230,7 @@ Properties  string Address [readonly]
>>>
>>>                         Indicate whether or not service discovery has been
>>>                         resolved.
>>> +
>>> +               array{byte} AdvertisingFlags [readonly]
>>> +
>>> +                       The Advertising Data Flags of the remote device.
>>
>> It should probably be marked as experimental for now.
>
> Hmm I wonder.. why not just expose full AD + SCAN_RSP this way?
> Are we going to add prop for every data type?

Then there is no reason to parse the AD, and even broken/unknown AD
should be send which sounds like a very dangerous think to do so Id
leave this for application that can deal with the management socket
but not over D-Bus.

-- 
Luiz Augusto von Dentz
