Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZLAt520ASue5Ba-BLpdp-+_H911H86fpZ9=qPSwfGkDRg@mail.gmail.com>
References: <1393613928-22264-1-git-send-email-ravikumar.veeramally@linux.intel.com>
	<CABBYNZLAt520ASue5Ba-BLpdp-+_H911H86fpZ9=qPSwfGkDRg@mail.gmail.com>
Date: Tue, 4 Mar 2014 13:48:55 +0200
Message-ID: <CABBYNZ+vVP9mMj8nq=ifpHdomacebuyP33Cb2QujgEeoTW171g@mail.gmail.com>
Subject: Re: [PATCH 0/6] Initial HAL test AVRCP api support
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On Sun, Mar 2, 2014 at 8:57 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Ravi,
>
> On Fri, Feb 28, 2014 at 8:58 PM, Ravi kumar Veeramally
> <ravikumar.veeramally@linux.intel.com> wrote:
>> Patchset contains initial AVRCP api support for HAL test.
>>
>> Ravi kumar Veeramally (6):
>>   android/client: Add AVRCP get_play_status_rsp support
>>   android/client: Add AVRCP get_element_attr_rsp support
>>   android/client: Add AVRCP set_volume support
>>   android/client: Add AVRCP get_play_status_cb support
>>   android/client: Add AVRCP get_element_attr_cb support
>>   android/client: Add AVRCP volume_change_cb support
>>
>>  android/client/if-rc.c | 151 +++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 151 insertions(+)
>>
>> --
>> 1.8.3.2
>
> This doesn't help much with AVRCP since the requests need to be
> responded rather quickly we might need to have them auto responded if
> we really want hal-tester to be usable.

Applied, it turn out to be useful while testing but I did need to add
\n in a few places.


-- 
Luiz Augusto von Dentz
