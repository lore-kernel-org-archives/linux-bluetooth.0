Return-Path: <cyrus@holtmann.org>
Message-ID: <52B18BB3.9030907@linux.intel.com>
Date: Wed, 18 Dec 2013 13:49:07 +0200
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: "linux-bluetooth@vger.kernel.org development" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] avctp: Move avctp.c|h from profiles/audio to protocol/
References: <1387365861-23356-1-git-send-email-ravikumar.veeramally@linux.intel.com> <13E32B04-DDEA-4BE1-BCAB-40C0395D638F@holtmann.org>
In-Reply-To: <13E32B04-DDEA-4BE1-BCAB-40C0395D638F@holtmann.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

Ok, I just had a chat with Luiz now. Actually task description is outdated.
Sorry for inconvenience. Please ignore this patch.

Regards,
Ravi.

On 18.12.2013 13:39, Marcel Holtmann wrote:
> Hi Ravi,
>
>> This is an initial patch for decoupling avctp.c|h from profiles/audio.
>> Goal is to remove external dependency (glib is enough) and reusable
>> to android/* sources.
>> ---
>> Makefile.plugins                     | 2 +-
>> {profiles/audio => protocol}/avctp.c | 7 +------
>> {profiles/audio => protocol}/avctp.h | 0
>> 3 files changed, 2 insertions(+), 7 deletions(-)
>> rename {profiles/audio => protocol}/avctp.c (99%)
>> rename {profiles/audio => protocol}/avctp.h (100%)
> actually, no.
>
> The breaks my nicely tab-tab-completion handling when going through the source code. Pro{file,tocol} have a way to close prefix.
>
> Regards
>
> Marcel
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
