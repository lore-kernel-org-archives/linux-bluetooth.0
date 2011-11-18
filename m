Return-Path: <cyrus@holtmann.org>
Subject: Re: [RFC] LE: Low Latency GATT Write-Sign-Cmd
From: Marcel Holtmann <marcel@holtmann.org>
To: Brian Gix <bgix@codeaurora.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Date: Fri, 18 Nov 2011 20:08:58 +0100
In-Reply-To: <4EC6A13B.5030805@codeaurora.org>
References: <4EC6A13B.5030805@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1321643339.15441.622.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

> One of the useful features of Low Energy is the ability to rapidly 
> establish a connection, send a responseless Signed Write Command, and 
> tear the connection down.  The obvious use case for this would be a 
> standard remote control, where extremely low latency is expected.
> 
> The difference between this use case, and something like one of the 
> Health profiles, is that a Health device (Heart rate Monitor, or 
> Thermometer) is that where the Health device would have a persistent 
> connection with high latency (less frequent Beacons), the Remote Control 
> use case would rarely be connected, but when it is it will be as low 
> latency as possible.
> 
> Currently we do not support Write Signed Commands at all, although I 
> hope to have that addressed in the not too distant future.  However the 
> nature of it's usage model is not very well established here 
> (BlueZ/Linux) so I would like to float a few ideas.
> 
> 
> This is what should happen when the user hits a button on his remote 
> control (or in his remote control linux APP):
> 
> 1. Request LE Connection with Low Latency Parameters
> 2. Compose & sign the GATT Write Cmd (in parallel with Connect Req)
> 3. When Successful Connect Cmplt Evt occurs, send the Write Cmd Pkt
> 4. WAIT for the Num Completed Pkts Evt (VERY IMPORTANT)
> 5. As soon as you have it, Disconnect
> 
> This use case is only valid for LE (GATT connections must be Secure on 
> BR/EDR, and therefore will never be as fast, and will never in fact even 
> need to be signed).  If done properly, the entire sequence can be 
> completed in the 10's of milliseconds, from button press to Disconnect.
> 
> This calls for a different thread of operation from current GATT 
> operation for a few reasons:
> 
> 1. Standard GATT connections will have different Connect Parameters
> 
> 2. Standard GATT connection establishment requires on a round trip from
> User space--> Kernel --> Baseband and back before the ACL packet is even 
> written to the Socket in User Space.
> 
> 3. The signing crypto code is in the Kernel, and must be applied to each 
> signed write command in a way that suggests some LE-GATT-Write-Cmd 
> knowledge must exist in the kernel, as opposed to being a simple ACL pipe.

the kernel crypto can be easily used from userspace. See PF_ALG.

So the real question is what's the price of a context switch for us?

> 4. There is no current mechanism for the Kernel to inform the User space 
> code that the ACL packet has finished transmission, and that it is OK to 
> disconnect.
> 
> 5. We already special case the handling of the LE-L2Cap CIDs for 
> Signaling and SMP.
> 
> 
> So I would like to suggest the following straw-man:
> 
> A new LE only MGMT command, which accepts as parameters the Remote 
> Address, a length and a buffer.  The buffer would be reasonable sized (I 
> would recommend 27 bytes, which is the default LE MTU+HDR). The byte 
> stream itself could either be composed by the User space GATT code 
> (L2CAP header, Attribute Handle, Write Data) or they could be structure 
> fields in the MGMT packet. On the Kernel side, the MGMT code would 
> shepherd the packet through the connection, signing, and send process. 
> If the connection to the remote device was already established, the 
> existing connection would be used, the signing would only be done if the 
> link was not encrypted, and the connection would be left up. When the 
> Num-Completed-Pkts evt arrives, send the MGMT cmd_status response.
> 
> I think this would be way cleaner than trying to wedge this use case 
> into our current GATT usage model.

I think one of the most important questions that we have to ask
ourselves at some point is if we wanna put ATT into the kernel.

The potential candidate that forces us to think about this is HID over
Low Energy. However I like to see numbers on how the context switches
with keeping ATT in userspace will effect our latency.

Regards

Marcel


