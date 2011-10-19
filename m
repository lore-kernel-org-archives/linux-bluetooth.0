Return-Path: <cyrus@holtmann.org>
Date: Wed, 19 Oct 2011 14:25:27 -0700 (PDT)
From: Mat Martineau <mathewm@codeaurora.org>
To: Marcel Holtmann <marcel@holtmann.org>
cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi,
	pkrystad@codeaurora.org, andrei.emeltchenko@intel.com
Subject: Re: [PATCHv2 6/9] Bluetooth: Add definitions for L2CAP fixed
 channels
In-Reply-To: <1319051041.15441.167.camel@aeonflux>
Message-ID: <alpine.DEB.2.02.1110191402420.1976@mathewm-linux>
References: <1319046247-3391-1-git-send-email-mathewm@codeaurora.org>  <1319046247-3391-7-git-send-email-mathewm@codeaurora.org> <1319051041.15441.167.camel@aeonflux>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


On Wed, 19 Oct 2011, Marcel Holtmann wrote:

> Hi Mat,
>
>> Symbolic fixed channel IDs will be used instead of magic numbers.
>>
>> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
>> ---
>>  include/net/bluetooth/l2cap.h |    4 ++++
>>  1 files changed, 4 insertions(+), 0 deletions(-)
>>
>> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
>> index 4f4f318..b8b25f6 100644
>> --- a/include/net/bluetooth/l2cap.h
>> +++ b/include/net/bluetooth/l2cap.h
>> @@ -119,6 +119,10 @@ struct l2cap_conninfo {
>>  #define L2CAP_FCS_NONE		0x00
>>  #define L2CAP_FCS_CRC16		0x01
>>
>> +/* L2CAP fixed channels */
>> +#define L2CAP_FC_L2CAP		0x02
>> +#define L2CAP_FC_A2MP		0x08
>> +
>
> while you are at it, please add the known fixed channels for SMP and LE
> signaling here. They should be in use already somewhere ;)

The channel mask wasn't a problem at the recent UPF, since the LE 
fixed channels are only used on LE connections and the info 
request/response are only relevant for BR/EDR.  It seems like these LE 
fixed channel bits should not be set when sending an info response or 
checked when processing an info response.

Do you still want me to add them?

>
>>  /* L2CAP Control Field bit masks */
>>  #define L2CAP_CTRL_SAR			0xC000
>>  #define L2CAP_CTRL_REQSEQ		0x3F00

Regards,
--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum


