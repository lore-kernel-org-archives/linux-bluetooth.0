Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Prabhu Chawandi <foss.chaws@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: android/handsfree.c | Possible Fix | Review
Date: Wed, 01 Apr 2015 16:11:47 +0200
Message-ID: <1749491.DZ1N48qHzk@leonov>
In-Reply-To: <CAKafyqoaN+fQBH5hjqv6_+ZMt6_b7hGfF_2a6mKAngLF+PR_0w@mail.gmail.com>
References: <CAKafyqoaN+fQBH5hjqv6_+ZMt6_b7hGfF_2a6mKAngLF+PR_0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Prabhu,

On Wednesday 01 of April 2015 18:40:52 Prabhu Chawandi wrote:
> Hi,
> 
>   When we were testing handsfree we were seeing command is not being
> identified and when looked size was  sent zero when we set it as below
> it started working.
> 
> static const struct ipc_handler sco_handlers[] = {
>         /* SCO_OP_GET_FD */
> -        { bt_sco_get_fd, false, 0 }
> };
> 
> 
> static const struct ipc_handler sco_handlers[] = {
>         /* SCO_OP_GET_FD */
>  +       { bt_sco_get_fd, false, sizeof(struct sco_cmd_get_fd) }
> };

Yes, the fix is correct. Could you send a proper patch for it?
 
> one request -  have you documented anywhere the sequence of commands
> to test each profiles supported till now. if we get the the proper
> sequences we can validate much faster stabilising the code. Else we
> need to spend time in identifying the sequences.
> 
> So, if you have documented anywhere request you to share,

Those sequences are defined by android code (framework or multimedia) and are 
not really documented. You could find some suggestion if you look at our PTS 
testing documentation (android/pts-*.txt) where we do use haltest for tests. 

Note that if possible we prefer to use Android Framework for validation 
instead of haltest (which is mostly development tool).

-- 
BR
Szymon Janc
