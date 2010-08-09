Return-Path: <cyrus@holtmann.org>
Message-ID: <4C607D4C.8090407@csr.com>
Date: Mon, 09 Aug 2010 23:12:28 +0100
From: David Vrabel <david.vrabel@csr.com>
MIME-Version: 1.0
To: tmonahan@codeaurora.org
CC: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Subject: Re: RFC: QuIC's AMP + eL2CAP Technical Plans
References: <5a628eb7dc7c4773fbc9478499fde70b.squirrel@www.codeaurora.org>    <1267753300.29510.25.camel@localhost.localdomain>    <4B94E5FA.1020202@csr.com>    <1268072572.3712.24.camel@localhost.localdomain> <4fed618ae82fc803133cc742bbd2eeb6.squirrel@www.codeaurora.org> <4C607B43.2050207@csr.com>
In-Reply-To: <4C607B43.2050207@csr.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

David Vrabel wrote:
> Tim Monahan-Mitchell wrote:
>>
>> If the HCI_80211 symbol in hci.h is changed instead to HCI_AMP, where
>> should the 0x01 value for '802.11 AMP Controller' (listed in
>> Bluetooth.org's Assigned Number listing for Controller_Type) go?e
> 
> I don't think it needs to go anywhere, the actual values aren't 
> important from the point of view of the AMP manager.

I may have misunderstood your question.  There will need to be an 
additional "controller_type" field which will get filled in when the 
local amp info is read from the controller.

There will also need to be a table somewhere mapping controller types to 
dedicated amp link key length and KeyID.  The will be filled in from the 
assigned numbers and will be a very short table one 1 entry for now.

I do not think we need #define for the various AMP controller types.

David
-- 
David Vrabel, Senior Software Engineer, Drivers
CSR, Churchill House, Cambridge Business Park,  Tel: +44 (0)1223 692562
Cowley Road, Cambridge, CB4 0WZ                 http://www.csr.com/


Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
