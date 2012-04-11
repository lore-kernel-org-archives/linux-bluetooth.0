Return-Path: <cyrus@holtmann.org>
Date: Wed, 11 Apr 2012 12:51:33 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix registering hci with duplicate name
Message-ID: <20120411095131.GD17779@aemeltch-MOBL1>
References: <1334132612-29610-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1334135883.16897.94.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1334135883.16897.94.camel@aeonflux>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Apr 11, 2012 at 11:18:03AM +0200, Marcel Holtmann wrote:
> 
> Do we really need a separate function here. Can you just not fix this
> inline?

I have sent a new version, BTW is it OK to use unsigned long for bitmask? 
In netdev they use a page.

Best regards 
Andrei Emeltchenko 

