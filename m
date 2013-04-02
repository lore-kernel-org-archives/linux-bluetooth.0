Return-Path: <cyrus@holtmann.org>
Subject: Re: [RFC 1/2] Bluetooth: Introduce MGMT_EV_DEVICE_NAME_UPDATE event
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Content-Type: text/plain; charset=US-ASCII
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <FA262637A35F4111AD38E20426ADD57A@sisodomain.com>
Date: Mon, 1 Apr 2013 22:47:10 -0700
Cc: linux-bluetooth@vger.kernel.org,
	Chan-yeol Park <chanyeol.park@samsung.com>
Message-Id: <9154A333-F1D6-49E7-9C74-830C7B6322A3@holtmann.org>
References: <1364810354-2121-1-git-send-email-jaganath.k@samsung.com> <2C07ED0D-CC72-497B-AB67-B1C4895F6967@holtmann.org> <FA262637A35F4111AD38E20426ADD57A@sisodomain.com>
To: Jaganath Kanakkassery <jaganath.k@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

>>> A new event is added in mgmt for remote device name updation.
>>> This event will be sent to userspace whenever a remote name
>>> event comes and mgmt_connected is already sent.
>> 
>> for me it is pretty much unclear what this event is suppose to do. I am pretty much against sending out random events to just push data into userspace. This sounds more like the case where we should delay the connection setup and notification until the remote name request finished.
>> 
> 
> Delaying the connection notification until remote name request completes will solve the problem here.
> But is it ok not giving connection notification if l2cap connection happens before that?

that depends on what our semantics are. The ACL connection state machine already has to do certain steps before it allows any establishment of any L2CAP connection. This mainly comes from the SSP requirements. So adding the name update to it might be a good idea. That way the L2CAP connection will only complete after the mgmt connect event has been send to userspace. If that really matters. I am not even sure we have such a semantic right now.

Regards

Marcel

