Return-Path: <cyrus@holtmann.org>
Message-ID: <4B94E5FA.1020202@csr.com>
Date: Mon, 08 Mar 2010 11:56:42 +0000
From: David Vrabel <david.vrabel@csr.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: tmonahan@codeaurora.org, linux-bluetooth@vger.kernel.org
Subject: Re: RFC: QuIC's AMP + eL2CAP Technical Plans
References: <5a628eb7dc7c4773fbc9478499fde70b.squirrel@www.codeaurora.org> <1267753300.29510.25.camel@localhost.localdomain>
In-Reply-To: <1267753300.29510.25.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Marcel Holtmann wrote:
> 
> The block-based flow control is a missing piece, but the AMP type
> extension has been merged upstream. We can create HCI_BREDR and
> HCI_80211 controllers now. The AMP controllers are for now forced to be
> raw devices, but that can be changed easily once we have the controller
> init for AMP up and ready.

Why HCI_80211 and not HCI_AMP?  The stack shouldn't care what the AMP's
radio actually is and with some devices (e.g., standard SDIO ones) it's
not even possible to tell what the radio is.

David
-- 
David Vrabel, Senior Software Engineer, Drivers
CSR, Churchill House, Cambridge Business Park,  Tel: +44 (0)1223 692562
Cowley Road, Cambridge, CB4 0WZ                 http://www.csr.com/


Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
