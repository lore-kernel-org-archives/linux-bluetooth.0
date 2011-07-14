Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110714133706.GB2770@dell.ger.corp.intel.com>
References: <1310497518-19526-1-git-send-email-claudio.takahasi@openbossa.org>
	<20110714133706.GB2770@dell.ger.corp.intel.com>
Date: Thu, 14 Jul 2011 11:24:47 -0300
Message-ID: <CAKT1EBe6Qqgd7h=tQ4EfVVq9NkTWRzQE25Rn8tJT5NYrOWf0Hg@mail.gmail.com>
Subject: Re: [PATCH] Move attrib server init/exit declaration to hcid.h
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Thu, Jul 14, 2011 at 10:37 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Claudio,
>
> On Tue, Jul 12, 2011, Claudio Takahasi wrote:
>> Avoids GATT/ATT headers dependency in main.c.
>> ---
>>  src/attrib-server.h |    3 ---
>>  src/hcid.h          |    3 +++
>>  src/main.c          |    1 -
>>  3 files changed, 3 insertions(+), 4 deletions(-)
>
> Applied. I supposed it'd make sense to come up with a new name for
> hcid.h since there's no such thing as hcid anymore. Suggestions?
>
> Johan
>

My suggestions are:
1) core.h
2) main.h

BTW: maybe we could create another header for main_opts or try to move
it to main.c. hciops and gatt servers implementations are including
it, which looks wrong to me.

Regards,
Claudio
