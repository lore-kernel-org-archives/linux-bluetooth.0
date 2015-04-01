Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1749491.DZ1N48qHzk@leonov>
References: <CAKafyqoaN+fQBH5hjqv6_+ZMt6_b7hGfF_2a6mKAngLF+PR_0w@mail.gmail.com>
	<1749491.DZ1N48qHzk@leonov>
Date: Wed, 1 Apr 2015 20:29:25 +0530
Message-ID: <CAKafyqpUNyBJz673P0_B8T09Bp3Hr7OWptVZNXK5QLomk0xTfQ@mail.gmail.com>
Subject: Re: android/handsfree.c | Possible Fix | Review
From: Prabhu Chawandi <foss.chaws@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

  Sure, I will send the patch soon, I have to pull 5.30 as I am
currently on 5.28.

with sco read, I was not able to initiate read at all, when i debug it
is always return at the same point where I had pointed a crash couple
of days ago in hal-sco,c

I get channel number allocated but I am not able to understand why I
am getting frame size as zero.. please through some light on it.

        if (!frame_size)
                return -1;  ==>

        frame_num = bytes / frame_size;
        input_frame_num = frame_num;


 Actually, we are trying on linux host, we are not using the Android framework.
May be if you have some free time (Not sure :(), please capture the
sequences, one profile at time. sorry if I am asking fore more !

manyThanks,
Prabhu



On Wed, Apr 1, 2015 at 7:41 PM, Szymon Janc <szymon.janc@tieto.com> wrote:
> Hi Prabhu,
>
> On Wednesday 01 of April 2015 18:40:52 Prabhu Chawandi wrote:
>> Hi,
>>
>>   When we were testing handsfree we were seeing command is not being
>> identified and when looked size was  sent zero when we set it as below
>> it started working.
>>
>> static const struct ipc_handler sco_handlers[] = {
>>         /* SCO_OP_GET_FD */
>> -        { bt_sco_get_fd, false, 0 }
>> };
>>
>>
>> static const struct ipc_handler sco_handlers[] = {
>>         /* SCO_OP_GET_FD */
>>  +       { bt_sco_get_fd, false, sizeof(struct sco_cmd_get_fd) }
>> };
>
> Yes, the fix is correct. Could you send a proper patch for it?
>
>> one request -  have you documented anywhere the sequence of commands
>> to test each profiles supported till now. if we get the the proper
>> sequences we can validate much faster stabilising the code. Else we
>> need to spend time in identifying the sequences.
>>
>> So, if you have documented anywhere request you to share,
>
> Those sequences are defined by android code (framework or multimedia) and are
> not really documented. You could find some suggestion if you look at our PTS
> testing documentation (android/pts-*.txt) where we do use haltest for tests.
>
> Note that if possible we prefer to use Android Framework for validation
> instead of haltest (which is mostly development tool).
>
> --
> BR
> Szymon Janc
