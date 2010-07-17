Return-Path: <cyrus@holtmann.org>
Message-ID: <4947.70805.qm@web56502.mail.re3.yahoo.com>
Date: Fri, 16 Jul 2010 21:09:25 -0700 (PDT)
From: Shreesh Holla <hshreesh@yahoo.com>
Subject: [HCI Events] Connection Event  Processing
To: linux-bluetooth@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I'm trying to build a  handler for a project and needed to  process the 
Connection Request Event.
I'm able to get that  properly. But I tried adding a "reject Connection" - 
command in the  handler and invariably an "Accept Connection" command is 
issued.This  is what I can see from hcidump and my event handling code.

I  need to override that. So where is this done? In the Bluez library,  
bluetoothd 

or btusb? Or somewhere else? Or is there some other kind  of setup/hooks that 
needs to be modified to insert my own event  handler?

Any help would be great here.

Thanks

Shreesh

