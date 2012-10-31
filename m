Return-Path: <cyrus@holtmann.org>
Date: Wed, 31 Oct 2012 16:25:32 -0200
From: Gustavo Padovan <gustavo@padovan.org>
To: Marcos Chaparro <marcos@mrkindustries.com.ar>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add bluetooth support for VAIO VPCEH [0489:e027]
Message-ID: <20121031182532.GD1679@joana>
References: <201210291009.12913.marcos@mrkindustries.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201210291009.12913.marcos@mrkindustries.com.ar>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcos,

* Marcos Chaparro <marcos@mrkindustries.com.ar> [2012-10-29 10:09:12 -0300]:

> Hi,
> this patch against 3.7-rc3 identifies my Atheros AR3011 internal bluetooth 
> device, I just transferred some files from my phone to this debian PC using 
> bluetooth and it works fine (btw, it needs atheros-firmware package).
> 
> Before changing this, lsusb was identifying it as a Foxconn / Hon Hai device, 
> which is wrong, and it probably loaded a different firmware to the bluetooth 
> module.
> 
> The patches solves the following discussions:
> https://answers.launchpad.net/ubuntu/+source/bluez/+question/168992 
> http://ubuntuforums.org/showthread.php?t=1867214 
> http://linux-unix-open-source.1053819.n5.nabble.com/Atheros-AR9285-on-
> Ubuntu-11-10-Sony-Vaio-VPCEH-wifi-does-t-works-td4931321.html 
> http://www.vivaolinux.com.br/topico/Rede-Wireless/Bluetooth-vaio-VPCEH-
> desabilitado 
> 
> Please tell me if you won't add it to mainstream for some reason.

Can you please send me a git formatted patch with your Signed-off-by line in
it. See Documentation/SubmittingPatches in the kernel source for more info.

Also add the output of /sys/kernel/debug/usb/devices for this specific device
to the commit message. Thanks.

	Gustavo
