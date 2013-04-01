Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Subject: Re: [RFC 1/2] Bluetooth: Introduce MGMT_EV_DEVICE_NAME_UPDATE event
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1364810354-2121-1-git-send-email-jaganath.k@samsung.com>
Date: Mon, 1 Apr 2013 11:20:03 -0700
Cc: linux-bluetooth@vger.kernel.org,
	Chan-yeol Park <chanyeol.park@samsung.com>
Message-Id: <2C07ED0D-CC72-497B-AB67-B1C4895F6967@holtmann.org>
References: <1364810354-2121-1-git-send-email-jaganath.k@samsung.com>
To: Jaganath Kanakkassery <jaganath.k@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

> A new event is added in mgmt for remote device name updation.
> This event will be sent to userspace whenever a remote name
> event comes and mgmt_connected is already sent.

for me it is pretty much unclear what this event is suppose to do. I am pretty much against sending out random events to just push data into userspace. This sounds more like the case where we should delay the connection setup and notification until the remote name request finished.

Every time you add a new event, the state machine in userspace becomes more and more complicated. And that is one piece we are trying to avoid. The more complicated userspace becomes, the more state mirroring we have to do and then we are back at the level of race conditions that we had with BlueZ 4.x and direct HCI usage. That is something we do not want.

And the general procedure is to have a patch that updates the mgmt API documentation first. I also made it clear in the past that we are not accepting new mgmt commands and events without having a set of test cases for mgmt-tester for it.

Regards

Marcel

