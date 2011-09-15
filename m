Return-Path: <cyrus@holtmann.org>
From: Peter Hurley <peter@hurleysoftware.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Date: Thu, 15 Sep 2011 09:04:05 -0400
Subject: Re: Local security mode 4 with security mode 3 remotes
Message-ID: <1316091845.11366.17.camel@THOR>
References: <1312831632.2289.26.camel@THOR>
In-Reply-To: <1312831632.2289.26.camel@THOR>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 2011-08-08 at 15:27 -0400, Peter Hurley wrote:
> I've just noticed that when a 2.1+ host controller connects to a 2.0-
> remote device, the kernel re-authenticates and re-encrypts the ACL link
> -- although the link was already encrypted. For example,
> 
> 2011-08-08 12:43:18.558584 < HCI Command: Accept Connection Request (0x01|0x0009) plen 7
>     bdaddr 00:0D:FD:1E:99:30 role 0x00
>     Role: Master
> 2011-08-08 12:43:18.561558 > HCI Event: Command Status (0x0f) plen 4
>     Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
> 2011-08-08 12:43:18.737647 > HCI Event: Role Change (0x12) plen 8
>     status 0x00 bdaddr 00:0D:FD:1E:99:30 role 0x00
>     Role: Master
> 2011-08-08 12:43:18.876717 > HCI Event: Link Key Request (0x17) plen 6
>     bdaddr 00:0D:FD:1E:99:30
> 2011-08-08 12:43:18.876824 < HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
>     bdaddr 00:0D:FD:1E:99:30 key AF20110EE1D32E2C27821EC3719FE7FF
> 2011-08-08 12:43:18.956757 > HCI Event: Command Complete (0x0e) plen 10
>     Link Key Request Reply (0x01|0x000b) ncmd 1
>     status 0x00 bdaddr 00:0D:FD:1E:99:30
> 2011-08-08 12:43:19.143850 > HCI Event: Connect Complete (0x03) plen 11
>     status 0x00 handle 13 bdaddr 00:0D:FD:1E:99:30 type ACL encrypt 0x01
> 
> Legacy security-level 3 remote device that creates an encrypted
> connection.
> 
> ... < snip > ... Incoming RFCOMM connection
> 
> 2011-08-08 12:43:19.510035 > ACL data: handle 13 flags 0x02 dlen 12
>     L2CAP(s): Connect req: psm 3 scid 0x0041
> 2011-08-08 12:43:19.510051 < ACL data: handle 13 flags 0x00 dlen 16
>     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0041 result 0 status 0
>       Connection successful
> 
> ... < snip > ... Re-auth & re-encrypt (sec_level of RFCOMM dlc was medium)
> 
> 2011-08-08 12:43:19.677119 > ACL data: handle 13 flags 0x02 dlen 8
>     L2CAP(d): cid 0x0040 len 4 [psm 3]
>       RFCOMM(s): SABM: cr 1 dlci 26 pf 1 ilen 0 fcs 0xe7 
> 2011-08-08 12:43:19.677144 < HCI Command: Authentication Requested (0x01|0x0011) plen 2
>     handle 13
> 2011-08-08 12:43:19.679118 > HCI Event: Command Status (0x0f) plen 4
>     Authentication Requested (0x01|0x0011) status 0x00 ncmd 1
> 2011-08-08 12:43:19.754156 > HCI Event: Link Key Request (0x17) plen 6
>     bdaddr 00:0D:FD:1E:99:30
> 2011-08-08 12:43:19.754234 < HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
>     bdaddr 00:0D:FD:1E:99:30 key AF20110EE1D32E2C27821EC3719FE7FF
> 2011-08-08 12:43:19.836196 > HCI Event: Command Complete (0x0e) plen 10
>     Link Key Request Reply (0x01|0x000b) ncmd 1
>     status 0x00 bdaddr 00:0D:FD:1E:99:30
> 2011-08-08 12:43:19.837197 > HCI Event: Auth Complete (0x06) plen 3
>     status 0x00 handle 13
> 2011-08-08 12:43:19.837207 < HCI Command: Set Connection Encryption (0x01|0x0013) plen 3
>     handle 13 encrypt 0x01
> 2011-08-08 12:43:19.839198 > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 13 packets 1
> 2011-08-08 12:43:19.841197 > HCI Event: Command Status (0x0f) plen 4
>     Set Connection Encryption (0x01|0x0013) status 0x00 ncmd 1
> 2011-08-08 12:43:19.843199 > HCI Event: Encrypt Change (0x08) plen 4
>     status 0x00 handle 13 encrypt 0x01
> 
> 
> What is the consensus opinion regarding redundant auth + encrypt for
> legacy devices?
> 
> FWIW, in my opinion, Figure 5.5 of the Core 4.0 spec, Vol 3, Part C -
> Generic Access Profile (pg 305 of 656) shows a flowchart with a decision
> branch labeled "Encryption Enabled?" that allows an immediate bypass of
> auth + encrypt to a positive L2CAP_Connect_Resp.

To answer my own query here, the Core 4.0 spec, Vol 3, Part C - Generic
Access Profile has this to say in section 5.2.2.2.2, Authentication
Required for Access to Local Service by Remote Device:

"A Bluetooth device in security mode 4 shall respond to authentication
and pairing requests during link establishment when the remote device is
in security mode 3 for backwards compatibility reasons. However,
authentication of the remote device shall be performed after the receipt
of the channel establishment request is received, and before the channel
establishment response is sent."

The way I read this statement is that legacy devices *must* be
re-authenticated -- so that precludes my associated patch, "Bluetooth:
Preserve auth + encrypt for sec mode 3 remotes".
