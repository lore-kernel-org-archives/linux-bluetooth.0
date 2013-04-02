Return-Path: <cyrus@holtmann.org>
Message-id: <FA262637A35F4111AD38E20426ADD57A@sisodomain.com>
From: Jaganath Kanakkassery <jaganath.k@samsung.com>
To: Marcel Holtmann <marcel@holtmann.org>,
 Jaganath Kanakkassery <jaganath.k@samsung.com>
Cc: linux-bluetooth@vger.kernel.org, Chan-yeol Park <chanyeol.park@samsung.com>
References: <1364810354-2121-1-git-send-email-jaganath.k@samsung.com>
 <2C07ED0D-CC72-497B-AB67-B1C4895F6967@holtmann.org>
In-reply-to: <2C07ED0D-CC72-497B-AB67-B1C4895F6967@holtmann.org>
Subject: Re: [RFC 1/2] Bluetooth: Introduce MGMT_EV_DEVICE_NAME_UPDATE event
Date: Tue, 02 Apr 2013 10:48:46 +0530
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=iso-8859-1; reply-type=original
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

--------------------------------------------------
From: "Marcel Holtmann" <marcel@holtmann.org>
Sent: Monday, April 01, 2013 11:50 PM
To: "Jaganath Kanakkassery" <jaganath.k@samsung.com>
Cc: <linux-bluetooth@vger.kernel.org>; "Chan-yeol Park" 
<chanyeol.park@samsung.com>
Subject: Re: [RFC 1/2] Bluetooth: Introduce MGMT_EV_DEVICE_NAME_UPDATE event

> Hi Jaganath,
>
>> A new event is added in mgmt for remote device name updation.
>> This event will be sent to userspace whenever a remote name
>> event comes and mgmt_connected is already sent.
>
> for me it is pretty much unclear what this event is suppose to do. I am 
> pretty much against sending out random events to just push data into 
> userspace. This sounds more like the case where we should delay the 
> connection setup and notification until the remote name request finished.
>

Delaying the connection notification until remote name request completes 
will solve the problem here.
But is it ok not giving connection notification if l2cap connection happens 
before that?

> Every time you add a new event, the state machine in userspace becomes 
> more and more complicated. And that is one piece we are trying to avoid. 
> The more complicated userspace becomes, the more state mirroring we have 
> to do and then we are back at the level of race conditions that we had 
> with BlueZ 4.x and direct HCI usage. That is something we do not want.
>

Ok

> And the general procedure is to have a patch that updates the mgmt API 
> documentation first. I also made it clear in the past that we are not 
> accepting new mgmt commands and events without having a set of test cases 
> for mgmt-tester for it.
>

Ok, I will take care in the future patches.

Thanks,
Jaganath 
