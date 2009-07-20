Return-Path: <cyrus@holtmann.org>
Subject: Re: btusb_send_frame: hci0 urb ede00a50 submission failed
From: Marcel Holtmann <marcel@holtmann.org>
To: Justin Mattock <justinmattock@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-bluetooth@vger.kernel.org
In-Reply-To: <dd18b0c30907192045t3078451ao9af4c1751d9efe91@mail.gmail.com>
References: <dd18b0c30907192045t3078451ao9af4c1751d9efe91@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 20 Jul 2009 09:15:20 +0200
Message-Id: <1248074120.4549.89.camel@violet>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Justin,

> Not sure whats happening here,
> this morning using s2ram worked like a charm,
> now at the end of the day this thing takes a good minute to
> wakeup. As for the blueooth finally got it working, but
> now I'm seeing this in dmesg:
> 
> 
> [  708.630722] Restarting tasks ... done.
> [  708.910090] usb 5-1: USB disconnect, address 3
> [  708.910262] btusb_send_frame: hci0 urb ede00a50 submission failed
> [  709.330776] [drm] Loading R500 Microcode
> 
> Maybe suspend works better when cooler, but in anycase
> the bluetooth works perfectly recovers from s2ram, scrollball
> works as well(all with SELinux running too).

what kernel version? Is this a plain vanilla kernel.org kernel or a
distro kernel?

Regards

Marcel


