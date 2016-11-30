Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1480481503.2256.4.camel@gmail.com>
Subject: Continuing the Xbox One Bluetooth controller debugging
From: Cameron Gutman <aicommander@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: contact@toniob.net, luiz.dentz@gmail.com, vinicius.gomes@intel.com
Date: Tue, 29 Nov 2016 20:51:43 -0800
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I'm interesting in continuing the debugging of the Xbox One S
controller's issues with the BlueZ stack (original report [0]).
I confirmed the issue still affects v4.9-rc7. I've also tried
Vinicius's patch from [1] applied on v4.9-rc7 without success.

The controller is updated with the latest firmware and connects
reliably to (at least) macOS Sierra, Windows 10 14393, Android
6.0.1, 7.0, and 7.1.1 (including devices using 3.10 and 3.18
based kernels).

I'm happy to collect logs, test other patches, etc.


Regards,
Cameron


[0]: https://marc.info/?l=linux-bluetooth&m=147151539332595&w=2
[1]: https://marc.info/?l=linux-bluetooth&m=147204738628234&w=2
