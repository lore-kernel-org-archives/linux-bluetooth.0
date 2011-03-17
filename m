Return-Path: <cyrus@holtmann.org>
Message-ID: <4D8286A4.4000706@codeaurora.org>
Date: Thu, 17 Mar 2011 15:09:40 -0700
From: Brian Gix <bgix@codeaurora.org>
MIME-Version: 1.0
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
CC: Claudio Takahasi <claudio.takahasi@openbossa.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: SMP data within struct l2cap_conn  -vs-  single threading SMP
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Hi Vinicius,

As you probably know, I am working on adding mgmt.c plumbing into SMP, 
to enable user level input (Confirmation, passkeys, perhaps OOB).

One issue I am running into is matching up the return of user 
confirmation with the (struct l2cap_conn *).  There is nothing within 
the user confirmation aside from the bdaddr that identifies who it is 
intended for, and there is no one-to-one relationship between bdaddrs 
and L2CAP channels.

What would you think about enforcing a "one at a time" SMP process?

The SMP pairing data within the l2cap_conn structure is certainly a 
handy place for it, however it is bulky for the times (most of the time) 
where SMP is *not* taking place, and as in the obvious case I mention 
above, there is not a handy way to track the L2CAP connection back to 
the user input.

I would like to suggest that all of the SMP data be pulled out of the 
l2cap_conn structure, and put into a private structure within smp.c. It 
can be malloc'd when the pairing process starts, free'd when it 
completes, and any traffic (from either the User or the Baseband) that 
takes place when another device is in the midst of pairing gets rejected.

This structure local to smp.c would store both the bdaddr (to match up 
with user input) and the l2cap_conn * to match up with BB traffic, and 
provide the outbound path for the user confirmation which would 
otherwise be difficult to track down.

Your Thoughts?

-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
