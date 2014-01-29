Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [RFC BlueZ 0/2] Print bluetoothd messages in btmon
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1390599712-1609-1-git-send-email-vcgomes@gmail.com>
Date: Tue, 28 Jan 2014 22:42:08 -0800
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <ACF337D1-0BF3-494E-959C-27B210C3E532@holtmann.org>
References: <1390599712-1609-1-git-send-email-vcgomes@gmail.com>
To: Vinicius Gomes <vcgomes@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

> It is very common when debugging issues, specially users' problems to
> ask for btmon logs and the accompaining bluetoothd logs. And depending
> on the issue, it takes some time to relate the HCI/MGMT commands to
> bluetoothd messages that help narrow down the problem.
> 
> This is just a proof of concept, to know if this will be generally
> helpful. And so, it needs some improvements: sending bluetoothd the USR2
> signal so debug is enabled, color support and better formatting.

so I am thinking to do this completely different.

I think that the btsnoop 2.0 format should get a section for notes/comments/logs where we can store text information. So you can actually interline HCI traffic with human readable comments. For example Apple is doing that with their Packet Logger. Obvious this is only useful if everything is in a single file that can be easily shared.

For this to work we need to read all the data from monitor interface of the kernel. Which means that the kernel also needs to have the debug/log output of bluetoothd. Meaning that bluetoothd would write the debug/logs into the kernel monitor interface and then they would be distributed to every btmon instance.

As a result bluetoothd would only log warnings, error and info messages to syslog/journal and all debug information should go back to the kernel.

Initially I was thinking just adding writing support monitor channel, but that is silly since it will turn on promiscuous mode. Something that is causing a bit of overhead on a production system. So we rather not do that. Maybe it would be better to assign a new HCI channel for bluetoothd logging data.

The one thing that is pretty obvious already is that we want to log per HCI index from bluetoothd. Which means we need to change the logging to be HCI controller aware. Without being HCI controller aware it is pretty much useless.

One interesting thing to think about is if we should tie enabling debug logs to the fact if btmon is running or not. And if we might allow btmon to configure the level of logs we want. It would be kinda cool if we can start btmon with -d ‘*audio*’ and then it magically gets all audio logs. Now it gets a bit funny with a kernel interface writing back into userspace to configure the logging level of a daemon.

I have been toying with the idea of having filters on btmon already and making the kernel just filter out packets so that userspace does not get woken up. I just never figured out the right API to do it.

Regards

Marcel

