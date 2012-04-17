Return-Path: <cyrus@holtmann.org>
Date: Tue, 17 Apr 2012 08:09:13 -0700 (PDT)
From: Mat Martineau <mathewm@codeaurora.org>
To: Dean Jenkins <djenkins@mvista.com>
cc: linux-bluetooth@vger.kernel.org
Subject: Re: A request to understand the design decisions why tasklets were
 changed to workqueues eg. hci_rx_task() to hci_rx_work()
In-Reply-To: <CAJ2qBzZwuiAaL99=mT5P+MQKXd-gc7zdn6x5f1sr5Kpw=tQytw@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1204170751480.25494@mathewm-linux>
References: <CAJ2qBzZwuiAaL99=mT5P+MQKXd-gc7zdn6x5f1sr5Kpw=tQytw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Dean -

On Tue, 17 Apr 2012, Dean Jenkins wrote:

> Hi,
>
> I am interested to the understand the design decisions for changing
> from tasklets to workqueues.
>
> Was there a fundamental flaw that necessitated the change ?
>
> I am asking because I am getting a Bluetooth "scheduling while atomic"
> failure on an ARM based 2.6.34 kernel (with some 2.6.37 Bluez
> backports). Changing to workqueues would avoid this issue as a
> workqueue use process context that can sleep.
>
> Thanks for any info on the design decisions.

Take a look at http://article.gmane.org/gmane.linux.bluez.kernel/19535 
and the thread it is part of.  The main motivation was to eliminate 
bugs and complexity arising from a mix of tasklet-context and 
process-context code.  Locking and concurrency problems have become 
trickier with the introduction of the management interface, L2CAP 
ERTM, and AMP.

There were big changes to the workqueue internals in 2.6.36, I don't 
know if that will cause major issues when backporting current code to 
2.6.34.

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

