Return-Path: <cyrus@holtmann.org>
Message-ID: <4EDD1482.3000306@codeaurora.org>
Date: Mon, 05 Dec 2011 10:59:14 -0800
From: Brian Gix <bgix@codeaurora.org>
MIME-Version: 1.0
To: Hendrik Sattler <post@hendrik-sattler.de>
CC: Hemant Gupta <hemant.gupta@stericsson.com>,
	linux-bluetooth@vger.kernel.org,
	Naresh Gupta <naresh.gupta@stericsson.com>,
	Hemant Gupta <hemantgupta.ste@gmail.com>
Subject: Re: [RFC] mgmt: Add support for Passkey handling
References: <1323085586-4415-1-git-send-email-hemant.gupta@stericsson.com> <b5e0b125ccef74762e3665620069daad@mail.hendrik-sattler.de>
In-Reply-To: <b5e0b125ccef74762e3665620069daad@mail.hendrik-sattler.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hendrik,

On 12/5/2011 4:50 AM, Hendrik Sattler wrote:
> Am 05.12.2011 12:46, schrieb Hemant Gupta:
[...]
>> +static int mgmt_passkey_reply(int index, bdaddr_t *bdaddr, uint32_t
>> passkey)
>> +{
>> + char buf[MGMT_HDR_SIZE + sizeof(struct mgmt_cp_user_passkey_reply)];
>> + struct mgmt_hdr *hdr = (void *) buf;
>> + size_t buf_len;
>> + char addr[18];
>> +
>> + ba2str(bdaddr, addr);
>> + DBG("index %d addr %s passkey %06u", index, addr, passkey);
>> +
>> + memset(buf, 0, sizeof(buf));
>> +
>> + if (passkey == INVALID_PASSKEY) {
>> + struct mgmt_cp_user_passkey_neg_reply *cp;
>> +
>> + hdr->opcode = htobs(MGMT_OP_USER_PASSKEY_NEG_REPLY);
>> + hdr->len = htobs(sizeof(*cp));
>> + hdr->index = htobs(index);
>> +
>> + cp = (void *) &buf[sizeof(*hdr)];
>
> By definition, that the same as:
> cp = (void *) (hdr + 1);
> And you can do it in the same line as the definition of *cp.
>
>> + bacpy(&cp->bdaddr, bdaddr);
>> +
>> + buf_len = sizeof(*hdr) + sizeof(*cp);
>> + } else {
>> + struct mgmt_cp_user_passkey_reply *cp;
>> +
>> + hdr->opcode = htobs(MGMT_OP_USER_PASSKEY_REPLY);
>> + hdr->len = htobs(sizeof(*cp));
>> + hdr->index = htobs(index);
>> +
>> + cp = (void *) &buf[sizeof(*hdr)];
>> + bacpy(&cp->bdaddr, bdaddr);
>> + cp->passkey = htobl(passkey);
>> +
>> + buf_len = sizeof(*hdr) + sizeof(*cp);
>> + }
>
> Ever wondered why if and else look almost the same? They should be
> merged as far as possible.

I generally agree with this statement, but think it doesn't really apply 
here.  Since the definition of "cp" is different between the IF and the 
ELSE, the generated code is quite different, even though they look the 
same:  The sizeof(*cp) is different, the MGMT_OP Opcode is different, 
and the structure members might be named the same, but since they are in 
different structures, they are in fact different as well.

The only thing that could be safely "shared" is the hdr->index, I think.


-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
