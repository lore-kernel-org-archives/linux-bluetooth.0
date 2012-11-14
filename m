Return-Path: <cyrus@holtmann.org>
Message-ID: <50A37388.7050607@invoxia.com>
Date: Wed, 14 Nov 2012 11:33:44 +0100
From: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
MIME-Version: 1.0
To: frederic.dalleau@linux.intel.com
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC] Bluetooth: Add BT_DEFER_SETUP option to sco socket
References: <1352830825-13987-1-git-send-email-frederic.dalleau@linux.intel.com> <1352830825-13987-2-git-send-email-frederic.dalleau@linux.intel.com> <50A36DD1.1080507@invoxia.com> <50A3700C.6090801@linux.intel.com>
In-Reply-To: <50A3700C.6090801@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

What is your plan once the kernel will gain the defer capability.
- is it up to bluetoothd/audio to accept and configure ?
- is it the external HFP apps (for the HFP case) to do the job ?

arnaud

On 11/14/2012 11:18 AM, Frédéric Dalleau wrote:
> Hi Arnaud,
>
> On 11/14/2012 11:09 AM, Arnaud Mouiche wrote:
>> Hello,
>> I will try to find some time to try your patch.
>
> It is a bit early since I haven't tested it myself, should be in much
> better shape before end of the week.
>
> Regards,
> Frédéric

