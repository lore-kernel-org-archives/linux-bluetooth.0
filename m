Return-Path: <cyrus@holtmann.org>
Date: Sat, 14 Feb 2015 22:57:27 +0100
From: Alexander Aring <alex.aring@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>,
	linux-wpan@vger.kernel.org, kernel@pengutronix.de,
	Jukka Rissanen <jukka.rissanen@linux.intel.com>,
	Martin Townsend <mtownsend1973@gmail.com>,
	Stefan Schmidt <s.schmidt@samsung.com>
Subject: Re: [PATCHv5 bluetooth-next 0/3] 6lowpan: introduce nhc framework
Message-ID: <20150214215724.GA18210@omega>
References: <1420818179-18585-1-git-send-email-alex.aring@gmail.com>
 <777F808E-9C18-4C35-8C1C-4FD732F4FDC1@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <777F808E-9C18-4C35-8C1C-4FD732F4FDC1@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, Feb 14, 2015 at 01:46:43PM -0800, Marcel Holtmann wrote:
...
> 
> so I collected the reviewed-by and acked-by statements, but when I did a simple compile test it failed badly.
> 
>   CC      net/6lowpan/nhc.o
> net/6lowpan/nhc.c: In function ‘lowpan_nhc_add’:
> net/6lowpan/nhc.c:206:2: warning: format ‘%d’ expects argument of type ‘int’, but argument 4 has type ‘size_t’ [-Wformat=]
>   WARN_ONCE(nhc->idlen > LOWPAN_NHC_MAX_ID_LEN,
>   ^
> 

mhh, okay. Should be fixed with a conversion from "%d" -> "%zd". I will
resend a new series with this fix. Thanks.

- Alex
