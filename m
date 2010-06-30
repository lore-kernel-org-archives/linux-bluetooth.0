Return-Path: <cyrus@holtmann.org>
Date: Wed, 30 Jun 2010 11:53:47 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Siarhei Siamashka <siarhei.siamashka@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Lennart Poettering <lennart@poettering.net>
Subject: Re: SBC encoder/decoder API & errors handling
Message-ID: <20100630085347.GA31839@jh-x301>
References: <201006291845.53998.siarhei.siamashka@gmail.com>
 <20100630075348.GA23471@jh-x301>
 <AANLkTildwDBZR2U6AtxGEiq4Mv-PBnDoqY1xfqHHmzL2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTildwDBZR2U6AtxGEiq4Mv-PBnDoqY1xfqHHmzL2@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Wed, Jun 30, 2010, Luiz Augusto von Dentz wrote:
> audio/pcm_bluetooth.c:1060:		encoded = sbc_encode(&a2dp->sbc,
> data->buffer, a2dp->codesize,
> audio/pcm_bluetooth.c:1096:		encoded = sbc_encode(&a2dp->sbc, buff,
> a2dp->codesize,

My patch already contained the fix for these two.

> audio/gstsbcenc.c:391:		consumed = sbc_encode(&enc->sbc, (gpointer) data,

This place actually passes NULL as the output parameter so no issue
there.

I'll push in a minute the fix in two separate commits (the libsbc
changes should be in an independent patch so they can easily be exported
to external copies like pulseaudio).

Johan
