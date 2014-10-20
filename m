Return-Path: <cyrus@holtmann.org>
Date: Mon, 20 Oct 2014 15:41:12 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Alfonso Acosta <fons@spotify.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v4 1/2] core: Add Manufacturer Specific Data EIR field
Message-ID: <20141020134112.GA31414@t440s>
References: <1413290765-20398-1-git-send-email-fons@spotify.com>
 <1413290765-20398-2-git-send-email-fons@spotify.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1413290765-20398-2-git-send-email-fons@spotify.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alfonso,

On Tue, Oct 14, 2014, Alfonso Acosta wrote:
> Add data structure and parsing support.
> ---
>  src/eir.c | 22 ++++++++++++++++++++++
>  src/eir.h |  8 ++++++++
>  2 files changed, 30 insertions(+)

This patch doesn't compile:

In file included from android/bluetooth.c:45:0:
./src/eir.h:53:15: error: ‘HCI_MAX_EIR_LENGTH’ undeclared here (not in a function)
  uint8_t data[HCI_MAX_EIR_LENGTH];
               ^
make[1]: *** [android/bluetooth.o] Error 1

Johan
