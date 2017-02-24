Return-Path: <morisset.hugues@gmail.com>
Subject: Re: Bose Quiet Comfort 35 Remaining Battery Reporting
To: Sebastian Reichel <sre@kernel.org>,
 Linux-Bluetooth <linux-bluetooth@vger.kernel.org>
References: <20170213055504.kworoylsusadecl7@earth>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Marcel Holtmann <marcel@holtmann.org>
From: Hugues <morisset.hugues@gmail.com>
Message-ID: <1415ce15-3e92-3695-4d83-aac96e442ec1@gmail.com>
Date: Fri, 24 Feb 2017 12:01:40 +0100
MIME-Version: 1.0
In-Reply-To: <20170213055504.kworoylsusadecl7@earth>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,
Thanks a lot!
I tried to connect to the headset through dbus to make the AT commands,
but failed.
So what's the services/program where this should be implemented so it
can be exposed on dbus and picked up by the Desktop Environment?

Regards,
Hugues

On 02/13/2017 06:55 AM, Sebastian Reichel wrote:
> Hi,
> 
> FWIW I was also interested in battery level of my Bose QC35 and
> checked this some time ago. That time I only checked the low
> energy stuff, since the Android application seems to know the
> battery status with only LE being connected.
> 
> Marcel Holtman wrote:
>>> This headset do have dual mode, I searched around using gatttool ant the
>>> gatt specification but I find nothing about Battery Level
>>> (org.bluetooth.characteristic.battery_level.xml) or Battery Service
>>> (org.bluetooth.service.battery_service.xml).
> 
> Bose QC35 does not expose battery status through standard battery_level
> characteristic. There is a proprietary primary service 0xfebe (which
> is assigned to Bose) with a couple of custom services. I assume battery
> level can be read through them, but the required commands are unknown.
> 
>>> How could I read what's in the Apple HFP extensions?
>>
>> Start with this one. It describes the extra HFP AT commands that iOS uses:
>>
>> https://developer.apple.com/hardwaredrivers/BluetoothDesignGuidelines.pdf
> 
> Thanks for the documentation link! That is actually implemented for
> the Bose QC35. Here is a quick hack providing battery status info
> in pulseaudio log:
> 
> https://github.com/sre/pulseaudio/commit/d66b66d20e9bc73e6d0ca89283cf2b5675304b00
> 
> -- Sebastian
> 
