Return-Path: <cyrus@holtmann.org>
Message-ID: <4D70DD01.2030003@tieto.com>
Date: Fri, 4 Mar 2011 13:37:21 +0100
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
To: Brian Gix <bgix@codeaurora.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"par-gunnar.p.hjalmdahl@stericsson.com"
	<par-gunnar.p.hjalmdahl@stericsson.com>,
	"henrik.possung@stericsson.com" <henrik.possung@stericsson.com>
Subject: Re: [PATCH] Bluetooth: Add counter for not acked HCI commands
References: <1299003369-17901-1-git-send-email-andrzej.kaczmarek@tieto.com> <4D6D480E.7080908@codeaurora.org>
In-Reply-To: <4D6D480E.7080908@codeaurora.org>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

On 01.03.2011 20:25, Brian Gix wrote:
> The problem you describe sounds like one I had to solve in the past, but
> unfortunately, I think it may be a little more difficult to solve here.
>    This particular baseband appears to have an outstanding Cmd queue of
> 2.  It also appears to consume one of them for extended periods of time
> when making requests of the remote device, and using the NOP
> Cmd-Status-Event to inform the host that the slot is now free.
>
> As you are observing, the completion of the task (triggering additional
> requests locally) overlaps with these NOP responses, giving a false
> count to the host of available cmd slots.
>
> Personally, I consider this to be a baseband bug, which could have been
> avoided by having a max outstanding queue of 1.

This particular controller uses 1 credit for each command that is being 
processed and having max outstanding queue of 1 would make some 
scenarios impossible - consider authentication with 
HCI_Authentication_Request pending and other HCI command to be sent in
parallel.

Since spec does not specify how credits should be used so I don't 
consider this a baseband bug, more like a design decision.

> Note 1:
> My biggest problem with your patch is the point marked above.  I agree
> that it would solve the problem you observed, and your overall analysis
> of the situation, but because of the way this particular baseband is
> operating, and the way I have seen other basebands operate in the past,
> I think this decision point as to when to send the next command is
> incorrect.
>
> A flaw in the HCI command handshaking paradigm is that a baseband can
> decide to take away or not take away one of these slots, and give you
> notification asynchronously. I have seen basebands with presumptively
> two slots return a cmd status with ncmd 0 when getting a remote device
> name, if no ACL connection was currently established, for example.
>
> The safest way I have seen this problem handled is to force a
> psuedo-single-threading of commands on the system by NEVER sending a
> command while another command has not yet received it's Cmd-Status or
> Cmd-Cmplt event. In other words, instead of the test for cmd_cnt>
> cmd_not_acked, I would simply make into cmd_cnt&&  !cmd_not_acked.

I never saw baseband which behaves as you described so I assumed that 
each command should take no more that 1 credit. But again, since spec is 
not very specific at this point perhaps this assumption was wrong, so 
making this psuedo-single-threading as you described sounds reasonable 
to me.

>>    			atomic_dec(&hdev->cmd_cnt);
>> +			atomic_inc(&hdev->cmd_not_ack);
> [...]
>
> Also, I am not sure this means what you may intend it to mean. I think
> that this is intended to do both of these operations "together
> atomically", but that as written, it is possible for an interruption to
> occur between the two operations.

No, I didn't mean to do both of these operations together atomically. I 
followed scheme to update cmd_cnt atomically. Honestly, I'm not sure why 
cmd_cnt is updated atomically while other counters are not, it does not 
guarantee us proper updating of this value - see hci_cmd_task for example.

Perhaps atomic functions should be stripped from cmd_cnt or code should 
be updated more thoroughly to lock access to counters properly. I'll be 
glad to hear opinion on this as well.

BR,
Andrzej
