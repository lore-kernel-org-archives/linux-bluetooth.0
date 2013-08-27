Return-Path: <cyrus@holtmann.org>
From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To: Tedd Ho-Jeong An <tedd.an@intel.com>
Cc: dwmw2@infradead.org, ben@decadent.org.uk,
	david.woodhouse@intel.com, linux-bluetooth@vger.kernel.org
Subject: Re: linux-firmware: update Intel Bluetooth firmware patch file
References: <2050211.gNpUdmFyHg@tedd-ubuntu>
Date: Tue, 27 Aug 2013 21:33:56 +0200
In-Reply-To: <2050211.gNpUdmFyHg@tedd-ubuntu> (Tedd Ho-Jeong An's message of
	"Tue, 27 Aug 2013 09:58:14 -0700")
Message-ID: <8738pv3p3v.fsf@nemi.mork.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Tedd Ho-Jeong An <tedd.an@intel.com> writes:

> From: Tedd Ho-Jeong An <tedd.an@intel.com>
>
> build version: 1334_02
> firmware patch version: 2e
>
> This patch fixes the following issues:
> - Send invalid SCO connection handle
> - Device goes into unexpected states while streaming A2DP audio
> - HCI command buffer is overwritten by the following USB autosuspend command

Just wanted to confirm that this firmware fixes the autosuspend issues
I observed.  Thanks!


Bjørn
