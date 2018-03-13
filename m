Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <27a6ae54-60ab-9d85-8529-bc8ecf9cc706@jp.fujitsu.com>
References: <1520580354-2185-1-git-send-email-jaganathx.kanakkassery@intel.com>
 <1520580354-2185-2-git-send-email-jaganathx.kanakkassery@intel.com> <27a6ae54-60ab-9d85-8529-bc8ecf9cc706@jp.fujitsu.com>
From: Jaganath K <jaganath.k.os@gmail.com>
Date: Tue, 13 Mar 2018 11:32:50 +0530
Message-ID: <CAJzH+bq7nka-OfO0m7_MRaT+XgZozWjJhP=9TabT9pqyVn4Rbw@mail.gmail.com>
Subject: Re: [PATCH 2/4 v1] btmgmt: Add PHY configuration get/set commands
To: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Cc: "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Eramoto,

On Mon, Mar 12, 2018 at 1:44 PM, ERAMOTO Masaya
<eramoto.masaya@jp.fujitsu.com> wrote:
> Hi Jaganath,
>
> On 03/09/2018 04:25 PM, Jaganath Kanakkassery wrote:
>> ---
>>  lib/mgmt.h     |  33 +++++++++++++++
>>  tools/btmgmt.c | 129 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>
>
>
> Could you rebase the patches which change btmgmt since it had massive
> changes by commit 6523d168 ("tools/btmgmt: Port to use bt_shell"). And
> now, commands need to call properly the exit function on non-interactive
> mode.
>
>

Thanks for pointing it out. I have raised v2 after rebasing.

Thanks,
Jaganath
