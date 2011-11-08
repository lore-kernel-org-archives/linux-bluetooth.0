Return-Path: <cyrus@holtmann.org>
Message-ID: <4EB9614F.8000303@codeaurora.org>
Date: Tue, 08 Nov 2011 09:05:19 -0800
From: Brian Gix <bgix@codeaurora.org>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org,
	Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: [PATCH 3/3] Bluetooth: Add address type fields to mgmt messages
 that need them
References: <1320700419-4665-1-git-send-email-johan.hedberg@gmail.com> <1320700419-4665-3-git-send-email-johan.hedberg@gmail.com> <4EB86A27.1030403@codeaurora.org> <20111108085256.GA9733@fusion.localdomain>
In-Reply-To: <20111108085256.GA9733@fusion.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On 11/8/2011 12:52 AM, Johan Hedberg wrote:
> Hi Brian,
>
> On Mon, Nov 07, 2011, Brian Gix wrote:
>>> +#define MGMT_ADDR_BREDR			0x00
>>> +#define MGMT_ADDR_LE			0x01
>>> +#define MGMT_ADDR_BREDR_LE		0x02
>>> +#define MGMT_ADDR_INVALID		0xff
>>
>
> The BREDR_LE option is there for the updated start_discovery command.
> You'll be able to specify whether you want BR/EDR-only, LE-only or
> interleaved discovery. I wouldn't add a completely new octet for public
> vs random information though but reuse the existing one instead. To be
> able to reuse our address type definitions for all purposes, how about
> making each value orthogonal to the others, e.g.:
>
> 	ADDR_BREDR	0x01
> 	ADDR_LE_PUBLIC	0x02
> 	ADDR_LE_RANDOM	0x04
>


I think that this would work well, and would support an address type 
field as a bit mask, and then extending that to all MGMT commands and 
events that use a remote address as a field/parameter.



-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
