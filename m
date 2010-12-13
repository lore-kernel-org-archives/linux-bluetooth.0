Return-Path: <cyrus@holtmann.org>
Message-ID: <4D069115.7070509@codeaurora.org>
Date: Mon, 13 Dec 2010 13:33:09 -0800
From: Brian Gix <bgix@codeaurora.org>
MIME-Version: 1.0
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
CC: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi,
	rshaffer@codeaurora.org
Subject: Re: [PATCH 1/1] Support for reading long Characteristic Values.
References: <1292261066-28100-1-git-send-email-bgix@codeaurora.org> <1292261066-28100-3-git-send-email-bgix@codeaurora.org> <20101213183951.GB7549@eris> <4D067A6C.6080404@codeaurora.org> <20101213203336.GC7549@eris>
In-Reply-To: <20101213203336.GC7549@eris>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On 12/13/2010 12:33 PM, Vinicius Costa Gomes wrote:
> On 11:56 Mon 13 Dec, Brian Gix wrote:
> [trimmed]
 >
 >>>> +
 >>>> +	if (ret_val != 0)
 >>>> +		return;
 >>>> +
 >>>> +	status = ATT_ECODE_INSUFF_RESOURCES;
 >>>> +
 >>>> +done:
 >>>> +	long_read->func(status, res_pdu, res_len, long_read->user_data);
 >>>
 >>> If g_attrib_send() fails, load_read->result_data may be leaking here.
>>
>> Is there no guarantee that the GAttribResultFunc parameter will be
>> invoked if there is a non-Zero return value from g_attrib_send?
>>
>> If there is paths that could result in a non-response (abnormal link
>> termination?) then you are correct, and I will need to rethink clean-up.
>
> The case I was referring was when g_attrib_send() cannot allocate memory for
> the command.
>

I don't think this is an issue, because if g_attrib_send() cannot 
allocate memory, then it will return a 0, and fall through to the 
completion and clean-up. However, I like the idea of doing all clean-up 
in the destructor anyway, which resolves the memory leak potential.


>>>  [...]
>> Also:
>> If we intend to use the ID of the (original) command to cancel the GATT
>> procedure, I propose the following:
>>
>> Compound GATT procedure such as the Read Long procedure that I am
>> implementing, should save the original ID returned by g_attrib_send in
>> the nested user_data structure such as I have done. When subsequent ATT
>> commands are sent as part of the same GATT procedure, the new command
>> shall be assigned the same ID as the original.  This could be done with
>> a function in gattrib.c with the prototype:
>>
>> g_attrib_set_id(GAttrib *attrib, guint old_id, guint new_id);
>>
>> This would allow the upper layer to cancel the entire GATT procedure,
>> even if it is partially completed.
>>
>> This same methodology could then be applied to long writes, and other
>> compound GATT procedures.
>>
>> What do you think?
>
> Sounds good, I just don't know about messing with the commands id's,
> maybe having some thing like command groups.
>
> For example, adding these funtions:
>
> guint g_attrib_send_full(GAttrib *attrib, guint8 opcode, const guint8 *pdu,
> 				guint16 len, guint group, GAttribResultFunc func,
> 				gpointer user_data, GDestroyNotify notify);
>
> gboolean g_attrib_cancel_group(GAttrib *attrib, guint group);
>
> How do this look?
>

My biggest objection would be that to go this route, I think we would 
want to extend this "command group" to all GATT procedures, and not just 
the ones known or suspected to be Compound.  I don't think that 
canceling a "Characteristic Value Read" procedure should be any 
different (or use a different parameter type) than canceling "Find 
Primary Service", for example.

Do you think everything in gatt.c should use these "command groups"? 
And if so, by what mechanism would the "group number" remain unique?

It doesn't seem to me to be such a horrible overloading of the id. I do 
see that when a cancel is called, that it is important that only one 
command with that ID is in the queue. However, this reclaimation/reuse 
of the old ID would only occur after the prior instance is in the 
process of being destroyed. The danger I suppose would be the misuse of 
this renumbering capability by an entity other than gatt.c.


I'm sorry this is getting long winded BUT:

This also highlights the inherent danger of allowing multiple Requests 
to be queued up. If are to allow a Read-Value, Write-Value, Read-Value 
sequence of commands to be enqueued onto the attrib->queue, it will be 
impossible to correctly implement any of the compound Read or Write 
commands, because the subsequent "Read-Blob" would be added to the end 
of the queue, and the read could be split around a write.  GATT/ATT was 
always intended to be a single outstanding request (and procedure) at a 
time kind of protocol, and having a FIFO attrib->queue subverts that intent.

To get compound GATT procedures to work properly (while maintaining the 
Attrib queuing mechanism) we may need to restructure gattrib.c such that 
we can add the subsequent commands to the *head* of the queue, and not 
call wake_up_sender in the received_data() function until after the 
cmd->func() has been invoked, and given the opportunity to "continue the 
current procedure".

>
> Cheers,


-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
