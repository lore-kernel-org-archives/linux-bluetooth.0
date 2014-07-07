Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH 01/10] shared/att: Implement outgoing "Find Information" request/response.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <2356277.6pWY6Dqj64@uw000953>
Date: Mon, 7 Jul 2014 10:44:59 +0200
Cc: Arman Uguray <armansito@chromium.org>,
	linux-bluetooth@vger.kernel.org
Message-Id: <82D1448D-D71F-4D39-9BDA-189DC6BDDC99@holtmann.org>
References: <1403824457-22461-1-git-send-email-armansito@chromium.org> <1403824457-22461-2-git-send-email-armansito@chromium.org> <3C1DD48A-E6D0-4F6C-BD38-3F8AB023663E@holtmann.org> <2356277.6pWY6Dqj64@uw000953>
To: Szymon Janc <szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

>>> This patch add support for "Find Information" requests sent via
>>> bt_att_send and the corresponding response.
>>> ---
>>> src/shared/att.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>>> 1 file changed, 52 insertions(+)
>>> 
>>> diff --git a/src/shared/att.c b/src/shared/att.c
>>> index 57f887e..22dd471 100644
>>> --- a/src/shared/att.c
>>> +++ b/src/shared/att.c
>>> @@ -165,6 +165,30 @@ static bool encode_mtu_req(struct att_send_op *op, const void *param,
>>> 	return true;
>>> }
>>> 
>>> +static bool encode_find_info_req(struct att_send_op *op, const void *param,
>>> +						uint16_t length, uint16_t mtu)
>>> +{
>>> +	const struct bt_att_find_info_req_param *p = param;
>>> +	const uint16_t len = 5;
>>> +
>>> +	if (length != sizeof(*p))
>>> +		return false;
>>> +
>>> +	if (len > mtu)
>>> +		return false;
>>> +
>>> +	op->pdu = malloc(len);
>>> +	if (!op->pdu)
>>> +		return false;
>>> +
>>> +	((uint8_t *) op->pdu)[0] = op->opcode;
>>> +	put_le16(p->start_handle, ((uint8_t *) op->pdu) + 1);
>>> +	put_le16(p->end_handle, ((uint8_t *) op->pdu) + 3);
>> 
>> this ptr + x operation is actually defined on void pointers. At least with gcc. The casting should not be needed.
> 
> And why not just have pdu defined as uint8_t * in struct att_send_op?

I want void pointers there. If you want an unint8_t * then cast it into a local pointer. Or cast it into a packed struct matching your payload.

> From what I see in code (and this patchset) it is always used as array of
> bytes, not a data pointer.

And over time it will change to using packed structs and the direct uin8_t access will go away step by step. So no need to overthink this.

Regards

Marcel

