Return-Path: <cyrus@holtmann.org>
Message-ID: <533092F1.3030008@gmail.com>
Date: Mon, 24 Mar 2014 20:17:53 +0000
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

sounds plausible, but as I have not touched anything,
they must be disabled by default.

cant find any configuration file that mentions anything similar.
on Arch there is /etc/bluetooth/main.conf but it does not seem to help.
In Fedora 20, not even that.

Do I need some extra package? kernel module? audio bluez plugin?
Something like snd-usb-audio for usb sound cards.

thanks for your help

Andrea

