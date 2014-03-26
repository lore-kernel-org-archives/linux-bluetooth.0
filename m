Return-Path: <cyrus@holtmann.org>
Message-ID: <53333511.6030102@gmail.com>
Date: Wed, 26 Mar 2014 20:14:09 +0000
From: Andrea <mariofutire@gmail.com>
MIME-Version: 1.0
To: Michal Labedzki <michal.labedzki@tieto.com>
CC: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Subject: Re: Help on connecting a PS3 headset
References: <532CAAB8.5020403@gmail.com>	<532F33BB.8050000@gmail.com>	<532F515A.3060809@gmail.com> <CALkxMhHjAhfZ4ade-o+ebtZMZB7o3m9YEzdecphsm1e2cB45bA@mail.gmail.com>
In-Reply-To: <CALkxMhHjAhfZ4ade-o+ebtZMZB7o3m9YEzdecphsm1e2cB45bA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 24/03/14 07:24, Michal Labedzki wrote:
> Hello,
> 
> Wireshark is able to open both files. More interesting is "blue.log".
> It seems that you want to connect via HSP or HFP (only supported by
> headset). In "blue.log" headset asks (SDP) your bluez about "Handsfree
> Audio Gateway" or "Headset Audio Gateway", but bluez return empty
> records, so they must be disabled.
> 
I seem to understand what happens

this is the device info

Device 00:22:A6:16:E3:F0
        Name: Wireless Headset
        Alias: Wireless Headset
        Class: 0x200404
        Icon: audio-card
        Paired: yes
        Trusted: no
        Blocked: no
        Connected: no
        LegacyPairing: yes
        UUID: Headset                   (00001108-0000-1000-8000-00805f9b34fb)
        UUID: Handsfree                 (0000111e-0000-1000-8000-00805f9b34fb)
        UUID: PnP Information           (00001200-0000-1000-8000-00805f9b34fb)
        Modalias: usb:v12BAp0010d0140

and we know that HSP and HFP have been dropped from Bluez 5
Could this explain why connection fails?

it seems I need to learn about oFono and Pulseaudio

