Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] prevent buffer overruns when parsing invalid OBEX
 frames
From: Marcel Holtmann <marcel@holtmann.org>
To: Iain Hibbert <plunky@rya-online.net>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1266433932.690365.3132.nullmailer@galant.ukfsn.org>
References: <1266433932.690365.3132.nullmailer@galant.ukfsn.org>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 17 Feb 2010 11:15:16 -0800
Message-ID: <1266434116.8849.67.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Iain,

> While I have git installed then, I found a problem recently where hcidump
> would dump core when parsing an OBEX packet. It turned out that the OBEX
> packet was faulty at my end (socket buffer exhausted), but the patch
> attached prevents the parsing code from running off the end of the buffer
> and receiving a SIGSEGV.
> 
> The patch does not make any complaint about the invalid frame, adding that
> would be a little more complex and I'm not sure its necessary?

patch has been applied. Thanks.

Regards

Marcel


