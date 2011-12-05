Return-Path: <cyrus@holtmann.org>
Message-ID: <4EDCFCB6.5010206@codeaurora.org>
Date: Mon, 05 Dec 2011 09:17:42 -0800
From: Brian Gix <bgix@codeaurora.org>
MIME-Version: 1.0
To: "Ganir, Chen" <chen.ganir@ti.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: LE Connection issues
References: <F0070FBC0FB3174D8D11444EB2D5B026440280@DNCE02.ent.ti.com>
In-Reply-To: <F0070FBC0FB3174D8D11444EB2D5B026440280@DNCE02.ent.ti.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chen,

On 12/5/2011 7:38 AM, Ganir, Chen wrote:
> Hi everyone.
>
> I've tried investigating the LE connection procedure a bit, and I came up with some issues. For example, you MUST first scan for devices even if you have a device already paired, in order to connect to it. This is not the case for BR/EDR devices, where you can turn on the host, and try to connect to the paired device immediately. This has a major impact on user experience. I believe that the only relevant information from the advertising data is the address type, which can be sent to the host, and used later when trying to connect to the device again. I believe there were some discussions regarding this issue a while back, but I cannot recall what was done about this.
>
> In addition, a call for brd_device_add_attio_callback may fail immediately (without even calling the connect/disconnect callbacks) if the device is not present in the advertising cache (fail with error "no route to device"). This also results in a bad user experience, since a user may think that the host is trying to connect to the peer, while in fact the host failed and did not indicate this failure to the user. Since LE does not define a connection timeout, we have a problem here, since we failed on implementation and not spec issue, and we did not inform the user of this error.
>
> Did anyone else encounter these issues, or has anything to comment about these issues ?


I have definitely dealt with the same issue, and it has indeed been 
raised here.  I am equally unclear as to if it has been fully resolved, 
but Johan has made some changes to the MGMT interface to create an 
Address Type bit field, and package it along with the Address into a 
struct called mgmt_addr_info, which is now used in the device found 
event, connect failed event and pair device command.

I would like to further extend the usage of this structure to replace 
the simple bdaddr in the mgmt_link_key_info struct, so that once a 
device has been paired, the kernel's database of Link keys will have a 
copy of the address type.  This might not be a perfect fit, because not 
all devices will support LTK's (opting instead perhaps for the CSRK, if 
the usage model does not support links that remain open indefinitely). 
However, if a "trusted relationship" (i.e. Paired) has been established, 
I think some sort of key must exist, and each of these keys is 
associated with a particular bdaddr, and the kernel will need to be 
aware of it, which gives us the opportunity to make that connection (and 
differentiation) between BR/LE-Public/LE-Random

Johan has made the Address type be a bit field, such that the current 3 
recognized types are "BR/EDR", "Public LE", and "Random LE".


-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
