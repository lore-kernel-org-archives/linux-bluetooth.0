Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110914092631.GA22568@dell.ger.corp.intel.com>
References: <1315572669-5006-1-git-send-email-claudio.takahasi@openbossa.org>
	<20110914092631.GA22568@dell.ger.corp.intel.com>
Date: Thu, 15 Sep 2011 16:28:55 -0300
Message-ID: <CAKT1EBdtRU5QKdw7TfsK4_TQA9oSrnR=gog8F+1Jur07JnMmAw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 0/5] Storage cleanup
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Wed, Sep 14, 2011 at 6:26 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Claudio,
>
> On Fri, Sep 09, 2011, Claudio Takahasi wrote:
>> Dependency: SMP patches needs to be applied first due conflicts in
>> storage.{c, h} => "[PATCH BlueZ 00/12] Support for the new mgmt SMP
>> messages"
>>
>> This patch series removes useless code in storage.c and contains minor
>> cosmetic changes.
>>
>> Claudio Takahasi (5):
>>   Remove storing device type
>>   Remove create_file calls for read operations
>>   Remove not referenced function in storage.c
>>   Remove unneeded headers included in storage.c
>>   Fix magic numbers for local/remote name length
>>
>>  src/adapter.c |   28 -----------------
>>  src/device.c  |    2 -
>>  src/storage.c |   91 ++++-----------------------------------------------------
>>  src/storage.h |    4 --
>>  4 files changed, 6 insertions(+), 119 deletions(-)
>
> Would it be possible to rebase these on top of current git (github).
> These are clear fixes that could be applied now whereas the SMP patches
> they depend on will still need some discussion and review.
>
> Johan
>

Ok.

I will rebase it and send the patch series again.

BR,
Claudio
