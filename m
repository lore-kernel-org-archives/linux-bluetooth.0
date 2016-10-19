Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+_E_T-iDXQMDteZQKg+qmkZhyiPRZnX-j-UgzvUvk0ow@mail.gmail.com>
References: <1476817861-24158-1-git-send-email-puthik@chromium.org>
 <1476817861-24158-3-git-send-email-puthik@chromium.org> <CABBYNZ+_E_T-iDXQMDteZQKg+qmkZhyiPRZnX-j-UgzvUvk0ow@mail.gmail.com>
From: Szymon Janc <szymon.janc@codecoup.pl>
Date: Wed, 19 Oct 2016 18:15:48 +0200
Message-ID: <CAAEJBh+vOrDA_bbj7e8zhyZS+0pWBnN7wOa0Huv3PGkDWUwvSA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] doc/device-api: Add AdvertisingFlags
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: puthik@chromium.org,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 19 October 2016 at 09:19, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi,
>
> On Tue, Oct 18, 2016 at 10:10 PM,  <puthik@chromium.org> wrote:
>> From: Puthikorn Voravootivat <puthik@chromium.org>
>>
>> This exposed Advertising Flags to BlueZ Device API
>>
>> Signed-off-by: Puthikorn Voravootivat <puthik@chromium.org>
>> ---
>>  doc/device-api.txt | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/doc/device-api.txt b/doc/device-api.txt
>> index f5cac49..1985698 100644
>> --- a/doc/device-api.txt
>> +++ b/doc/device-api.txt
>> @@ -230,3 +230,7 @@ Properties  string Address [readonly]
>>
>>                         Indicate whether or not service discovery has been
>>                         resolved.
>> +
>> +               array{byte} AdvertisingFlags [readonly]
>> +
>> +                       The Advertising Data Flags of the remote device.
>
> It should probably be marked as experimental for now.

Hmm I wonder.. why not just expose full AD + SCAN_RSP this way?
Are we going to add prop for every data type?

-- 
pozdrawiam
Szymon K. Janc
