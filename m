Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <54F70642BAB21D4498E1AA3EFE3D519A461012DA@rsex2.realsil.com.cn>
References: <CAD8Lp47=G8rFJtow9fn9WBg6FAyygopvYh7k0FNS0w8FgKXD6A@mail.gmail.com>
	<554E804F.9090407@lwfinger.net>
	<54F70642BAB21D4498E1AA3EFE3D519A461012DA@rsex2.realsil.com.cn>
Date: Tue, 12 May 2015 06:53:29 -0600
Message-ID: <CAD8Lp472ZD=2RBHD3boAgenEe6D=eqGh3dZugUDHR=-AW18BxA@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=E7=AD=94=E5=A4=8D=3A_Realtek_USB_bluetooth=3A_no_scan_results_w?=
	=?UTF-8?Q?hen_wifi_is_connected?=
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
	=?UTF-8?B?5q+b5Li66ZSL?= <jason_mao@realsil.com.cn>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Champion,

Thanks for the suggestion.

On Mon, May 11, 2015 at 8:54 PM, 陈艳萍 <champion_chen@realsil.com.cn> wrote:
> Dear Daniel,
>         For some reason, 8723B chip with single antenna and 2 antennas have different settings and this can only be modified manually.
> BT driver will set controller to use S0 when use 2 antennas.
>         In my submitted driver , there are following codes to add the config settings at the end of firmware to be downloaded.
> Would you please try to add these codes and test again?
>
> /*for 8723B,use S0 Anttena for bluetooth*/
>         if(lmp_version==ROM_LMP_8723B)
>         {
>                 memcpy(*buf+patch_entry->patch_length,RTK_CONFIG_SIGNATURE,6);
>                 if (USE_S0_ANTTENA)
>                         memcpy(*buf+patch_entry->patch_length+6,CONFIG_S0_ANTTENA,4);
>                 else
>                         memcpy(*buf+patch_entry->patch_length+6,CONFIG_S1_ANTTENA,4);
>                 *buf_len += 10;
>                 BT_DBG("USE_S0_ANTTENA");
>         }

Yes, I saw this code already and experimented with it. It didn't seem
to make any difference. I'll try again though, which configuration
should I use, CONFIG_S0_ANTTENA or CONFIG_S1_ANTTENA?

By only connecting one antenna at a time, I was able to see that
bluetooth happily uses either one. I have a feeling that the
preference you write above is overridden by code in the
halbtc8723b2ant.c btcoexist driver.

Daniel
