Return-Path: <cyrus@holtmann.org>
Message-ID: <4D710F7D.6090905@codeaurora.org>
Date: Fri, 04 Mar 2011 08:12:45 -0800
From: Brian Gix <bgix@codeaurora.org>
MIME-Version: 1.0
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"par-gunnar.p.hjalmdahl@stericsson.com"
	<par-gunnar.p.hjalmdahl@stericsson.com>,
	"henrik.possung@stericsson.com" <henrik.possung@stericsson.com>
Subject: Re: [PATCH] Bluetooth: Add counter for not acked HCI commands
References: <1299003369-17901-1-git-send-email-andrzej.kaczmarek@tieto.com> <4D6D480E.7080908@codeaurora.org> <4D70DD01.2030003@tieto.com>
In-Reply-To: <4D70DD01.2030003@tieto.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On 3/4/2011 4:37 AM, Andrzej Kaczmarek wrote:
> Hi Brian,
>
> On 01.03.2011 20:25, Brian Gix wrote:
>> The problem you describe sounds like one I had to solve in the past, but
>> unfortunately, I think it may be a little more difficult to solve here.
>> This particular baseband appears to have an outstanding Cmd queue of
>> 2. It also appears to consume one of them for extended periods of time
>> when making requests of the remote device, and using the NOP
>> Cmd-Status-Event to inform the host that the slot is now free.
>>
>> As you are observing, the completion of the task (triggering additional
>> requests locally) overlaps with these NOP responses, giving a false
>> count to the host of available cmd slots.
>>
>> Personally, I consider this to be a baseband bug, which could have been
>> avoided by having a max outstanding queue of 1.
>
> This particular controller uses 1 credit for each command that is being
> processed and having max outstanding queue of 1 would make some
> scenarios impossible - consider authentication with
> HCI_Authentication_Request pending and other HCI command to be sent in
> parallel.
>

The adjustment I suggest doesn't disallow this.  I was having a 
theory-of-operation talk with a baseband guy once, and this is what he 
had to say:

The HCI interface is intended to be an interface that immediately 
responds to *every* command. The problem is that some commands are 
intended for the local baseband (and can be handled immediately) and 
others require interaction outside of the control of the local baseband, 
and take an indeterminate amount of time.

So two response mechanism were created:

Command    Immediate Rsp     Delayed Rsp
Cmd   -->  Cmd Complete Evt                (Cmds handled Locally)
Cmd   -->  Cmd Status Evt --> Cmplt Event  ("long" Async Cmds)

The HCI flow control is contained in both the Cmd-Complt-Evt and the 
Cmd-Status-Evt.

So it is assumed that both flow control response event types will be 
delivered immediately after the baseband receives them. Of course 
because of the communication link, these response are still asyncronous 
in most cases including the BlueZ case.

The baseband guy basically said that "the baseband" does not expect the 
next command until the host has processed the (immediate) response to 
the previous one. And that the (immediate) response to the previous one 
should be RXed in milliseconds at the most.

So I would always delay sending the next command until the prior 
commands CmdStatus or CmdCmplt has been received. This should work 
unless there is something seriously wrong with the baseband.


-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
