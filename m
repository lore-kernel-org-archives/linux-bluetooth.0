Return-Path: <cyrus@holtmann.org>
Message-ID: <50A36E06.2060206@linux.intel.com>
Date: Wed, 14 Nov 2012 11:10:14 +0100
From: =?UTF-8?B?RnLDqWTDqXJpYyBEYWxsZWF1?=
	<frederic.dalleau@linux.intel.com>
Reply-To: frederic.dalleau@linux.intel.com
MIME-Version: 1.0
To: Michael Knudsen <m.knudsen@samsung.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC] Bluetooth: Add BT_DEFER_SETUP option to sco socket
References: <1352830825-13987-1-git-send-email-frederic.dalleau@linux.intel.com> <1352830825-13987-2-git-send-email-frederic.dalleau@linux.intel.com> <50A355CF.4030809@samsung.com>
In-Reply-To: <50A355CF.4030809@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michael,

On 11/14/2012 09:26 AM, Michael Knudsen wrote:

> My idea is to define (I'm not sure if this is exactly the same as what you
> suggested yourself) a bit, LM_DEFER, that e.g. sco_connect_ind() may return
> and propagate this bit to hci_conn_request_evt().  This way all policing of
> accepting SCO connections is handled from a single entry point into sco.c.

You detailed it much further than I did, but yes it is the same idea. I 
fully support it! If everybody agrees, then I can update the patch.

hci.h would receive the folowing line:

+ #define HCI_LM_DEFER   0x4000

Best regards,
Frédéric
