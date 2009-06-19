Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <2d5a2c100906190639i545e7666k2938966f79be74c3@mail.gmail.com>
References: <e5fc24930906181903u62c28da2s7f942611661663b4@mail.gmail.com>
	 <2d5a2c100906190639i545e7666k2938966f79be74c3@mail.gmail.com>
Date: Fri, 19 Jun 2009 18:52:48 -0500
Message-ID: <e5fc24930906191652w4082a382pb1e68ad4e57f4c56@mail.gmail.com>
Subject: Re: On A2DP frame transmissions
From: Jun <yanjunrockets@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Thank you very much for the info, Luiz. I'd like to improve channel
utilization by maximizing data payload of each base band transmission.
I guess a L2cap frame for a2dp is often shorter than a based band
frame such as DH5, unless there is explicit coordination between App
and baseband. I'd like to figure out if such coordination is existing,
doable, and its potential gain. Any comments or suggestions are
welcome.

Following the code you sent me, here is my guess of the flow (please
correct me if I'm wrong):
user space: (SBC encoder?) -> avdtp_send -> try_send -> send ->
kernel: (socket lib?) -> l2cap_do_send -> hci_send_acl -> skb_queue_tail
It seems that avdtp and l2cap have simple headers and re-grouping
frames looks like doable.
I couldn't find what's the caller of avdtp_send and l2cap_do_send, so
please let me know if I've missed anything.

Best,

Jun


On Fri, Jun 19, 2009 at 8:39 AM, Luiz Augusto von
Dentz<luiz.dentz@gmail.com> wrote:
> Hi,
>
> On Thu, Jun 18, 2009 at 11:03 PM, Jun<yanjunrockets@gmail.com> wrote:
>> Hi All,
>>
>> I'm new to BlueZ and I'd like to dynamically schedule A2DP frame
>> transmissions for a project. I did some research on BlueZ and so far I
>> feel hcidump and l2cap.c are most related. Due to the large code base,
>> could anyone please give me more directions on what to further look
>> at?
>>
>
> The protocol used by a2dp is avdtp which is currently implemented in
> userspace, you can start by looking here: addressed removed to get through the filter
>
> I you could disclose what this project is about this would help us
> giving you directions.
>
> --
> Luiz Augusto von Dentz
> Engenheiro de Computação
>



-- 
--
Mailto: yanjunrockets@gmail.com
