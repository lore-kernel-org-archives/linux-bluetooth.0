Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Passkey-Agent for bluez 4.xx
Date: Mon, 18 May 2009 12:21:22 -0700
Message-ID: <88BAD6A2A6AF68449DBBF80948806AC9014F5692@bb-corp-ex1.corp.cubic.cub>
From: "Wilson, Scott" <SCOTT.WILSON@CUBIC.COM>
To: <linux-bluetooth@vger.kernel.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

All,

>Hello,

>Brad Midgley schrieb:
>> Artem,
>>
>> It may not be the best way, but I modified simple-agent from tests
>> with a hardcoded pin, then I run it in the background at startup.
>> Replace 5555 with your pin.

>Thanks for your reply.

>I have tired this. It works only with the 1st bluetooth device in the
>system. It does not work with my 2nd bluetooth device. So it is not
>useable for me.

>Are there any other passkey-agents available?

>Thanks, Artem

I also have a similar issue, only mine involves Linux embedded on a
device. I have no agent running on the device at this time and therefore
pairing isn't working (which makes it hard for anything else to work).

At this point, I can either put Python on the device and use the
simple-agent python script to start the agent (which may be a job in
itself), or I can try and fix the test/agent.c program to suit my needs.

My question is, how hard would it be to fix the agent.c code myself?  It
seems that it is self contained and therefore not impossible to fix
myself.  But, could it be that since I am new to dbus and agents, I am
not seeing the entire picture?  Could someone lend me some assistance
and then I could submit my work back to the group?

My background is EE/Computer Eng. and I have been programming in
C/C++/Java for almost 20 years now.

Naturally, the problem for me is that I have a deadline looming
(beginning of June) so I need to have something working sooner rather
than later.

Any and all comments are welcome.

Thank you,

Scott Wilson
