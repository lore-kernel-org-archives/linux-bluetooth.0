Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <24B5C219-EF6D-4F94-AAE6-ADA64C410934@holtmann.org>
References: <1402364040-11502-1-git-send-email-armansito@chromium.org>
	<1402364040-11502-4-git-send-email-armansito@chromium.org>
	<24B5C219-EF6D-4F94-AAE6-ADA64C410934@holtmann.org>
Date: Thu, 12 Jun 2014 17:56:40 -0700
Message-ID: <CAHrH25QLoPm4HYaMtXehC1aBCetvRK_vxM9zMBKmb=oYXBiCjw@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] src/shared/att: Implement write handler and bt_att_send.
From: Arman Uguray <armansito@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

> I see. Just use *((uint8_t *) op->pdu) = op->opcode here. If the pattern of adding opcode plus some extra data repeats, then we might should consider a define or a simpler att_hdr struct.
>
>         struct att_hdr {
>                 uint8_t opcode;
>                 uint8_t data[0];
>         } __packed;
>
> You need to play a little bit with your options here and see what turns into most readable code.
>

I'll just do the simple cast and assign for now. I might add a hdr
struct if the cast becomes too tedious to type.

> Is this possible at all? I am just too lazy to open the spec and check, but you might want to give an example n which opcode has this.
>

WRITE_RSP and HANDLE_VAL_CONF are two examples. Will mention one of
the in the comments.

>> +     /* TODO: If the opcode has the "signed" bit set, make sure that the
>> +      * resulting PDU contains the authentication signature. Return an error,
>> +      * if the provided parameters structure is such that it leaves no room
>> +      * for an authentication signature in the PDU.
>> +      */
>
> I want us to handle this in the background. Just make sure we allocate enough memory.
>

Yeah, for now I'm leaving a TODO. I'll revisit it while implementing
SIGNED_WRITE_CMD.

> I feel a bit uneasy about this queue type thing. Maybe I am just not getting it usefulness. You need to explain this to me a bit in detail.
>

Totally useless. Removed it.

Cheers,
Arman
