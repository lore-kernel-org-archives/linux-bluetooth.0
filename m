Return-Path: <cyrus@holtmann.org>
Message-ID: <45744.32314.qm@web161808.mail.bf1.yahoo.com>
References: <4D7BB10B.3080100@gmail.com> <1300301086-22653-1-git-send-email-padovan@profusion.mobi> <20110316184639.GA2151@joana> <AANLkTimNeqvBMnb55x10LrwXncx1CnV=OLBUCBJXaGpx@mail.gmail.com> <20110316190154.GB2151@joana> <4D810B4E.7040702@gmail.com> <20110316191540.GC2151@joana> <AANLkTi=NCL2mWhLfnjD85Zp2y9SYFf6Dx5K0A8ckK7CX@mail.gmail.com>
Date: Wed, 16 Mar 2011 14:13:25 -0700 (PDT)
From: Mikko Vinni <mmvinni@yahoo.com>
Subject: Re: [PATCH] Bluetooth: Fix HCI_RESET command syncronization
To: Justin Mattock <justinmattock@gmail.com>,
	Anderson Lizardo <anderson.lizardo@openbossa.org>,
	linux-bluetooth@vger.kernel.org, edt@aei.ca
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>
In-Reply-To: <AANLkTi=NCL2mWhLfnjD85Zp2y9SYFf6Dx5K0A8ckK7CX@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Justin Mattock wrote:

> o.k. works over here..
> Tested-by:  Justin P. Mattock <justinmattock@gmail.com>

Works for me too (tested with the (original) patch applied on top of 
bluetooth-next
merged on 2.6.38).

Tested-by: Mikko Vinni <mmvinni@yahoo.com>


Thanks for solving the problem!

Mikko


> 
> here  is an updated patch for the current Mainline if anybody needs  it:
> 
...


      
