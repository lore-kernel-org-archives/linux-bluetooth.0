Return-Path: <cyrus@holtmann.org>
Message-ID: <4EEE1FE5.80204@codeaurora.org>
Date: Sun, 18 Dec 2011 09:16:21 -0800
From: Brian Gix <bgix@codeaurora.org>
MIME-Version: 1.0
To: "Ganir, Chen" <chen.ganir@ti.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: LE SM Testing
References: <F0070FBC0FB3174D8D11444EB2D5B02607D2C752@DNCE02.ent.ti.com>
In-Reply-To: <F0070FBC0FB3174D8D11444EB2D5B02607D2C752@DNCE02.ent.ti.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chen,

On 12/18/2011 4:19 AM, Ganir, Chen wrote:
> Hi.
> Does anyone have an idea how can I establish an LE link with SM fixed channel to a remote peer to test the SMP functionality ? I do not see any possibility to do this at the moment. Hcitool does not connect the SMP, and btiotest requires a remote l2cap channel listener other than the SMP. Gatttool will not help as well, since it requires an ATT server at the peer device.

Fixed channels (including the LE fixed channels) require no setup beyond 
ACL establishment.  So you can "establish" the SM channel simply by 
creating an LE link.

Using gatttool -I, you can establish a connection a connection to a 
remote LE device. SM functionality can then be triggered by elevating 
security. ("sec-level medium" from gatttool).  This should be the 
equivilent of "General Bonding" in the BR/EDR world.

I think hcitool also has an "lecc" command that specifically calls the 
"Create LE connection" HCI command, which could be used if you just need 
to establish an LE connection.

Also, hasn't the "pair device" via the MGMT interface been 
implemented/enabled in BlueZ? This would be the "Dedicated Bonding" 
equivalent of BR/EDR.


-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
