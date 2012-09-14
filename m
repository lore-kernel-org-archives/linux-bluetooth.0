Return-Path: <cyrus@holtmann.org>
Date: Fri, 14 Sep 2012 08:42:53 -0700 (PDT)
From: Mat Martineau <mathewm@codeaurora.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org
Subject: Re: [PATCHv4 04/17] Bluetooth: AMP: Use HCI cmd to Read Loc AMP
 Assoc
In-Reply-To: <20120914065807.GB7483@aemeltch-MOBL1>
Message-ID: <alpine.DEB.2.02.1209140817080.19321@mathewm-linux>
References: <alpine.DEB.2.02.1209111121550.3754@mathewm-linux> <1347437192-24694-1-git-send-email-Andrei.Emeltchenko.news@gmail.com> <1347437192-24694-5-git-send-email-Andrei.Emeltchenko.news@gmail.com> <alpine.DEB.2.02.1209130814370.19321@mathewm-linux>
 <20120914065807.GB7483@aemeltch-MOBL1>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Hi Andrei -

On Fri, 14 Sep 2012, Andrei Emeltchenko wrote:

> Hi Mat,
>
> On Thu, Sep 13, 2012 at 08:28:06AM -0700, Mat Martineau wrote:
>>> When receiving A2MP Get AMP Assoc Request execute Read Local AMP Assoc
>>> HCI command to AMP controller. If the AMP Assoc data is larger then it
>>> can fit to HCI event only fragment is read. When all fragments are read
>>> send A2MP Get AMP Assoc Response.
>>>
>>> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> ...
>
>>> +void a2mp_send_getampassoc_rsp(struct hci_dev *hdev, u8 status)
>>> +{
>>> +	struct amp_mgr *mgr;
>>> +	struct amp_assoc *loc_assoc = &hdev->loc_assoc;
>>> +	struct a2mp_amp_assoc_rsp *rsp;
>>> +	size_t len;
>>> +
>>> +	mgr = amp_mgr_lookup_by_state(READ_LOC_AMP_ASSOC);
>>
>> What if multiple amp managers are in the READ_LOC_AMP_ASSOC state?
>> Is that possible if multiple remote devices send GETAMPASSOC at the
>> same time?
>
> In this very unrealistic case I still do not see a problem. All those HCI
> requests would be serialized and response would be sent for all AMP
> managers.

I agree that it won't be a common problem - but with millions of 
instances of the Linux kernel out there, if simultaneous requests 
*can* happen, they *will* happen.

It's mostly the reading of fragments I'm concerned about.  If multiple 
HCI_OP_READ_LOCAL_AMP_ASSOC commands are queued up to send to the AMP 
controller, and any of those involve reading fragments, the 
hdev->loc_assoc would be corrupted or you could get a buffer overrun 
from the memcpy's in hci_cc_read_local_amp_assoc.

An easy fix is to respond with an error status to any GETAMPASSOC 
commands that arrive while an earlier GETAMPASSOC is being processed.

--
Mat Martineau

The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation


