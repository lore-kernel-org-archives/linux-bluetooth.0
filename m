Return-Path: <cyrus@holtmann.org>
Date: Fri, 6 Apr 2012 07:48:45 -0700 (PDT)
From: Mat Martineau <mathewm@codeaurora.org>
To: gustavo@padovan.org, johan.hedberg@gmail.com
cc: linux-bluetooth@vger.kernel.org, pkrystad@codeaurora.org,
    andrei.emeltchenko.news@gmail.com, szymon.janc@tieto.com,
    Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCHv4 2/2] Bluetooth: Functions for handling ERTM control
 fields
In-Reply-To: <1333571483.16897.1.camel@aeonflux>
Message-ID: <alpine.DEB.2.02.1204060745350.25380@mathewm-linux>
References: <1333564183-23442-1-git-send-email-mathewm@codeaurora.org>  <1333564183-23442-3-git-send-email-mathewm@codeaurora.org> <1333571483.16897.1.camel@aeonflux>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>


Gustavo (or Johan) -

On Wed, 4 Apr 2012, Marcel Holtmann wrote:

> Hi Mat,
>
>> These functions encode or decode ERTM control fields (extended or
>> enhanced) to or from the new l2cap_ctrl structure.
>>
>> Acked-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
>> ---
>>  net/bluetooth/l2cap_core.c |   99 ++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 99 insertions(+)
>
> Acked-by: Marcel Holtmann <marcel@holtmann.org>

Could you apply the two patches from this patchset?

Thanks,
--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
