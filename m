Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20141020134112.GA31414@t440s>
References: <1413290765-20398-1-git-send-email-fons@spotify.com>
 <1413290765-20398-2-git-send-email-fons@spotify.com> <20141020134112.GA31414@t440s>
From: Alfonso Acosta <fons@spotify.com>
Date: Mon, 20 Oct 2014 16:54:35 +0200
Message-ID: <CAHF=Y4paLv-te8TPTOO0=hFAi7iw-4JzGQSTJuzPDB1_CZX2EA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] core: Add Manufacturer Specific Data EIR field
To: Alfonso Acosta <fons@spotify.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

>
> This patch doesn't compile:
>
> In file included from android/bluetooth.c:45:0:
> ./src/eir.h:53:15: error: ‘HCI_MAX_EIR_LENGTH’ undeclared here (not in a function)
>   uint8_t data[HCI_MAX_EIR_LENGTH];
>                ^
> make[1]: *** [android/bluetooth.o] Error 1


I wasn't enabling android and this problem didn't surface otherwise.
v5 fixes this.

-- 
Alfonso Acosta

Embedded Systems Engineer at Spotify
Birger Jarlsgatan 61, Stockholm, Sweden
http://www.spotify.com
