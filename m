Return-Path: <cyrus@holtmann.org>
Message-ID: <52979F05.3040803@linux.intel.com>
Date: Thu, 28 Nov 2013 21:52:37 +0200
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH_v2 3/7] profiles/network: Rename common.c|h to bnep.c|h
References: <1385649955-29276-1-git-send-email-ravikumar.veeramally@linux.intel.com>	<1385649955-29276-4-git-send-email-ravikumar.veeramally@linux.intel.com> <CABBYNZJVZUjsTpgbAWx7J+gg4OYd4SkzvH+2nLAqaMnH-rm49Q@mail.gmail.com>
In-Reply-To: <CABBYNZJVZUjsTpgbAWx7J+gg4OYd4SkzvH+2nLAqaMnH-rm49Q@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On 28.11.2013 18:19, Luiz Augusto von Dentz wrote:
> Hi Ravi,
>
> On Thu, Nov 28, 2013 at 4:45 PM, Ravi kumar Veeramally
> <ravikumar.veeramally@linux.intel.com> wrote:
>> Files common.c|h contains only bnep related code, it makes
>> more sence with bnep.c|h.
>> ---
>>   Makefile.plugins              |   2 +-
>>   profiles/network/bnep.c       | 453 ++++++++++++++++++++++++++++++++++++++++++
>>   profiles/network/bnep.h       |  42 ++++
>>   profiles/network/common.c     | 453 ------------------------------------------
>>   profiles/network/common.h     |  42 ----
>>   profiles/network/connection.c |   2 +-
>>   profiles/network/manager.c    |   2 +-
>>   profiles/network/server.c     |   2 +-
>>   8 files changed, 499 insertions(+), 499 deletions(-)
>>   create mode 100644 profiles/network/bnep.c
>>   create mode 100644 profiles/network/bnep.h
>>   delete mode 100644 profiles/network/common.c
>>   delete mode 100644 profiles/network/common.h
> Did you use git mv? I would expect something like the following if did:
  Yes, I did git mv.
   reason might be bnep.c has it's own include file bnep.h.
   So bnpe.c is 99% bnep.h 100%.

> ---
>   profiles/network/{common.c => bnep.c} | 0
>   profiles/network/{common.h => bnep.h} | 0
>   2 files changed, 0 insertions(+), 0 deletions(-)
>   rename profiles/network/{common.c => bnep.c} (100%)
>   rename profiles/network/{common.h => bnep.h} (100%)
>
> diff --git a/profiles/network/common.c b/profiles/network/bnep.c
> similarity index 100%
> rename from profiles/network/common.c
> rename to profiles/network/bnep.c
> diff --git a/profiles/network/common.h b/profiles/network/bnep.h
> similarity index 100%
> rename from profiles/network/common.h
> rename to profiles/network/bnep.h
> --
  Have you tried to compile after it?

Thanks,
Ravi.
