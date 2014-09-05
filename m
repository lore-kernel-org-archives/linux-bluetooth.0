Return-Path: <cyrus@holtmann.org>
Date: Fri, 5 Sep 2014 10:56:27 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?utf-8?B?6ZmI6Imz6JCN?= <champion_chen@realsil.com.cn>
Cc: Larry Finger <Larry.Finger@lwfinger.net>,
	Daniel Drake <drake@endlessm.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	Linux Bluetooth mailing list <linux-bluetooth@vger.kernel.org>,
	=?utf-8?B?6K645Yev5Yev?= <kyle_xu@realsil.com.cn>
Subject: Re: =?utf-8?B?562U5aSNOiDnrZTlpI06IOetlA==?= =?utf-8?B?5aSN?=
 =?utf-8?Q?=3A?= [PATCH v2] Bluetooth: btusb: Add Realtek 8723/8761 support
Message-ID: <20140905075627.GA8504@t440s>
References: <CAD8Lp45HbA03MycDVu6akTfEET_ZzxrwGpH1TbiQrw5Z178aeA@mail.gmail.com>
 <53B2D160.4010306@lwfinger.net>
 <F9E90F3A-5FE4-407C-833A-5E852A260984@holtmann.org>
 <54F70642BAB21D4498E1AA3EFE3D519A45FBED07@rsex2.realsil.com.cn>
 <B6A2794A-32D2-4D66-9D61-A27D7DA247B1@holtmann.org>
 <54F70642BAB21D4498E1AA3EFE3D519A45FBF299@rsex2.realsil.com.cn>
 <CAD8Lp44-=9RNWf2tfmCL14dWJRiZhGCtj042TprR7Q3m9hbNzA@mail.gmail.com>
 <54F70642BAB21D4498E1AA3EFE3D519A46010A1B@rsex2.realsil.com.cn>
 <54089665.1040302@lwfinger.net>
 <54F70642BAB21D4498E1AA3EFE3D519A460112CB@rsex2.realsil.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <54F70642BAB21D4498E1AA3EFE3D519A460112CB@rsex2.realsil.com.cn>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Champion,

On Fri, Sep 05, 2014, 陈艳萍 wrote:
> 	We found there was chance suspend failed in some platform.
> This is because btusb_suspend==> btusb_stop_traffic ==> usb_kill_anchored_urbs,
> 
> btusb_bulk_complete sometimes returns before system suspend and
> resubmit an urb, this will avoid system enter suspend state.
> I don't know whether this is the platform issue, there is a method to
> fix this by attached file.

This looks like a potentially good fix for btusb, however could you
please provide your patches in the format expected by upstream, i.e.
what you get with proper commits/commit messages and then sending the
patches using git format-patch and git send-email? The same applies for
any other patches you have for upstream inclusion. You'll also want to
ensure that the coding style is correct by reading
Documentation/CodingStyle and running scripts/checkpatch.pl on your
patches.

Johan
