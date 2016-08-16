Return-Path: <guodong.xu@linaro.org>
MIME-Version: 1.0
In-Reply-To: <1394C970-3726-4C42-A06D-0B3B3015D980@holtmann.org>
References: <1469939084-15603-1-git-send-email-guodong.xu@linaro.org> <1394C970-3726-4C42-A06D-0B3B3015D980@holtmann.org>
From: Guodong Xu <guodong.xu@linaro.org>
Date: Tue, 16 Aug 2016 17:30:21 +0800
Message-ID: <CAFGCpxz6j_7aOTX+uShdpyxmt71k61v=Abdw=7MfrRjvdygmTg@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: Add LED triggers for HCI frames tx and rx
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	"open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi, Marcel

On 16 August 2016 at 14:03, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Guodong,
>
>> Two LED triggers are added into hci_dev: tx_led and rx_led. Upon ACL/SCO
>> packets available in tx or rx, the LEDs will blink.
>>
>> For each hci registration, two triggers are added into LED subsystem:
>> [hdev->name]-tx and [hdev-name]-rx.
>> Refer to Documentation/leds/leds-class.txt for usage.
>>
>> Verified on HiKey 96boards, which uses HiSilicon hi6220 SoC and TI
>> WL1835 WiFi/BT combo chip.
>
> so I have no idea what to do with adding adding hci0-rx and hci0-tx trigg=
ers. Combined with hci0-power trigger these are already 3 triggers. And if =
you have 2 Bluetooth controllers in your system, then you have 6 triggers.
>

True, 6 triggers. But, taking example for other subsytems, eg. cpu
cores. On my board, I have "heartbeat cpu0 cpu1 cpu2 cpu3 cpu4 cpu5
cpu6 cpu7". It doesn't have to mean you need all of them connected to
some LED(s). Actually, in most of the case, I only need heartbeat.



> If we then maybe add another trigger, then this number just goes up and u=
p.
>
> As far as I can tell you can only assign a single trigger to a LED.
>

That's true. And people got a choice of which feature he wants to visualize=
.

> So this means to even use these triggers, you need now 3 LEDs per Bluetoo=
th controller. How is that useful for anybody in a real system? Maybe I am =
missing something here and somehow there is magic to combine triggers, but =
I have not found it yet. So please someone enlighten me on how this is supp=
ose to be used with real devices.
>
> Recently I have added a simple bluetooth-power trigger that combines all =
Bluetooth controllers into a single trigger. If any of them is enabled, the=
n you can control your LED. Which makes a lot more sense to me since you mo=
st likely have a single Bluetooth LED on your system. And you want it to sh=
ow the correct state no matter what Bluetooth controller is in use. However=
 I can see the case that someone might want to assign one specific Bluetoot=
h controller to a LED status.
>
> So instead of adding many independent triggers to each controller, why no=
t create one global bluetooth trigger and one individual bluetooth-hci0 tri=
gger for each controller. And the combine power, tx, rx and whatever else w=
e need to trigger the LED for?
>

When I starting this work, I referred to WiFi system. See
CONFIG_MAC80211_LEDS. WiFi system implements these types of triggers "
phy0rx phy0tx phy0assoc phy0radio" for each 'controller'.

Besides, there are also RFKILL which stands for WiFi/BT power status.
RFKILL adds triggers for each module too. Eg. in the below example, I
have one WiFi (phy0), one BT (hci0). Trigger rfkill1 equals to
hci0-power.

Ref: here are all LED triggers I found in my 96boards/HiKey:

# cat trigger
none kbd-scrollock kbd-numlock kbd-capslock kbd-kanalock kbd-shiftlock
kbd-altgrlock kbd-ctrllock kbd-altlock kbd-shiftllock kbd-shiftrlock
kbd-ctrlllock kbd-ctrlrlock mmc0 mmc1 heartbeat cpu0 cpu1 cpu2 cpu3
cpu4 cpu5 cpu6 cpu7 mmc2 rfkill0 phy0rx phy0tx phy0assoc phy0radio
hci0-power hci0-tx [hci0-rx] rfkill1

-Guodong

> Regards
>
> Marcel
>
