Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <554E804F.9090407@lwfinger.net>
References: <CAD8Lp47=G8rFJtow9fn9WBg6FAyygopvYh7k0FNS0w8FgKXD6A@mail.gmail.com>
	<554E804F.9090407@lwfinger.net>
Date: Mon, 11 May 2015 07:36:43 -0600
Message-ID: <CAD8Lp46ueGkGvit9CZ_vm+kTWSm30xXvsf0E8eaQ=oeA8j=nUw@mail.gmail.com>
Subject: Re: Realtek USB bluetooth: no scan results when wifi is connected
From: Daniel Drake <drake@endlessm.com>
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: =?UTF-8?B?6ZmI6Imz6JCN?= <champion_chen@realsil.com.cn>,
	Carlo Caione <carlo@endlessm.com>,
	Linux Bluetooth mailing list
	<linux-bluetooth@vger.kernel.org>,
	"shaofu@realtek.com >> shaofu" <shaofu@realtek.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Larry,

On Sat, May 9, 2015 at 3:46 PM, Larry Finger <Larry.Finger@lwfinger.net> wrote:
> Do you see any adverse side effects when you comment out the "case 3" code?

No, it fixes the scan results issue and I also tested a simultaneous
download over wifi while sending a file over bluetooth. Seems to be
working fine.

Daniel
