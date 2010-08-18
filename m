Return-Path: <cyrus@holtmann.org>
Message-ID: <4C6BE410.1020505@csr.com>
Date: Wed, 18 Aug 2010 14:45:52 +0100
From: David Vrabel <david.vrabel@csr.com>
MIME-Version: 1.0
To: Mat Martineau <mathewm@codeaurora.org>
CC: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        rshaffer@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/1] Bluetooth:  Add socket option definitions for AMP
References: <1282086426-8423-1-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1282086426-8423-1-git-send-email-mathewm@codeaurora.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Mat Martineau wrote:
> This adds a new BT_AMP socket option to control the use of AMP channels.
> It is for use with the SOL_BLUETOOTH option level on L2CAP sockets.
> 
> Available option values are defined as:
> 
> [lots of nice documentation]

Why is none of this documentation in the code?

I believe we also agreed that this policy could be changed at any point
in the life time of the channel so this should be documented as well.

> +#define BT_AMP		8

Suggest BT_AMP_POLICY, BT_AMP_POLICY_REQUIRE_BR_EDR etc.  Just in case
there are other AMP related socket options in the future.

> +#define BT_AMP_REQUIRE_BR_EDR	0
> +#define BT_AMP_PREFER_AMP	1
> +#define BT_AMP_PREFER_BR_EDR	2

David
-- 
David Vrabel, Senior Software Engineer, Drivers
CSR, Churchill House, Cambridge Business Park,  Tel: +44 (0)1223 692562
Cowley Road, Cambridge, CB4 0WZ                 http://www.csr.com/


Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
