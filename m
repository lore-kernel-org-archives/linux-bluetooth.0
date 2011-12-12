Return-Path: <cyrus@holtmann.org>
Message-ID: <4EE63BC8.5020409@codeaurora.org>
Date: Mon, 12 Dec 2011 09:37:12 -0800
From: Brian Gix <bgix@codeaurora.org>
MIME-Version: 1.0
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
CC: linux-bluetooth@vger.kernel.org,
	Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: [PATCH 1/8] Bluetooth: Add structures for the new LTK exchange
 messages
References: <1323218892-15785-1-git-send-email-vinicius.gomes@openbossa.org> <1323218892-15785-2-git-send-email-vinicius.gomes@openbossa.org> <4EDFA4C6.4030201@codeaurora.org> <20111212130750.GA14194@samus>
In-Reply-To: <20111212130750.GA14194@samus>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius, Johan,

On 12/12/2011 5:07 AM, Vinicius Costa Gomes wrote:
> Hi Brian,
>
> On 09:39 Wed 07 Dec, Brian Gix wrote:
>> >  Hi Vinicius,
>> >
>> >  On 12/6/2011 4:48 PM, Vinicius Costa Gomes wrote:
>>> >  >This defines two in the kernel side of BlueZ two new messages, one
>>> >  >event that will inform userspace that a new Long Term Key was
>>> >  >exchanged and one that will allow userspace to load LTKs into
>>> >  >the kernel.
>>> >  >
>>> >  >Acked-by: Marcel Holtmann<marcel@holtmann.org>
>>> >  >Signed-off-by: Vinicius Costa Gomes<vinicius.gomes@openbossa.org>
>>> >  >---
>>> >  >    include/net/bluetooth/mgmt.h |   21 +++++++++++++++++++++
>>> >  >    1 files changed, 21 insertions(+), 0 deletions(-)
>>> >  >
>>> >  >diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
>>> >  >index 3b68806..0f100fa9 100644
>>> >  >--- a/include/net/bluetooth/mgmt.h
>>> >  >+++ b/include/net/bluetooth/mgmt.h
>>> >  >@@ -264,6 +264,21 @@ struct mgmt_cp_user_passkey_neg_reply {
>>> >  >    	bdaddr_t bdaddr;
>>> >  >    } __packed;
>>> >  >
>>> >  >+struct mgmt_ltk_info {
>>> >  >+	bdaddr_t bdaddr;
>>> >  >+	__u8 pin_len;
>>> >  >+	__u8 enc_size;
>>> >  >+	__le16 ediv;
>>> >  >+	__u8 rand[8];
>>> >  >+	__u8 val[16];
>>> >  >+} __packed;
>> >
>> >  I think we definitely want to store the auth level (octet) that was
>> >  used to generate this key and/or the sec_level. Some profiles may
>> >  require MITM (high sec_level) and from this key definition, there is
>> >  no way to tell if it is Medium (no MITM) or High.
>> >
> Yeah, I was thinking about infering the security level using the pin_len
> field, but that assumption breaks once we have OOB. I will add this
> field.
>


Sorry I was not on the IRC when you were discussing the SMP-LTK 
communication between Kernel and BluZ, but I was copied on the 
conversation from a colleague.

I think everything you guys said was sound.  An "authenticated" field 
that is simply 0 or 1 should be sufficient for preserving the security 
level that the key represents.

Also, I have looked at Hemants patch and it looks correct.   It is 
suitable for either SSP passkey request and entry, or SMP passkey 
request and entry.

It should have no impact on how we handle LTK communication and storage.



-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
