Return-Path: <cyrus@holtmann.org>
Message-ID: <53E3B2AF.50605@intel.com>
Date: Thu, 07 Aug 2014 19:09:03 +0200
From: Loic Poulain <loic.poulain@intel.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [RFC] Bluetooth: HCI H5 fast retransmit
References: <1406911076-8714-1-git-send-email-loic.poulain@intel.com> <D672899E-220D-4633-A74A-9C50021C2AE8@holtmann.org>
In-Reply-To: <D672899E-220D-4633-A74A-9C50021C2AE8@holtmann.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

This patch is not so much out-of-scope of the H5 because specification
only gives "recommended parameters" regarding timeout calculation.

I tested it with only one H5 controller (rtl8723).
This mechanism is very beneficial with this controller due to a
relative high packet loss.

However I'm going to rework this patch to be more specific (only fast
retransmit if the invalid ack number is a duplicate of the last acked 
packet)
+ comments.

I don't see any obvious H5 incompatibility issue, therefore, extra flag
shouldn't be required.

Regards,
Loic

-- 
Intel Open Source Technology Center
http://oss.intel.com/

