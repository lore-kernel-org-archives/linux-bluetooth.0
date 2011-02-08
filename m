Return-Path: <cyrus@holtmann.org>
Message-ID: <4D51D8AE.9020005@codeaurora.org>
Date: Tue, 08 Feb 2011 15:58:38 -0800
From: Brian Gix <bgix@codeaurora.org>
MIME-Version: 1.0
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Kernal/User space change for LE Random Addresses
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


One other change that is needed, which I don't really know how to attack 
is remote devices with Random Addresses.  There is at least one team 
here at UPF with a device with a Random Address which cannot be 
connected to with either Vinicius' or the bluetooth-next kernal tips, 
because the connection HCI command only specifies Public Addresses as 
the remote address type.

I am not at all knowledgable about sockets, but I assume that a new 
Socket option needs to be defined that specifies address type.

I can get around this inelegantly by building a secondary kernel which 
hard-codes the address type to Random, and then dual booting into that 
kernel for random address only remote devices.

I would love if someone who knows the bluez socket option handling (both 
kernel and user space) could fix this, otherwise I will try to muddle 
along on my own.


-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
