Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <54F70642BAB21D4498E1AA3EFE3D519A46101882@rsex2.realsil.com.cn>
References: <CAD8Lp47=G8rFJtow9fn9WBg6FAyygopvYh7k0FNS0w8FgKXD6A@mail.gmail.com>
	<554E804F.9090407@lwfinger.net>
	<54F70642BAB21D4498E1AA3EFE3D519A461012DA@rsex2.realsil.com.cn>
	<CAD8Lp472ZD=2RBHD3boAgenEe6D=eqGh3dZugUDHR=-AW18BxA@mail.gmail.com>
	<54F70642BAB21D4498E1AA3EFE3D519A46101882@rsex2.realsil.com.cn>
Date: Thu, 21 May 2015 07:29:42 -0600
Message-ID: <CAD8Lp46p+UOS=usWpqhmPMW523Si36ZqTnogSki99Crg+=S0QQ@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IOetlOWkjTog562U5aSNOiBSZWFsdGVrIFVTQiBibHVldG9vdGg6IG5vIHNjYW4gcg==?=
	=?UTF-8?B?ZXN1bHRzIHdoZW4gd2lmaSBpcyBjb25uZWN0ZWQ=?=
From: Daniel Drake <drake@endlessm.com>
To: =?UTF-8?B?6ZmI6Imz6JCN?= <champion_chen@realsil.com.cn>
Cc: Larry Finger <Larry.Finger@lwfinger.net>,
	Carlo Caione <carlo@endlessm.com>,
	Linux Bluetooth mailing list
	<linux-bluetooth@vger.kernel.org>,
	"shaofu@realtek.com > shaofu" <shaofu@realtek.com>,
	=?UTF-8?B?5byg5b+X56Wl?= <askijerry_zhang@realsil.com.cn>,
	=?UTF-8?B?6ZmG5pyx5Lyf?= <alex_lu@realsil.com.cn>,
	Chih-Hsiang Wang <wangchihhs@realtek.com>,
	=?UTF-8?B?5q+b5Li66ZSL?= <jason_mao@realsil.com.cn>,
	pkshih@realtek.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, May 12, 2015 at 8:36 PM, 陈艳萍 <champion_chen@realsil.com.cn> wrote:
> Dear Daniel,
>         For  8723BU,       always use CONFIG_S0_ANTTENA；
>         For  8723BE ， 1 antenna CONFIG_S1_ANTTENA; 2 antennas CONFIG_S0_ANTTENA


I tested with CONFIG_S0_ANTENNA as I am using a 8723BE with 2 antennas.

I believe this configuration is having no effect. I tested as follows:

Built kernel without rtlwifi support.
Booted.
Disconnected both antennas.
Moved remote bluetooth device 2 metres away.
Ran "hcitool scan" --> no results. Good.
Connected antenna 1. Scan --> remote device can be seen
Disconnected antenna 1, connected antenna 2. Scan --> remote device can be seen

I then tried with CONFIG_S1_ANTENNA and then again without doing the
S0/S1 antenna config at all. The results are always the same. It seems
like the bluetooth interface is always using both antennas (hence it
can work even if one of them is disconnected).

Also, even with this antenna config in place, there is no affect on
the original issue: connecting to wifi still breaks the bluetooth scan
after a short while.

On Wed, May 13, 2015 at 1:51 AM, 陈艳萍 <champion_chen@realsil.com.cn> wrote:
> Dear Daniel,
> Please try to comment the following code in wifi driver halbtc8723b2ant_action_bt_inquiry()
> /*
>                 coex_dm->need_recover0x948 = true;
>                 coex_dm->backup0x948 = btcoexist->btc_read_4byte(btcoexist, 0x948);
>
>                 halbtc8723b2ant_set_ant_path(btcoexist, BTC_ANT_WIFI_AT_AUX, false, false);
>         */

This also makes no difference, the issue is still there.

Thanks
Daniel
