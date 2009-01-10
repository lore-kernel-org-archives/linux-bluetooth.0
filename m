Return-Path: <cyrus@holtmann.org>
Message-ID: <4968901B.4010706@nokia.com>
Date: Sat, 10 Jan 2009 14:10:03 +0200
From: Ville Tervo <ville.tervo@nokia.com>
MIME-Version: 1.0
To: ext Nick Pelly <npelly@google.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC] Suggest to revert commit 9719f8af (Disconnect when encryption
 	gets disabled) due to role switch issues
References: <35c90d960901081430s5f5d1067pbff846525842e27e@mail.gmail.com>
In-Reply-To: <35c90d960901081430s5f5d1067pbff846525842e27e@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

ext Nick Pelly wrote:
> This original commit drops an L2CAP or RFCOMM connection if encryption
> was requested and the remote side disables encryption.
> 
> The problem occurs during Role Switch. Bluetooth 2.0 devices have to
> drop encryption temporarily during the role switch, but when this
> remote side does this we immediately disconnect due to this patch.
> Here is an example:
> 
> 2009-01-08 11:17:52.972625 > HCI Event: Encrypt Change (0x08) plen 4
>    status 0x00 handle 1 encrypt 0x00
> 2009-01-08 11:17:53.021362 < ACL data: handle 1 flags 0x02 dlen 8
>    L2CAP(d): cid 0x009c len 4 [psm 3]
>      RFCOMM(s): DISC: cr 1 dlci 4 pf 1 ilen 0 fcs 0x77
> 2009-01-08 11:17:53.139648 > HCI Event: Role Change (0x12) plen 8
>    status 0x00 bdaddr 00:1A:0E:7E:6B:70 role 0x01
>    Role: Slave
> 2009-01-08 11:17:53.142120 > HCI Event: Number of Completed Packets
> (0x13) plen 5
>    handle 1 packets 1
> 2009-01-08 11:17:53.165161 < ACL data: handle 1 flags 0x02 dlen 12
>    L2CAP(s): Disconn req: dcid 0x009b scid 0x0040
> 2009-01-08 11:17:53.279174 > HCI Event: Encrypt Change (0x08) plen 4
>    status 0x00 handle 1 encrypt 0x01
> 
> (With Bluetooth 2.1 this is solved with the Encryption pause and
> resume LMP command)
> 
> Reverting this patch is unfortunate because it leaves us less secure -
> we continue happily even if the remote side drops encryption. In
> practice this does not normally happen. However we cannot ship a HFP
> product with this commit because many CSR headsets like to role
> switch. This will be affecting all bluez users that use LM_ENCRYPT or
> LM_SECURE with devices that role switch and maybe the best approach is
> to also revert this commit in mainline.
> 
> The other alternative is to introduce a timer that starts when the
> remote side drops encryption. They then have say 5 seconds to complete
> a role switch and re-establish encryption, otherwise the RFCOMM link
> is dropped. Any other ideas?

No. At least all the headsets that I have tested re-enables encryption 
after a while. I have preliminary patch set which implements this. I'll 
send it for commants to the list soon. RFCOMM TX should be halted also 
while encryption is disabled.

Another problem is some 2.1 headsets which connect to non-sdp psm 
without encryption. I guess they also need some hack.


-- 
Ville
