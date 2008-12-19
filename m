Return-Path: <cyrus@holtmann.org>
Message-ID: <d89ddf300812191451q5a94a6b7n91423f1ce5a91a9f@mail.gmail.com>
Date: Fri, 19 Dec 2008 15:51:52 -0700
From: "Brad Midgley" <bmidgley@gmail.com>
To: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
Subject: Re: [PATCH] sbc: fix for overflow bug in quantization code
Cc: "Siarhei Siamashka" <siarhei.siamashka@nokia.com>, jaska.uimonen@nokia.com,
	"ext Marcel Holtmann" <marcel@holtmann.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
In-Reply-To: <2d5a2c100812191423g301a6aebr103d3602e8ec984c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <200812172243.27442.siarhei.siamashka@nokia.com>
	 <1229641160.17082.0.camel@violet>
	 <200812192325.46796.siarhei.siamashka@nokia.com>
	 <2d5a2c100812191423g301a6aebr103d3602e8ec984c@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Luiz,

> So what about the subband filters fixes and 16 bit fixed point, do you
> thing it can be done? I left this out since the last patch was only
> dealing with 8 subband and was 32 bit.

FYI, I made some testing changes some time ago from 32-bit to 16-bit
integers that didn't improve performance on arm at all... we shouldn't
sacrifice quality for no real improvement in performance.

The story may be different on a mips etc core, but I think we should
realize real performance improvements in order to justify lowering
fidelity.

Brad
