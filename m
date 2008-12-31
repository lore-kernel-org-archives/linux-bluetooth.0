Return-Path: <cyrus@holtmann.org>
Message-ID: <2d5a2c100812311304u562e6363wc16f1bdf28ac9552@mail.gmail.com>
Date: Wed, 31 Dec 2008 18:04:20 -0300
From: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
To: "Siarhei Siamashka" <siarhei.siamashka@nokia.com>
Subject: Re: [PATCH] Added possibility to analyze 4 blocks at once in SBC encoder
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <200812311729.30975.siarhei.siamashka@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <200812311729.30975.siarhei.siamashka@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Siarhei,


> Nevertheless, I think it is time to focus on performance :) The attached patch
> contains code preparations which are needed for SIMD optimizations for
> the analysis filter. Also theoretically it should be possible to tweak code to
> have both 32-bit and 16-bit fixed point analysis filter compiled in and switch
> between them at runtime (at user's request or semi-intelligently depending
> on audio bitrate).

Picking a implementation at runtime would be really great, that is why
I suggested using liboil in the other thread.


-- 
Luiz Augusto von Dentz
Engenheiro de Computação
