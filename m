Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZLyT80dZHzuZA=F=KvqrQsK9sZqgyq211Uoysk0Gap7UA@mail.gmail.com>
References: <1345653354-23720-1-git-send-email-s.syam@samsung.com>
 <1345653354-23720-2-git-send-email-s.syam@samsung.com> <CABBYNZLr1iENopeSbqqiQuryC0T99KkG=Go-K0j9zNca_ijpVQ@mail.gmail.com>
 <CABBYNZJ37+GoQx66+xD+K9_Lbi4yQZq_TWt_qDMiObdmwUg0AA@mail.gmail.com> <CABBYNZLyT80dZHzuZA=F=KvqrQsK9sZqgyq211Uoysk0Gap7UA@mail.gmail.com>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Fri, 24 Aug 2012 10:46:46 -0300
Message-ID: <CAMOw1v7f=mhy63k49cqKQKuBVaxg5sDese2UcVZkAGZqaBH99g@mail.gmail.com>
Subject: Re: [PATCH obexd v1 2/4] build: Require GLib 2.32 or later
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Syam Sidhardhan <s.syam@samsung.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Aug 24, 2012 at 6:45 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Syam,
>
> On Thu, Aug 23, 2012 at 1:36 AM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> Hi Syam,
>>
>> On Thu, Aug 23, 2012 at 1:27 AM, Luiz Augusto von Dentz
>> <luiz.dentz@gmail.com> wrote:
>>> Hi Syam,
>>>
>>> On Wed, Aug 22, 2012 at 7:35 PM, Syam Sidhardhan <s.syam@samsung.com> wrote:
>>>> If we use GLib version less than 2.32 (more precisely < 2.31.2) then
>>>> the following build error may occure in a 32 bit.
>>>
>>> We had the issue with BlueZ but we did not bump the glib version,
>>> which makes me wonder if you are able to compile bluetoothd?
>>
>> It looks like we fix it with use of a variable:
>>
>>  commit e34836262ba6a46491b6a760520158d70e8b51b5
>> Author: Johan Hedberg <johan.hedberg@intel.com>
>> Date:   Wed Oct 12 00:48:59 2011 +0300
>>
>>     Fix compilation error on 32-bit systems
>>
>>     This fixes the following compilation error with GLib on 32-bit sytems:
>>
>>     audio/media.c: In function 'get_setting':
>>     audio/media.c:1109:44: error: cast to pointer from integer of
>> different size [-Werror=int-to-pointer-cast]
>>     audio/media.c: In function 'set_setting':
>>     audio/media.c:1132:41: error: cast to pointer from integer of
>> different size [-Werror=int-to-pointer-cast]
>
> How about the following patch:

I will say the same thing when the other similar fix was committed to
BlueZ: creating an extra variable all over the repository because the
macro was not defined correctly is not good. Mainly because over the
time we would create the same problem in other places as well because
in general devs are using more recent versions of glib  (as shown in
the places this patch is fixing now) .

So, I'd propose the following: if we don't want to increase the
minimum required version of glib, lets define this macro ourselves. Or
make it a build-time conditional in glib-helper.h


Lucas De Marchi
