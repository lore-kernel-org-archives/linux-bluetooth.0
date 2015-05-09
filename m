Return-Path: <cyrus@holtmann.org>
Message-ID: <554E804F.9090407@lwfinger.net>
Date: Sat, 09 May 2015 16:46:55 -0500
From: Larry Finger <Larry.Finger@lwfinger.net>
MIME-Version: 1.0
To: Daniel Drake <drake@endlessm.com>,
	=?UTF-8?B?6ZmI6Imz6JCN?= <champion_chen@realsil.com.cn>
CC: Carlo Caione <carlo@endlessm.com>,
	Linux Bluetooth mailing list
	<linux-bluetooth@vger.kernel.org>,
	"shaofu@realtek.com >> shaofu" <shaofu@realtek.com>
Subject: Re: Realtek USB bluetooth: no scan results when wifi is connected
References: <CAD8Lp47=G8rFJtow9fn9WBg6FAyygopvYh7k0FNS0w8FgKXD6A@mail.gmail.com>
In-Reply-To: <CAD8Lp47=G8rFJtow9fn9WBg6FAyygopvYh7k0FNS0w8FgKXD6A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 05/09/2015 03:32 PM, Daniel Drake wrote:
> Hi Champion,
>
> I have a card here which has RTL8723BE wifi and bluetooth combined. 2 antennas.
>
> In linux-next (Linux 4.2) the bluetooth and wifi work fine separately,
> but when using them together, I can sometimes see a problem. This is
> using the btusb driver based on your code (now included in Linux 4.2),
> and the RTL8723B rtlwifi driver, all using the latest firmware in the
> linux-firmware git repo.
>
> To reproduce:
>   - Boot with no wifi connection active
>   - "hcitool scan" and verify that my laptop and phone can be seen
>   - Connect to wifi
>   - Run "hcitool scan" again a few times a minute, within 2-5 minutes
> normally my phone and laptop can no longer be seen
>   - Disconnect from wifi and immediately run "hcitool scan" again, my
> phone and laptop can be seen
>
> 3 interesting observations when the scan results are coming back empty:
>   1. I can still get the names of the remote devices by running
> "hcitool name <addr>"
>   2. I can still query the remote devices by running "hcitool info
> <addr>". After this, the scan suddenly starts working again!
>   3. Even though both of my local bluetooth devices no longer appear in
> scan results, I can sometimes see my neighbour's phone coming up as a
> scan result at this time.
>
> Anyway, disabling btcoexist avoids the issue, so I dug through that
> code, and found the exact line of code that seems to (sometimes) make
> us enter this strange mode.
>
> Call chain inside drivers/net/wireless/rtlwifi/btcoexist/halbtc8723b2ant.c:
> ex_btc8723b2ant_bt_info_notify (called when starting and finishing a BT scan)
> btc8723b2ant_run_coexist_mechanism
> btc8723b2ant_action_bt_inquiry
>
> As wifi is connected, we now call:
>          btc8723b2ant_ps_tdma(btcoexist, NORMAL_EXEC, true, 3);
>
> This is the function call that sometimes puts us into the mode where
> there are no scan results. Inside this function, if I comment out
> these lines in the turn_on section, the bug is avoided:
>
>          case 3:
>              //btc8723b2ant_set_fw_ps_tdma(btcoexist, 0xe3, 0x1c,
>              //                0x3, 0xf1, 0x90);
>              break;
>
> Any idea what is happening here? Can you help me find a better fix?

Daniel,

Do you see any adverse side effects when you comment out the "case 3" code?

As there has not been a lot of testing of wifi and BT with Realtek devices in 
the field, I expect to see a number of bugs like this.

I added Shao Fu (aka Rock) to the Cc list. He is the Realtek engineer 
responsible for the wifi driver.

Larry

