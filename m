Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: Realtek USB bluetooth: no scan results when wifi is connected
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <72D8F8BA10DE0C4E808578817FAC1EE3D7C207@RTITMBSV05.realtek.com.tw>
Date: Sat, 6 Jun 2015 07:07:10 +0200
Cc: Larry Finger <Larry.Finger@lwfinger.net>,
	Daniel Drake <drake@endlessm.com>,
	Champion_chen <champion_chen@realsil.com.cn>,
	Carlo Caione <carlo@endlessm.com>,
	Linux Bluetooth mailing list
	<linux-bluetooth@vger.kernel.org>,
	askijerry_zhang <askijerry_zhang@realsil.com.cn>,
	alex_lu <alex_lu@realsil.com.cn>,
	Chih-Hsiang Wang <wangchihhs@realtek.com>,
	jason_mao <jason_mao@realsil.com.cn>, Pkshih <pkshih@realtek.com>
Message-Id: <B5214E80-EB9C-4B76-9BCF-EBD527EFE446@holtmann.org>
References: <CAD8Lp47=G8rFJtow9fn9WBg6FAyygopvYh7k0FNS0w8FgKXD6A@mail.gmail.com> <554E804F.9090407@lwfinger.net> <54F70642BAB21D4498E1AA3EFE3D519A461012DA@rsex2.realsil.com.cn> <CAD8Lp472ZD=2RBHD3boAgenEe6D=eqGh3dZugUDHR=-AW18BxA@mail.gmail.com> <54F70642BAB21D4498E1AA3EFE3D519A46101882@rsex2.realsil.com.cn> <CAD8Lp46p+UOS=usWpqhmPMW523Si36ZqTnogSki99Crg+=S0QQ@mail.gmail.com> <54F70642BAB21D4498E1AA3EFE3D519A4610F810@rsex2.realsil.com.cn> <C14314D4-41CF-4FCE-9C3F-F3352FDF0F6A@holtmann.org> <CAD8Lp44Au=AenfG9EnLAJJ8dw7kientAoKppEMh7U2wY73pSQg@mail.gmail.com> <6156899E-F971-46CC-A3D9-6DDDFA9FDC4B@holtmann.org> <55673B25.1030801@lwfinger.net> <72D8F8BA10DE0C4E808578817FAC1EE3D7C207@RTITMBSV05.realtek.com.tw>
To: Shaofu <shaofu@realtek.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Shaofu,

please do not top-post on this mailing list.

> As Marcel said, some Realtek WiFi + BT solution are two chips solution.
> - 1 chip solution: 8723BE, 8821AE
> - 2 chips solution: 8812AE + 8761AU, 8192EE + 8761AU
> 
> Even in 2 chips solution, there are some difference:
> - Hardware connected in module: 8192EE + 8761AU
> - Independent, need SW involved, even in the same module: 8812AE + 8761AU
> 
> In 1 chip or hardware connected solution, both driver don't need communicate,
> BTcoex driver knows everything via HW event, and control everything it wants.
> 
> In 2 chips and independent solution, yes, its our problem. In this case, we need 
> some communication mechanism between drivers. The rfres subsystem seems 
> good, but it takes time. If other simple methods can do, please tell us.

there is no simple method. You need to retrieve the current WiFi channels in use from the WiFi subsystem and handle the update of the AFH channel based on that.

Regards

Marcel

