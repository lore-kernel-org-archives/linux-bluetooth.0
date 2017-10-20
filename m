Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Alan Martinovic <alan.martinovic@senic.com>
Date: Fri, 20 Oct 2017 16:22:20 +0200
Message-ID: <CAOT_U5ZawnuYH3b9DVcAXC-Lpo=CdvhrgQ3qrrKT=JGid9697A@mail.gmail.com>
Subject: Attaching a UART device without crypto dependency
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
I'm attaching a Zephyr based Bluetooth controller that exposes an hci interface.
To make the Linux host part understand the controller i run:

~# sudo btattach -B /dev/ttyACM0 -S 1000000


I can see messages being exchanged in btmon but eventually it ends
with the following error:

= bluetoothd: Failed to open crypto
                     3.879748
= bluetoothd: No Bluetooth address for index 0
              [hci0] 3.879916


Am assuming two things here:
1. The underlying embedded device doesn't have the appropriate crypto
hardware. This results in errors when trying to open an crypto socket.
I've enabled all the crypto related settings in the kernel config.

2. The only thing crypto is used here is to generate the address for
the controller, but besides that isn't essential.

Is there a way to disable the crypto dependency, generate it in
software or set the address manually?
