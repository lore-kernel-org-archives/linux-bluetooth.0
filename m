Return-Path: <cyrus@holtmann.org>
Date: Wed, 17 Jun 2015 22:02:10 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Simon Wood <simon@mungewell.org>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [Patch-V2] bccmd - add ability to read ADC
Message-ID: <20150617190210.GA17227@t440s.P-661HNU-F1>
References: <1434564761-6282-1-git-send-email-simon@mungewell.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1434564761-6282-1-git-send-email-simon@mungewell.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Simon,

On Wed, Jun 17, 2015, Simon Wood wrote:
> Some BlueCore devices are equipped with an 'Analogue In' pin which is
> internally connected to a MUX and ADC. This patch adds the ability to
> control the MUX and read the ADC.
> 
> The ADC is also connected internal to a temp sensor, which can also be
> read via this method.
> 
> The (only) MUX values expected to be used are:
> 1  Internal 1V25 reference
> 16 BlueCore01b pin Test_A; BlueCore2-External pin AIO0
> 17 BlueCore01b pin Test_B; BlueCore2-External pin AIO1
> 36 Chip’s internal temperature (change) sensor. BlueCore2-ROM and later only.
> 
> The MUX can also select other (undocumented) test points.
> 
> Example usage
> --
> $ ./bccmd -t HCI -d hci1 adc 17
> ADC value from Mux 0x11 : 0x0054 (valid)
> $ ./bccmd -t HCI -d hci1 adc 1
> ADC value from Mux 0x01 : 0x00b2 (valid)
> ---
>  tools/bccmd.c | 43 +++++++++++++++++++++++++++++++++++++++++++
>  tools/csr.h   |  2 ++
>  2 files changed, 45 insertions(+)

Applied. Thanks!

Johan
