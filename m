Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: Peripheral role support for android
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <558DE8B3.3060102@gmail.com>
Date: Mon, 29 Jun 2015 15:52:29 +0200
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Szymon Janc <Szymon.Janc@tieto.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <650B748F-76F8-4031-9397-E65D18AD01A4@holtmann.org>
References: <558DE8B3.3060102@gmail.com>
To: Florian Grandel <fgrandel@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Florian,

> the whole point of adding the multi adv feature to the kernel was trying to support the peripheral role on my nexus 4.
> 
> Now that multi adv made it into the kernel, I'd like to add the missing pieces to the android userspace sub-project in bluez.
> 
> Here are the todos I identified so far:
> 
> 1) kernel backports: provide patches necessary to support the current linux-next master (I did this already... - patches all supplied to the backports project and msm kernel + modules compiled on my machine)
> 
> 2) android/bluetooth: implement bt_le_read_adv_features() to retrieve num supported instances from the kernel
> 
> 3) android/bluetooth: change prepare_le_features() to retrieve the max number of adv instances from the kernel and save it to the adapter struct - will use bt_le_read_adv_features()
> 
> 4) android/gatt: change [un]register_app() to correctly manage app ids (aka instance ids) in the permitted range including appropriate error handling when the max number of instances is reached

I think that this might need a simple mapping table. The instance ids from the kernel might not be the application ids handed out over the HAL.

> 5) android/bluetooth: implement bt_le_{add|remove}_advertising() to support the new multi-adv features in the kernel
> 
> 6) android/gatt: implement the handle*multi_adv*() methods using bt_le_{add|remove}_advertising()
> 
> 7) android/tester-{bluetooth|gatt}: write supporting tests
> 
> Do you agree that this should suffice to support basic advertising features in Lollipop? Is there anything important missing?

I do not think you are missing anything. Just get cracking and submit patches.

> AFAICS there is (at least) one catch: the kernel does not support setting custom values for min/max adv interval, channel map, tx power, etc. while the HAL API seems to expect per-instance setup of these values. How should we deal with this? Should we ignore these values? Or should we error out with a NOT_SUPPORTED error if they are different from the kernel defaults?

We never exposed the channel map since that is pretty much stupid. I would just ignore that parameter. Just accept whatever it asks of and see okay, I will do it, even if you don't in the end.

The TX power you could set whatever you want, but I would advise against it. Just accept the TX power you get from the HAL and then set Include TX Power flag. I mean the best you can do is check if TX Power is included or not. And allow the advertising data to reflect this.

And min/max advertising interval is also something you should ignore. Actually that is something an application should never be in control of anyway. Choosing bad parameters might cause the controller to make a choice between BR/EDR and LE in its schedule. And for obvious reasons, the application has not knowledge of the BR/EDR state. So just accept them and go on with it.

> Please let me know whether you agree to that roadmap and what you think about the unsupported features. Is it ok if I try to tackle these todos? Or is someone working on this already?

Go ahead.

Regards

Marcel

