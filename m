Return-Path: <cyrus@holtmann.org>
Date: Tue, 23 Feb 2010 13:57:44 -0600
From: Caleb Katz <c2.katz@gmail.com>
To: Linux-Bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: Automatically connect to Bluetooth devices?
Message-ID: <20100223135744.3a6c04e1@shogun.epicvoyage.org>
In-Reply-To: <20100222074700.0c6e0b9c@shogun.epicvoyage.org>
References: <20100222074700.0c6e0b9c@shogun.epicvoyage.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hey,

I've made a little bit of progress. I can add the mouse through the
gnome-bluetooth interface and it will automatically reconnect. Keyboard
bonding does not work that way (it does not seem to accept the PIN when
entered on the keyboard):

bluetoothd[10443]: adapter_get_device(00:02:76:03:3A:EA)
bluetoothd[10443]: adapter_create_device(00:02:76:03:3A:EA)
bluetoothd[10443]: Creating device /org/bluez/10443/hci0/dev_00_02_76_03_3A_EA
bluetoothd[10443]: btd_device_ref(0xb7f3b9c0): ref=1
bluetoothd[10443]: /org/bluez/10443/hci0/dev_00_02_76_03_3A_EA: requesting bonding
bluetoothd[10443]: Temporary agent registered for /org/bluez/10443/hci0/dev_00_02_76_03_3A_EA at :1.54:/org/bluez/agent/wizard
bluetoothd[10443]: adapter_get_device(00:02:76:03:3A:EA)
bluetoothd[10443]: hcid_dbus_bonding_process_complete: status=05
bluetoothd[10443]: adapter_get_device(00:02:76:03:3A:EA)
bluetoothd[10443]: hcid_dbus_bonding_process_complete: no pending auth request
bluetoothd[10443]: Removing temporary device /org/bluez/10443/hci0/dev_00_02_76_03_3A_EA
bluetoothd[10443]: Releasing agent :1.54, /org/bluez/agent/wizard
bluetoothd[10443]: Removing device /org/bluez/10443/hci0/dev_00_02_76_03_3A_EA
bluetoothd[10443]: /org/bluez/10443/hci0/dev_00_02_76_03_3A_EA: canceling bonding request
bluetoothd[10443]: btd_device_unref(0xb7f3b9c0): ref=0
bluetoothd[10443]: device_free(0xb7f3b9c0)

Is there a tutorial somewhere? I don't even mind doing this from the
command line, but apparently I do not understand hcitool properly
either:

# hcitool info 00:02:76:03:3A:EA
Requesting information ...
	BD Address:  00:02:76:03:3A:EA
	Device Name: Rocketfish Bluetooth Keyboard
	LMP Version: 1.2 (0x2) LMP Subversion: 0x229
	Manufacturer: Broadcom Corporation (15)
	Features: 0xbc 0x02 0x04 0x38 0x08 0x00 0x00 0x00
		<encryption> <slot offset> <timing accuracy> <role switch> 
		<sniff mode> <RSSI> <power control> <enhanced iscan> 
		<interlaced iscan> <interlaced pscan> <AFH cap. slave> 
# hcitool cc 00:02:76:03:3A:EA
# hcitool auth 00:02:76:03:3A:EA
Not connected.
# hcitool cc 00:02:76:03:3A:EA;hcitool auth 00:02:76:03:3A:EA
HCI authentication request failed: Input/output error

About one second lapses between the "hcitool cc" command and when
bluetoothd drops the device information.

Thanks,

Caleb


On Mon, 22 Feb 2010 07:47:00 -0600
Caleb Katz <C2.Katz@gmail.com> wrote:

> Hey,
> 
> How do I make a Bluetooth keyboard and mouse connect automatically on system startup? If that is not possible (and I would understand security reasons why it would not be), how do I make Bluez/bluetoothd automatically accept their connections?
> 
> In a slightly longer form:
> 
> My Bluetooth keyboard and mouse are able to behave as a standard USB keyboard/mouse (where the Bluetooth connection is hidden from the hardware/software) but the extra features like the scroll wheel and media keys do not work. In order to use them, I have to configure both as Bluetooth devices.
> 
> It is easy enough to get them working. My distro (Slackware) already starts bluetoothd at boot, and the command "hidd --search --master" can find both after I press the "Connect" button on each. But that is the problem. I have to run a command after telling them to find the computer. When this combo is the only keyboard and mouse available, it is a little difficult to do that, especially when they automatically disconnect after a timeout in order to conserve battery power.
> 
> Last night I got frustrated and wrote a short script that is launched into the background by the local init script. I'm attaching it (rocketfish.sh) for critique but it does increase my system load slightly. Please tell me there is a better way.
> 
> I have the hardware address for the keyboard and mouse and have added this to my /etc/bluetooth/hcid.conf as someone elsewhere recommended (I have been unable to find documentation for it):
> 
> device 00:02:76:03:3A:EA {
> 	name "RocketFish Keyboard";
> 	auth enable;
> 	encrypt enable;
> }
> 
> device 00:02:76:0A:D2:2E {
> 	name "RocketFish Mouse";
> }
> 
> When I run "bluetoothd -n -d," there are messages that indicate it detects the keyboard and mouse -- even when a key is pressed -- but then it removes their temporary entry.
> 
> Obligatory system information:
> Slackware 13/kernel 2.6.29.5 (kernel was from pre-release)
> Bluez v4.47
> Keyboard and Mouse are models RF-BTKB2 and RF-BTMSE2
> My main.conf and hcid.conf are both attached.
> 
> Thanks,
> 
> Caleb
