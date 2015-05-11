Return-Path: <cyrus@holtmann.org>
Message-ID: <5550CD07.1000105@lwfinger.net>
Date: Mon, 11 May 2015 10:38:47 -0500
From: Larry Finger <Larry.Finger@lwfinger.net>
MIME-Version: 1.0
To: Daniel Drake <drake@endlessm.com>
CC: =?UTF-8?B?6ZmI6Imz6JCN?= <champion_chen@realsil.com.cn>,
	Carlo Caione <carlo@endlessm.com>,
	Linux Bluetooth mailing list
	<linux-bluetooth@vger.kernel.org>,
	"shaofu@realtek.com >> shaofu" <shaofu@realtek.com>
Subject: Re: Realtek USB bluetooth: no scan results when wifi is connected
References: <CAD8Lp47=G8rFJtow9fn9WBg6FAyygopvYh7k0FNS0w8FgKXD6A@mail.gmail.com>	<554E804F.9090407@lwfinger.net> <CAD8Lp46ueGkGvit9CZ_vm+kTWSm30xXvsf0E8eaQ=oeA8j=nUw@mail.gmail.com>
In-Reply-To: <CAD8Lp46ueGkGvit9CZ_vm+kTWSm30xXvsf0E8eaQ=oeA8j=nUw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 05/11/2015 08:36 AM, Daniel Drake wrote:
> Hi Larry,
>
> On Sat, May 9, 2015 at 3:46 PM, Larry Finger <Larry.Finger@lwfinger.net> wrote:
>> Do you see any adverse side effects when you comment out the "case 3" code?
>
> No, it fixes the scan results issue and I also tested a simultaneous
> download over wifi while sending a file over bluetooth. Seems to be
> working fine.

OK. As I know you are busy, I will submit the patch to 
linux-wireless@vger.kernel.org for you.

Larry

