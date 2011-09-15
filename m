Return-Path: <cyrus@holtmann.org>
From: Peter Hurley <peter@hurleysoftware.com>
To: "Waldemar.Rymarkiewicz@tieto.com" <Waldemar.Rymarkiewicz@tieto.com>
CC: "padovan@profusion.mobi" <padovan@profusion.mobi>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Thu, 15 Sep 2011 09:18:58 -0400
Subject: RE: [PATCH v3 1/2] Bluetooth: Fix auth_complete_evt for legacy units
Message-ID: <1316092738.11366.29.camel@THOR>
References: <1306849766-31540-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
	 ,<1315505817.2004.70.camel@THOR>
	 <99B09243E1A5DA4898CDD8B700111448177F047B65@EXMB04.eu.tieto.com>
In-Reply-To: <99B09243E1A5DA4898CDD8B700111448177F047B65@EXMB04.eu.tieto.com>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Waldemar,

On Fri, 2011-09-09 at 02:42 -0400, Waldemar.Rymarkiewicz@tieto.com
wrote:
> Hi Peter,
> 
> >> Legacy devices don't re-authenticate the link properly if a link key
> >> already exists.  Thus, don't update sec_level for this case even if
> >> hci_auth_complete_evt indicates success. Otherwise the sec_level will
> >> not reflect a real security on the link.
> 
> >Can you clarify what you mean by "Legacy devices don't re-authenticate
> >the link properly if a link key already exists"?
> 
> I don't have a BT spec behind me now, but the point is that the legacy devices will not initiate new paring if the link key already exists.
> In another words, if the remote device has already been authenticated (e.g. with 4 digit pin), but the service requires higher security (use of 16 digit pin) the whole auth procedure will not start i.e. link_key_request ... etc. Instead, the controller returns auth_req with success immediately.

This behavior is unique to the controllers you tested. The Core 4.0 spec
(Vol 2, Part E - HCI Functional Spec, Section 7.1.15 Authentication
Requested Command) has this to say regarding this controller behavior:

"On receipt of an Authentication Requested Command, a local BR/EDR
Controller that is not in Simple Pairing Mode may use an existing stored
link key and respond immediately to the Host with an Authentication
Complete event.

This behavior is not recommended for controllers as it offers the Host
no method for enhancing the security of an existing link (e.g., in the
case where a profile mandating a minimum passkey length is started over
a link that is already authenticated with shorter passkey than the new
service requires)."

Here's a sequence from a controller that does not have this undesirable
behavior:

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

As you can see here, this controller correctly issues a Link Key Request
event as a result of receiving an Authentication Requested command (thus
giving the host stack the opportunity to re-pair at a higher security
level).

Unfortunately, your patch disables sec_level promotion of legacy devices
for *all* controllers.

Regards,
Peter Hurley

