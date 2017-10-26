Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZJE_zN1uZSbTvNcNAZjOKwcczLJkRkHRxr9Mh38gZ=PWg@mail.gmail.com>
References: <2c74601a-9a6f-6dd3-5bf4-a1988ae21dc3@jp.fujitsu.com> <CABBYNZJE_zN1uZSbTvNcNAZjOKwcczLJkRkHRxr9Mh38gZ=PWg@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 26 Oct 2017 17:00:35 +0300
Message-ID: <CABBYNZJpHK_DpzF=y3NY2Uy_B0j+x92Z9QuGb1FK9kes80LWLA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 0/8] Add argument texts to help command
To: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Eramoto,

On Mon, Oct 23, 2017 at 2:41 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Eramoto,
>
> On Mon, Oct 23, 2017 at 11:05 AM, ERAMOTO Masaya
> <eramoto.masaya@jp.fujitsu.com> wrote:
>> In case first running a command on btmgmt, users may need to fail running
>> a command or run a command with the option --help since the command help
>> does not display whether or not any argument is needed.
>>
>> These patches include to add argument texts to output of the command help.
>>
>> ERAMOTO Masaya (8):
>>   tools/btmgmt: Fix inconsistency of usages and options
>>   tools/btmgmt: Fix segfault in interactive mode
>>   tools/btmgmt: Fix segfault with remote-oob --help
>>   tools/btmgmt: Add argument texts to help command
>>   tools/btmgmt: Replace with common usage function
>>   tools/btmgmt: Refactor for functions to parse setting
>>   tools/btmgmt: Change help message of some commands to usage
>>   tools/btmgmt: Use cmd_usage() for select command
>>
>>  tools/btmgmt.c | 524 ++++++++++++++++++++++++++++++---------------------------
>>  1 file changed, 278 insertions(+), 246 deletions(-)
>>
>> --
>> 2.7.4
>
> I will check the fixes, for the refactoring of the shell-like
> functions Id really wait for bt_shell so we can make our command line
> tools behave more consistently.

I haven't heard from the bt_shell so decided to applied this as they
are, thanks.

-- 
Luiz Augusto von Dentz
