Return-Path: <james.cameron@hp.com>
Date: Wed, 30 Jun 2004 23:09:48 +1000
From: James Cameron <james.cameron@hp.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] hci_acl_tx_to: hci0 ACL tx timeout
Message-ID: <20040630130948.GJ30504@hp.com>
References: <20040630112137.GE30504@hp.com> <1088595657.4540.19.camel@pegasus> <20040630120249.GH30504@hp.com> <1088599419.4540.24.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1088599419.4540.24.camel@pegasus>
Sender: james.cameron@hp.com
List-ID: <bluez-devel.lists.sourceforge.net>

On Wed, Jun 30, 2004 at 02:43:39PM +0200, Marcel Holtmann wrote:
> I really think this is buggy hardware in the USB dongle or in the USB
> host controller. Maybe it is also only a software problem and related to
> the USB subsystem. I don't know.

Well, tell me what to try to determine where the cause is.  Surely it
should be possible to instrument the kernel functions to gather more
information about the problem?  Then we can say "yes, it's the
hardware", or something else.

> If it is CSR based you can try "hciconfig hci0 revision".

hci0:   Type: USB
        BD Address: 00:02:72:01:E5:FF ACL MTU: 192:8  SCO MTU: 64:8
        HCI 16.4
        Chip version: BlueCore02
        Max key size: 56 bit
        SCO mapping:  HCI

Does that help?  (any good?)

-- 
James Cameron                         http://quozl.netrek.org/
HP Open Source, Volunteer             http://opensource.hp.com/
PPTP Client Project, Release Engineer http://pptpclient.sourceforge.net/
