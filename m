Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <45F17F5803927D43967AFEED068E781E0879D3C7@CAMEUREXM02.EUROPE.ROOT.PRI>
References: <45F17F5803927D43967AFEED068E781E0879D3C7@CAMEUREXM02.EUROPE.ROOT.PRI>
Date: Thu, 31 Jul 2014 11:10:51 +0300
Message-ID: <CABBYNZ+8XuHJjMFUMc-eXbVr7gKU5=ViwbqKgtSg-h5NT87oWA@mail.gmail.com>
Subject: Re: HoG: Support multi output report
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Murat Kilivan <Murat.Kilivan@csr.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Murat,

On Wed, Jul 30, 2014 at 5:34 PM, Murat Kilivan <Murat.Kilivan@csr.com> wrote:
> Hi,
>
> I have a BLE HID device which has 2 output reports and it is discovered properly by BlueZ. However, when I try to send an output report it always calls the first registered report id's handle. It doesn't matter what the first byte is in the message.
>
> How can I send to a different output report?
>
> I can supply any log/debug output if it is needed.

I had the impression that you would have to have another instance to
access the second output but perhaps we should check the report id but
then the question is how do you know what are the available report
ids? We never expose those to uHID so is this supposed to be
hardcoded?

Futhermore the HoG code has been changed in android/hog.c and at some
point it will be moved to src/shared so it can be reused by input
plugin.
