Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <001201d03494$5abd3d60$1037b820$@samsung.com>
References: <1421229458-11207-1-git-send-email-gowtham.ab@samsung.com>
	<001201d03494$5abd3d60$1037b820$@samsung.com>
Date: Thu, 22 Jan 2015 11:03:27 +0200
Message-ID: <CABBYNZK2-RW3p_k90d+3-hXW6wsha=6Aw-ix7eP7GXVTtuhuTg@mail.gmail.com>
Subject: Re: [PATCH 0/3] Fix memory issue and trivial code cleaup
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Gowtham Anandha Babu <gowtham.ab@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Bharat Panda <bharat.panda@samsung.com>, cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gowtham,

On Tue, Jan 20, 2015 at 11:34 AM, Gowtham Anandha Babu
<gowtham.ab@samsung.com> wrote:
> Ping.
>
>> -----Original Message-----
>> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
>> owner@vger.kernel.org] On Behalf Of Gowtham Anandha Babu
>> Sent: Wednesday, January 14, 2015 3:28 PM
>> To: linux-bluetooth@vger.kernel.org
>> Cc: bharat.panda@samsung.com; cpgs@samsung.com; Gowtham Anandha
>> Babu
>> Subject: [PATCH 0/3] Fix memory issue and trivial code cleaup
>>
>> In gatt-client and gatt-helpers, the variables are accessed even after it
> is
>> freed. Making the unref at appropriate places solved the issues.
>>
>> In tools, removed dead code warnings.
>>
>> Gowtham Anandha Babu (3):
>>   shared/gatt-helpers: Fix usage of freed memory
>>   shared/gatt-client: Fix usage of freed memory
>>   tools/hciattach_ath3k: Remove dead code warnings
>>
>>  src/shared/gatt-client.c  | 23 +++++++++++------------  src/shared/gatt-
>> helpers.c | 25 ++++++++++++++++---------
>>  tools/hciattach_ath3k.c   | 11 +----------
>>  3 files changed, 28 insertions(+), 31 deletions(-)
>>
>> --
>> 1.9.1

Doesn't apply anymore, please rebase.



-- 
Luiz Augusto von Dentz
