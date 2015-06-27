Return-Path: <cyrus@holtmann.org>
Message-ID: <558DE8B3.3060102@gmail.com>
Date: Sat, 27 Jun 2015 02:05:07 +0200
From: Florian Grandel <fgrandel@gmail.com>
MIME-Version: 1.0
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Szymon Janc <Szymon.Janc@tieto.com>
CC: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Peripheral role support for android
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi guys,

the whole point of adding the multi adv feature to the kernel was trying 
to support the peripheral role on my nexus 4.

Now that multi adv made it into the kernel, I'd like to add the missing 
pieces to the android userspace sub-project in bluez.

Here are the todos I identified so far:

1) kernel backports: provide patches necessary to support the current 
linux-next master (I did this already... - patches all supplied to the 
backports project and msm kernel + modules compiled on my machine)

2) android/bluetooth: implement bt_le_read_adv_features() to retrieve 
num supported instances from the kernel

3) android/bluetooth: change prepare_le_features() to retrieve the max 
number of adv instances from the kernel and save it to the adapter 
struct - will use bt_le_read_adv_features()

4) android/gatt: change [un]register_app() to correctly manage app ids 
(aka instance ids) in the permitted range including appropriate error 
handling when the max number of instances is reached

5) android/bluetooth: implement bt_le_{add|remove}_advertising() to 
support the new multi-adv features in the kernel

6) android/gatt: implement the handle*multi_adv*() methods using 
bt_le_{add|remove}_advertising()

7) android/tester-{bluetooth|gatt}: write supporting tests

Do you agree that this should suffice to support basic advertising 
features in Lollipop? Is there anything important missing?

AFAICS there is (at least) one catch: the kernel does not support 
setting custom values for min/max adv interval, channel map, tx power, 
etc. while the HAL API seems to expect per-instance setup of these 
values. How should we deal with this? Should we ignore these values? Or 
should we error out with a NOT_SUPPORTED error if they are different 
from the kernel defaults?

Please let me know whether you agree to that roadmap and what you think 
about the unsupported features. Is it ok if I try to tackle these todos? 
Or is someone working on this already?

Florian
