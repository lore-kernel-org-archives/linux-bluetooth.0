Return-Path: <cyrus@holtmann.org>
Message-ID: <2d5a2c100812220950i369f2c7aq5d7580f2a233eb0a@mail.gmail.com>
Date: Mon, 22 Dec 2008 14:50:51 -0300
From: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
To: "Marcel Holtmann" <marcel@holtmann.org>
Subject: Re: [PATCH] sbc: fix for overflow bug in quantization code
Cc: "Siarhei Siamashka" <siarhei.siamashka@nokia.com>,
	"ext Brad Midgley" <bmidgley@gmail.com>, jaska.uimonen@nokia.com,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
In-Reply-To: <1229948944.8047.3.camel@californication>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <200812172243.27442.siarhei.siamashka@nokia.com>
	 <2d5a2c100812191423g301a6aebr103d3602e8ec984c@mail.gmail.com>
	 <d89ddf300812191451q5a94a6b7n91423f1ce5a91a9f@mail.gmail.com>
	 <200812221337.53781.siarhei.siamashka@nokia.com>
	 <1229948944.8047.3.camel@californication>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

If I remember it correctly we announce our bitpool range 2-64 bits, so
if we could maintain a good quality in this scenarios there is no
reason to not adopt 16 bit.

-- 
Luiz Augusto von Dentz
Engenheiro de Computação
