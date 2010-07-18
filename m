Return-Path: <cyrus@holtmann.org>
Date: Sun, 18 Jul 2010 09:02:29 +0100
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Shreesh Holla <hshreesh@yahoo.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [HCI Events] Connection Event  Processing
Message-ID: <20100718080229.GA30607@jh-x301>
References: <4947.70805.qm@web56502.mail.re3.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4947.70805.qm@web56502.mail.re3.yahoo.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Shreesh,

On Fri, Jul 16, 2010, Shreesh Holla wrote:
> I'm trying to build a  handler for a project and needed to  process the 
> Connection Request Event.
> I'm able to get that  properly. But I tried adding a "reject Connection" - 
> command in the  handler and invariably an "Accept Connection" command is 
> issued.This  is what I can see from hcidump and my event handling code.
> 
> I  need to override that. So where is this done? In the Bluez library,  
> bluetoothd 
> 
> or btusb? Or somewhere else? Or is there some other kind  of setup/hooks that 
> needs to be modified to insert my own event  handler?
> 
> Any help would be great here.

The response to the connect request is more or less hardcoded into the
hci_conn_request_evt function in net/bluetooth/hci_event.c. There's a
patch[1] in the bluetooth-next-2.6 tree which adds blacklist support,
but afaik it's only headed for 2.6.36. It's also only a static list of
addresses to be rejected, so if you want something more dynamic it wont
be of much help.

Another way to avoid the kernel response to the connect request is to
set the HCI device into RAW mode but then you also loose all other
Bluetooth functionality provided by the kernel and userspace (i.e. you'd
essentially need to implement a full host stack yourself).

Johan

[1] http://git.kernel.org/?p=linux/kernel/git/holtmann/bluetooth-next-2.6.git;a=commitdiff;h=a1e716eedbed0bac3e9b84b7f53de182e12345cb
