Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH v3 1/4] src/shared/att: Introduce struct bt_att.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAHrH25QZfx1AJZvAaMDEzhkBawWeapCugSOkhkcVH3fbwpNAhg@mail.gmail.com>
Date: Fri, 13 Jun 2014 11:10:51 +0200
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <FA65A4B0-E573-4557-831F-D1F96025C6EB@holtmann.org>
References: <1402364040-11502-1-git-send-email-armansito@chromium.org> <1402364040-11502-2-git-send-email-armansito@chromium.org> <8304B43A-6644-4766-B089-DB71F34A63EF@holtmann.org> <CAHrH25QZfx1AJZvAaMDEzhkBawWeapCugSOkhkcVH3fbwpNAhg@mail.gmail.com>
To: Arman Uguray <armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

>> I would call it att_request or something like that. Not really important since we can change that easily later. Just something to think about. I have to read through the rest of the patchset and it make more sense then, but right now att_send_op sounds are bit weird.
>> 
> 
> att_send_op sounds fine to me :P I don't like att_request since it
> might lead people to think that it represents ATT protocol requests
> only, while it represents requests, commands, responses, etc. (i.e. it
> represents ATT protocol "ops"). Though if you have a better sounding
> name in mind, then I'm all ears.

fair enough. Keep it as is. We can optimize the name later if it someone comes up with a better name.

>>> +struct bt_att *bt_att_ref(struct bt_att *att)
>>> +{
>>> +     /* TODO */
>>> +     return NULL;
>>> +}
>> 
>> I am normally not a big fan of adding empty functions to just fill them later. However it has the advantage of me seeing the big picture which is kinda nice.
>> 
>> <snip>
> 
> Yeah I did this to make the review easier for you. In the end, if you
> don't want to have this as a standalone patch in the tree, feel free
> to squash the first two patches while merging. I prefer to leave it as
> it is for review purposes.

Either way is fine with me. I would have it done differently by introducing basics like new, ref/unref, set_debug etc. and then refine it with the send and register one. Not mandatory to this merged however.

>>> +#define BT_ATT_ERROR_UNLIKELY                                0x0E
>>> +#define BT_ATT_ERROR_INSUFFICIENT_ENCRYPTION         0x0F
>>> +#define BT_ATT_ERROR_UNSUPPORTED_GROUP_TYPE          0x10
>>> +#define BT_ATT_ERROR_INSUFFICIENT_RESOURCES          0x11
>> 
>> these might be better placed in monitor/bt.h and we eventually move that include file to some other place. One alternate idea is to use src/shared/att_types.h and just include it from src/shared/att.h. I am open for suggestions here. What seems better.
>> 
> 
> I like the idea of having a src/shared/att_types.h. All the structures
> that are defined in monitor/bt.h are packed and seem like they are
> meant to be sent over the wire, whereas the structs defined in att.h
> aren't: some of them have fields for variable length arrays and the
> PDU encoding is handled internally. So, I don't know if they really
> belong there, though I can see why it may make sense to include these
> in monitor/bt.h. In the end it's up to you.

Start out with src/shared/att_types.h and then we go from there. Moving defines and structs internally round is easy enough that we do not have to worry to much about it at the moment.

For the packed structs, you need them if you use them to access data that comes in from the fd. You need to worry about alignment and the only way to ensure this for wire protocols is packed structs or unaligned access helpers.

>>> +void bt_att_set_auth_signature(struct bt_att *att, uint8_t signature[12]);
>> 
>> This might not work. We need the signature resolving key for each direction. And why did you include it as uint8_t[12]. They overall key is 16 octets.
>> 
> 
> Hmm, according to the spec the "Optional authentication signature for
> the Attribute Opcode and Attribute Parameters" is 12 octets in length.
> See "Core v4.1, Vol 3, Part F, Section 3.3.1, Table 3: Format of
> Attribute PDU", and tell me what I'm missing. Or are you suggesting
> that we calculate the authentication signature in bt_att? My idea was
> that the calculation of the signature and resolving (for incoming
> signed requests) would be handled by an upper layer.

We have to calculate the signature brand new anyway since it is generated over the actual PDU. So yes, lets store the master + slave signature keys in bt_att and handle the signature generation and verification internally.

>> I think this should be bt_att_set_signing_key() and bt_att_resolving_key() and once they are set we can internally drop signed writes that do not fit. And we can also automatically sign if the signed write opcode is used. In addition skip the signed write and just use a normal write if we are already encrypted.
>> 
> 
> If the authentication signature is set, I think bt_att should always
> try to sign if the opcode has the signed bit set. I think it's cleaner
> if bt_att has no knowledge of whether or not the underlying connection
> is encrypted; if the higher layer knows that it's encrypted, they
> should just pass the correct opcode to bt_att_send.

Lets then start it that. However I want to code to automatically also verify writes that have been signed and response with a proper error message if they do not match. However in that case we need to know the underlying security of the link and reject the signed write since it is not allowed.

Regards

Marcel

