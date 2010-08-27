Return-Path: <cyrus@holtmann.org>
Date: Fri, 27 Aug 2010 11:06:15 -0700 (PDT)
From: Mat Martineau <mathewm@codeaurora.org>
To: David Vrabel <david.vrabel@csr.com>
cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	rshaffer@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/1] Bluetooth: Add socket option definitions for AMP
In-Reply-To: <4C6BE410.1020505@csr.com>
Message-ID: <alpine.DEB.2.00.1008271105050.22778@linux-sea-02>
References: <1282086426-8423-1-git-send-email-mathewm@codeaurora.org> <4C6BE410.1020505@csr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


David -

On Wed, 18 Aug 2010, David Vrabel wrote:

> Mat Martineau wrote:
>> This adds a new BT_AMP socket option to control the use of AMP channels.
>> It is for use with the SOL_BLUETOOTH option level on L2CAP sockets.
>>
>> Available option values are defined as:
>>
>> [lots of nice documentation]
>
> Why is none of this documentation in the code?
>
> I believe we also agreed that this policy could be changed at any point
> in the life time of the channel so this should be documented as well.
>
>> +#define BT_AMP		8
>
> Suggest BT_AMP_POLICY, BT_AMP_POLICY_REQUIRE_BR_EDR etc.  Just in case
> there are other AMP related socket options in the future.
>
>> +#define BT_AMP_REQUIRE_BR_EDR	0
>> +#define BT_AMP_PREFER_AMP	1
>> +#define BT_AMP_PREFER_BR_EDR	2

Thanks for the helpful feedback - I'll add the documentation, adjust 
the names, and repost.

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

