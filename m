Return-Path: <cyrus@holtmann.org>
Message-ID: <5039179D.6010909@shealevy.com>
Date: Sat, 25 Aug 2012 14:21:17 -0400
From: Shea Levy <shea@shealevy.com>
MIME-Version: 1.0
To: Henrik Rydberg <rydberg@euromail.se>
CC: Gustavo Padovan <gustavo@padovan.org>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Add support for Apple vendor-specific devices
References: <1345915686-3915-1-git-send-email-rydberg@euromail.se> <50390B54.4040706@shealevy.com> <20120825174342.GA4057@polaris.bitmath.org>
In-Reply-To: <20120825174342.GA4057@polaris.bitmath.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi

On 08/25/2012 01:43 PM, Henrik Rydberg wrote:
> On Sat, Aug 25, 2012 at 01:28:52PM -0400, Shea Levy wrote:
>> Hello,
>>
>> On 08/25/2012 01:28 PM, Henrik Rydberg wrote:
>>> +	/* Apple-specific (Broadcom) devices */
>>> +	{ USB_VENDOR_AND_INTERFACE_INFO(0x05ac, 0xff, 0x01, 0x01) },
>>> +
>>>
>> Would this subsume https://lkml.org/lkml/2012/8/22/689 ?
> Yes, it will make 05ac:821d work as well. If you are able to test it
> successfully, we can append the commit message and add your Tested-by.

I'm getting a build error due to lack of USB_VENDOR_AND_INTERFACE_INFO 
macro when patching 3.5.2 with that patch. Which kernel tree should I 
patch with this patch to test?

> Thanks,
> Henrik
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Thanks,
Shea
