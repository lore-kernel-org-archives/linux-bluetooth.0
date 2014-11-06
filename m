Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.0 \(1990.1\))
Subject: Re: [PATCH] Bluetooth: Clear role switch pending flag
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <088CC8BACB3382439E91D9919CE350242234A869@IRSMSX107.ger.corp.intel.com>
Date: Thu, 6 Nov 2014 08:50:30 -0800
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <C9221B05-4412-46FA-A77B-F7FE9037612F@holtmann.org>
References: <1415192160-5975-1-git-send-email-kubax.t.pawlak@intel.com> <7CB3B364-424E-4E98-9981-DD216A3BCAE8@holtmann.org> <088CC8BACB3382439E91D9919CE350242234A869@IRSMSX107.ger.corp.intel.com>
To: "Pawlak, KubaX T" <kubax.t.pawlak@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Kuba,

>> please sort these by opcode. I think we at least tried to have them in order of
>> opcode.
>> 
> 
> Actually opcodes sorting in this function looks like this:
> 0x0401
> 0x0405
> 0x0407
> 0x0411
> 0x0413
> 0x0419
> 0x041b
> 0x041c
> 0x0428
> 0x0803 <-  sniff mode
> 0x0804  <- exit sniff mode

please insert it here.

> 0x0406 <-disconnect
> 0x0435
> 0x0436
> 0x200d <- LE related
> 0x0219 
> 
> Mine is 0x080b so it goes at the end and the list needs resorting or in the middle after 0x0803 and 0x0804. 

And then please send a second patch that actually sorts these correctly. We try to do our best, but sometimes things slip through.

Regards

Marcel

