Return-Path: <cyrus@holtmann.org>
To: Hemant Gupta <hemantgupta.ste@gmail.com>
Subject: Re: [RFC] mgmt: Add support for Passkey handling
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8;
 format=flowed
Date: Tue, 06 Dec 2011 08:58:53 +0100
From: Hendrik Sattler <post@hendrik-sattler.de>
Cc: Hemant Gupta <hemant.gupta@stericsson.com>,
	<linux-bluetooth@vger.kernel.org>,
	Naresh Gupta <naresh.gupta@stericsson.com>
In-Reply-To: <CACj007npMC+6EWOyNS24o1MvHBetjSXaiXc0HO0c_Z_dZgQADA@mail.gmail.com>
References: <1323085586-4415-1-git-send-email-hemant.gupta@stericsson.com>
 <b5e0b125ccef74762e3665620069daad@mail.hendrik-sattler.de>
 <CACj007npMC+6EWOyNS24o1MvHBetjSXaiXc0HO0c_Z_dZgQADA@mail.gmail.com>
Message-ID: <3200cc87bc0c571fdbedfc8fe49f13b1@mail.hendrik-sattler.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Am 05.12.2011 15:12, schrieb Hemant Gupta:
> On Mon, Dec 5, 2011 at 6:20 PM, Hendrik Sattler
> <post@hendrik-sattler.de>wrote:
>> Am 05.12.2011 12:46, schrieb Hemant Gupta:
>>> +static int mgmt_passkey_reply(int index, bdaddr_t *bdaddr, 
>>> uint32_t
>>> passkey)
>>> +{
>>> +       char buf[MGMT_HDR_SIZE + sizeof(struct
>>> mgmt_cp_user_passkey_reply)];
>>> +       struct mgmt_hdr *hdr = (void *) buf;
>>> +       size_t buf_len;
>>> +       char addr[18];
>>> +
>>> +       ba2str(bdaddr, addr);
>>> +       DBG("index %d addr %s passkey %06u", index, addr, passkey);
>>> +
>>> +       memset(buf, 0, sizeof(buf));
>>> +
>>> +       if (passkey == INVALID_PASSKEY) {
>>> +               struct mgmt_cp_user_passkey_neg_reply *cp;
>>> +
>>> +               hdr->opcode = 
>>> htobs(MGMT_OP_USER_PASSKEY_NEG_REPLY);
>>> +               hdr->len = htobs(sizeof(*cp));
>>> +               hdr->index = htobs(index);
>>> +
>>> +               cp = (void *) &buf[sizeof(*hdr)];
>>>
>>
>> By definition, that the same as:
>>   cp = (void *) (hdr + 1);
>> And you can do it in the same line as the definition of *cp.
>> I have tried to re-use the exisitng implementation in mgmtops.c. If 
>> you
>> look at the implementation of mgmt_pincode_reply(), you would find 
>> the
>> similar implementation. Are you suggesting that I should change the
>> existing implementation also, and prepare a patch accordingly or 
>> only
>> specific to this API ?

Maybe this is a possible implementation start (in C99):
static int mgmt_passkey_neg_reply(int index, bdaddr_t *bdaddr)
{
     struct {
         struct mgmt_hdr hdr;
         struct mgmt_cp_user_passkey_neg_reply cp;
     } __packed buf = {
         .hdr = {
             .opcode = htobs(MGMT_OP_USER_PASSKEY_NEG_REPLY),
             .len = htobs(sizeof(*buf.cp)),
             .index = htobs(index),
         },
         .cp = {
             ....
         },
     };
     /* write() and return */
     ....
}

No pointer casting or offset calculation, seperate functions for 
neg_reply and reply.
But maybe you are right and this should be not be done in your patch...

HS

