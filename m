Return-Path: <cyrus@holtmann.org>
Message-ID: <5283506A.4090105@linux.intel.com>
Date: Wed, 13 Nov 2013 12:11:54 +0200
From: Ravi Kumar Veeramally <ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
To: Szymon Janc <szymon.janc@tieto.com>,
	Johan Hedberg <johan.hedberg@gmail.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH_v3 3/3] android/pan: Handle connection and control state
 notifications
References: <1384334727-25940-1-git-send-email-ravikumar.veeramally@linux.intel.com> <20131113093301.GB1749@x220.p-661hnu-f1> <52834A76.4050600@linux.intel.com> <1726751.Pm6h7gxZKd@uw000953>
In-Reply-To: <1726751.Pm6h7gxZKd@uw000953>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


On 11/13/2013 11:59 AM, Szymon Janc wrote:
> Hi,
>
>>>> +
>>>> +	switch (opcode) {
>>>> +	case HAL_EV_PAN_CONN_STATE:
>>>> +		handle_conn_state(buf);
>>>> +		break;
>>>> +	case HAL_EV_PAN_CTRL_STATE:
>>>> +		handle_ctrl_state(buf);
>>>> +		break;
>>>> +	default:
>>>> +		DBG("Unhandled callback opcode=0x%x", opcode);
>>>> +		break;
>>>> +	}
>>>>    }
>>> What I don't like about this is that you're not pushing the data length
>>> to the handler functions. If you did that the handler functions could:
>>>
>>> 	if (len < sizeof(*ev))
>>> 		return;
>>>
>>> Instead of return we could also just abort - what's the general policy
>>> on the HAL side regarding invalid data from the daemon? How does this
>>> relate to the work Szymon is doing to add proper checks for the IPC
>>> data? Is that only for the daemon side?
>>>
>>> Are we missing similar checks in other HALs too?
>>     Yes, we are not doing similar checks in other HALs
>> (hal-bluetooth/a2dp/hid/) too.
>>     Very few places in hal-bluetooth length is passing but validation is
>> not done.
>>     I will fix them all and send you the patch.
> As mentioned in my RFC, messages have very similar format and can be checked
> in single place using some common macros. I'm now working on addressing Johan
> comments in that RFC. As suggested I'm going to use tables of handlers instead
> switch-case and this should also allow to refactor current code to avoid
> switch-cases we currently have. Services will simply register own tables of
> handlers for service they implement. Idea is that check will be done in common
> place and then handlers will have form of  void handle_foo(struct foo *ev) with
> guarantee that passed command/event is memory size valid.
>
> Plan is to make this generic code use both by hal and daemon.
>
> So, I'm not sure if it makes much sense to fix passing buf+len to all handlers
> we have now.
>
> If you have other ideas for this please comment.
>
   Ok, good to know.
  Johan: Can you now apply my left over patch?

  Thanks,
  Ravi.
