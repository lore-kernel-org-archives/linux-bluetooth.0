Return-Path: <cyrus@holtmann.org>
Subject: Re: Keeping ACL link around after DBUS CreateBonding()
From: Marcel Holtmann <marcel@holtmann.org>
To: Nick Pelly <npelly@google.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <35c90d960810061442r5edb776blbdf420ac067e9f9c@mail.gmail.com>
References: <35c90d960810021747j56d5bc2ie62c10ade0026694@mail.gmail.com>
	 <1223015762.11272.30.camel@violet.holtmann.net>
	 <35c90d960810022342p1fca607x4be774ae9e675fd9@mail.gmail.com>
	 <1223016985.11272.38.camel@violet.holtmann.net>
	 <35c90d960810060918l5887aedya50893238ca3aee7@mail.gmail.com>
	 <1223310384.11272.209.camel@violet.holtmann.net>
	 <35c90d960810061442r5edb776blbdf420ac067e9f9c@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 07 Oct 2008 00:33:55 +0200
Message-Id: <1223332435.11272.240.camel@violet.holtmann.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Nick,

> Attached is the btsnoop from the CreateBonding()
> 
> Note the "Create Connection Cancel" right after completing bonding.
> This is what this patch tries to address - allow 2 seconds before
> disconnecting the ACL link instead of 10 ms for this scenario.

so the actual questions is why we end up here:

> HCI Event: Link Key Notification (0x18) plen 23
    bdaddr 00:19:7F:64:DA:C5 key E3E8A7783875D177851DC9F0EEEB474D type 0
    Type: Combination Key
< HCI Command: Create Connection Cancel (0x01|0x0008) plen 6
    bdaddr 00:19:7F:64:DA:C5
< HCI Command: Create Connection Cancel (0x01|0x0008) plen 6
    bdaddr 00:19:7F:64:DA:C5
> HCI Event: Command Complete (0x0e) plen 10
    Create Connection Cancel (0x01|0x0008) ncmd 1
    status 0x00 bdaddr 00:19:7F:64:DA:C5
> HCI Event: Command Complete (0x0e) plen 10
    Create Connection Cancel (0x01|0x0008) ncmd 1
    status 0x00 bdaddr 00:19:7F:64:DA:C5
> HCI Event: Connect Complete (0x03) plen 11
    status 0x02 handle 1 bdaddr 00:19:7F:64:DA:C5 type ACL encrypt 0x01
    Error: Unknown Connection Identifier

The problem is not the kernel since the kernel is doing the right thing
here. If the last user goes away and we haven't established ACL then we
cancel it instead of letting it timeout.

So the CreateBonding is actually broken here. CreateBonding should only
close the L2CAP raw socket (the one we use for bonding), when we get
Auth Complete (in that case 2 seconds apply) or when we get the Link Key
Notification before Connect Complete, it has to wait until Connect
Complete to close it.

Johan, please check if your modified code in 4.x actually does the right
thing for security mode 3. Or if we still have the same issue.

> Also note that the "Create Connection Cancel" takes 40 seconds to
> return from the BRF6300. To me this looks like a unrelated issue with
> the TI chip (and I have a separate conversation going on with TI about
> it).

The double Create Connection Cancel and not rejecting one with an error
code is an issue of the TI chip. It should not allow that. Question
still is why do we send it twice.

Regards

Marcel


