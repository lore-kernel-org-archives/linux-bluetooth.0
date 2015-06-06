Return-Path: <cyrus@holtmann.org>
Subject: Re: [Patch] bccmd - add ability to read ADC
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Content-Type: text/plain; charset=iso-8859-1
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <53e48edc3040ae4a82e3beaf06c692e1.squirrel@mungewell.org>
Date: Sat, 6 Jun 2015 07:49:37 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <06F67222-BAF1-455D-A4B8-4560FE84EE69@holtmann.org>
References: <53e48edc3040ae4a82e3beaf06c692e1.squirrel@mungewell.org>
To: simon@mungewell.org
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Simon,

> Some BlueCore devices are equipped with an 'Analogue In' pin which is
> internally connected to a MUX and ADC. This patch adds the ability to
> control the MUX and read the ADC.
> 
> The ADC is also connected internal to a temp sensor, which can also be
> read via this method.
> 
> The (only) MUX values expected to be used are:
> 1 Internal 1V25 reference
> 16 BlueCore01b pin Test_A; BlueCore2-External pin AIO0
> 17 BlueCore01b pin Test_B; BlueCore2-External pin AIO1
> 36 Chip’s internal temperature (change) sensor. BlueCore2-ROM and later only.
> 
> The MUX can also select other (undocumented) test points.
> 
> Example usage
> --
> # ./bccmd -t HCI -d hci1 adc 17
> ADC value from Mux 0x11 : 0x0054 (valid)
> # ./bccmd -t HCI -d hci1 adc 1
> ADC value from Mux 0x01 : 0x00b2 (valid)

please send a patch created via git format-patch.

Regards

Marcel

