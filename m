Return-Path: <cyrus@holtmann.org>
Date: Thu, 17 Nov 2011 10:59:07 +0200
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 6/6] Bluetooth: Support LE-Only discovery procedure
Message-ID: <20111117085904.GB415@aemeltch-MOBL1>
References: <1321051824-5216-1-git-send-email-andre.guedes@openbossa.org>
 <1321051824-5216-7-git-send-email-andre.guedes@openbossa.org>
 <20111114100806.GC13665@aemeltch-MOBL1>
 <95D6271C-626F-409E-B4AB-92F6C7E2AC15@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <95D6271C-626F-409E-B4AB-92F6C7E2AC15@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Wed, Nov 16, 2011 at 05:36:38PM -0300, Andre Guedes wrote:

...

> >> 
> >> 	if (cp->enable == 0x01) {
> > 
> > Can we fix also magic number here and below?
> 
> I see your point here, but this is not a magic number, it is
> just a true/false value.

If this true/false no need to compare with hex numbers why not

if(cp->enable) 
	...

Best regards 
Andrei Emeltchenko 
