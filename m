Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20130307071953.GA28958@x220>
References: <1362613517-1761-1-git-send-email-andre.guedes@openbossa.org>
	<1362613517-1761-3-git-send-email-andre.guedes@openbossa.org>
	<20130307071527.GB28536@x220>
	<20130307071953.GA28958@x220>
Date: Thu, 7 Mar 2013 13:38:40 -0300
Message-ID: <CACJA=fXoWXi8RB6c1Z6P9hC3mdUbxBOvnb9E2_P7G5M9EbSfVQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] Bluetooth: HCI request error handling
From: Andre Guedes <andre.guedes@openbossa.org>
To: Andre Guedes <andre.guedes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Thu, Mar 7, 2013 at 4:19 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi,
>
> On Thu, Mar 07, 2013, Johan Hedberg wrote:
>> > @@ -2533,6 +2543,7 @@ int hci_req_add(struct hci_request *req, u16 opcode, u32 plen, void *param)
>> >     skb = hci_prepare_cmd(hdev, opcode, plen, param);
>> >     if (!skb) {
>> >             BT_ERR("%s no memory for command", hdev->name);
>> > +           req->error = true;
>> >             return -ENOMEM;
>> >     }
>>
>> If the error is already set then I don't think hci_req_add should even
>> be attempting to add another command to the queue. So you should be
>> checking for a set error early in the function and just return if it's
>> set.
>
> Nevermind. I saw that you have this in the last patch of this set. You
> could probably merge that into this patch though.

Since at this point hci_req_add is not returning void yet, if I merge
the last patch I will have to return a value in case req->err is set.
However, The next patch makes hci_req_add returning void so that value
will be removed anyway.

Regards,

Andre
