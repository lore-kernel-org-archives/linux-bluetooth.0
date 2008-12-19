Return-Path: <cyrus@holtmann.org>
Message-ID: <2d5a2c100812191423g301a6aebr103d3602e8ec984c@mail.gmail.com>
Date: Fri, 19 Dec 2008 19:23:00 -0300
From: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
To: "Siarhei Siamashka" <siarhei.siamashka@nokia.com>, jaska.uimonen@nokia.com
Subject: Re: [PATCH] sbc: fix for overflow bug in quantization code
Cc: "ext Marcel Holtmann" <marcel@holtmann.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
In-Reply-To: <200812192325.46796.siarhei.siamashka@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <200812172243.27442.siarhei.siamashka@nokia.com>
	 <1229641160.17082.0.camel@violet>
	 <200812192325.46796.siarhei.siamashka@nokia.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Siarhei, Jaska,

So what about the subband filters fixes and 16 bit fixed point, do you
thing it can be done? I left this out since the last patch was only
dealing with 8 subband and was 32 bit.

--=20
Luiz Augusto von Dentz
Engenheiro de Computa=E7=E3o
