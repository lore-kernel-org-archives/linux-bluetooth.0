Return-Path: <cyrus@holtmann.org>
From: "Christian Hoene" <hoene@uni-tuebingen.de>
To: "'Luiz Augusto von Dentz'" <luiz.dentz@gmail.com>,
	<linux-bluetooth@vger.kernel.org>
Cc: "'Hagen Hentschel \(Ellisys\)'" <hagen.hentschel@ellisys.com>
References: <1293010548-25151-1-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1293010548-25151-1-git-send-email-luiz.dentz@gmail.com>
Subject: SBC loudness bug?
Date: Wed, 22 Dec 2010 15:14:16 +0100
Message-ID: <000601cba1e2$86077e70$92167b50$@de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

Mr. Hagen Hentschel was telling me that the BlueZ SBC implementation still has an bug. As compared to Bluetooth's reference implementation the signal is twotimes too silent. We told me, that in the last step of calculating the PCM samples a 1 bit right shift was done too much.

A correct implementation for C# can be found at http://sourceforge.net/projects/sbcsharp/

Sorry, due to time limits I cannot provide you with a patch...

With best regards,

 Christian Hoene



