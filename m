Return-Path: <cyrus@holtmann.org>
From: "Henrik Rydberg" <rydberg@euromail.se>
Date: Sat, 25 Aug 2012 19:43:42 +0200
To: Shea Levy <shea@shealevy.com>
Cc: Gustavo Padovan <gustavo@padovan.org>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Add support for Apple vendor-specific devices
Message-ID: <20120825174342.GA4057@polaris.bitmath.org>
References: <1345915686-3915-1-git-send-email-rydberg@euromail.se>
 <50390B54.4040706@shealevy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <50390B54.4040706@shealevy.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sat, Aug 25, 2012 at 01:28:52PM -0400, Shea Levy wrote:
> Hello,
> 
> On 08/25/2012 01:28 PM, Henrik Rydberg wrote:
> >+	/* Apple-specific (Broadcom) devices */
> >+	{ USB_VENDOR_AND_INTERFACE_INFO(0x05ac, 0xff, 0x01, 0x01) },
> >+
> >
> 
> Would this subsume https://lkml.org/lkml/2012/8/22/689 ?

Yes, it will make 05ac:821d work as well. If you are able to test it
successfully, we can append the commit message and add your Tested-by.

Thanks,
Henrik
