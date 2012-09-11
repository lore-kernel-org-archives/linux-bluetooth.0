Return-Path: <cyrus@holtmann.org>
Date: Tue, 11 Sep 2012 13:23:16 -0700 (PDT)
From: Mat Martineau <mathewm@codeaurora.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFCv1 01/15] Bluetooth: Set Exended Flowspec flag for HS chan
In-Reply-To: <20120911081506.GB2597@aemeltch-MOBL1>
Message-ID: <alpine.DEB.2.02.1209111322220.3754@mathewm-linux>
References: <1346766274-21612-1-git-send-email-Andrei.Emeltchenko.news@gmail.com> <1346766274-21612-2-git-send-email-Andrei.Emeltchenko.news@gmail.com> <alpine.DEB.2.02.1209101647520.2859@mathewm-linux> <20120911081506.GB2597@aemeltch-MOBL1>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Andrei -

On Tue, 11 Sep 2012, Andrei Emeltchenko wrote:

> Hi Mat,
>
> On Mon, Sep 10, 2012 at 04:49:36PM -0700, Mat Martineau wrote:
>>
>> Andrei -
>>
>> On Tue, 4 Sep 2012, Andrei Emeltchenko wrote:
>>
>>> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>>>
>>> For AMP we always assume EFS L2CAP option.
>>>
>>> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>>> ---
>>> include/net/bluetooth/l2cap.h |    2 ++
>>> net/bluetooth/l2cap_core.c    |    7 ++++++-
>>> 2 files changed, 8 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
>>> index 161be83..3ec8679 100644
>>> --- a/include/net/bluetooth/l2cap.h
>>> +++ b/include/net/bluetooth/l2cap.h
>>> @@ -508,6 +508,8 @@ struct l2cap_chan {
>>> 	__u32		remote_acc_lat;
>>> 	__u32		remote_flush_to;
>>>
>>> +	__u8		ctrl_id;
>>> +
>>
>> How about "remote_amp_id" instead of ctrl_id?  The channel move code
>> tracks local_amp_id.
>> Why does the remote controller id need to be
>> tracked?
>
> I think you are right, I think it shall be local AMP controller id. So we
> can keep this name ctrl_id for local one or do you think local_amp_id is
> better?

local_amp_id seems better to me.  I used that in my patch set posted 
today (patch 01/20).

--
Mat Martineau

The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
