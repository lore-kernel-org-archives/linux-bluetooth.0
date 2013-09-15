Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH v3 2/8] Bluetooth: Fix L2CAP command reject reason
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20130915063401.GB22996@x220.p-661hnu-f1>
Date: Sun, 15 Sep 2013 11:05:40 -0500
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <44D3C0DF-040A-49F8-9140-33BCAE2816B7@holtmann.org>
References: <1379179711-16436-1-git-send-email-johan.hedberg@gmail.com> <1379179711-16436-3-git-send-email-johan.hedberg@gmail.com> <036A3F37-5735-49B4-957A-8A5B1EE11680@holtmann.org> <20130915063401.GB22996@x220.p-661hnu-f1>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

>>> There are several possible reason codes that can be sent in the command
>>> reject L2CAP packet. Before this patch the code has used a hard-coded
>>> single response code ("command not understood"). This patch adds a
>>> helper function to map the return value of an L2CAP handler function to
>>> the correct command reject reason.
>>> 
>>> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
>>> ---
>>> net/bluetooth/l2cap_core.c | 22 ++++++++++++++++++----
>>> 1 file changed, 18 insertions(+), 4 deletions(-)
>>> 
>>> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
>>> index b3bb7bc..83acb28 100644
>>> --- a/net/bluetooth/l2cap_core.c
>>> +++ b/net/bluetooth/l2cap_core.c
>>> @@ -5294,6 +5294,20 @@ static inline int l2cap_le_sig_cmd(struct l2cap_conn *conn,
>>> 	}
>>> }
>>> 
>>> +static u16 l2cap_err_to_reason(int err)
>> 
>> what we could to is return __le16 here. And then keep using
>> __constant_cpu_to_le16.
> 
> I was mainly trying to follow the principle of using host endianness
> until the very moment when we actually encode into the protocol struct.
> However, I agree that we could be more pragmatic here since the only
> users of this function are places where we're directly encoding into the
> response PDU.

the thing is that within the kernel you can nicely mark the endian of the return value with __le16. So tools like sparse will warn you if you mess it up.

>>> +{
>>> +	switch (err) {
>>> +	case -EFAULT:
>>> +		return L2CAP_REJ_INVALID_CID;
>>> +	case -EMSGSIZE:
>>> +		return L2CAP_REJ_MTU_EXCEEDED;
>>> +	case -EINVAL:
>>> +	case -EPROTO:
>>> +	default:
>>> +		return L2CAP_REJ_NOT_UNDERSTOOD;
>>> +	}
>>> +}
>> 
>> Is there really a point in listing EINVAL and EPROTO here.
> 
> I thought it would make it clear which error codes are recommended for
> parsing errors but I can remove them and just rely on default.

I am fine keeping them. Just asking.

Regards

Marcel

