Return-Path: <cyrus@holtmann.org>
Message-ID: <BAY175-W240DF9C80BE34DD37FB78DE5D20@phx.gbl>
From: yousif saeed <yufi_saeed@hotmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Listening for notifications/indications
Date: Thu, 28 Mar 2013 16:47:57 +0000
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Dear All
I'm trying to communicate with a BLE module through a Linux machine (the module is running a heart rate profile). So far, I've been able to do everything I need except listening for Notifications and indications. I've searched through the web, forums, and even tried walking through the source code and still could not find the answer. 

I'm using kernel version 3.5 and bluez-5.3.

Any help is greatly appreciated as this is part of my final year project.

Thanks
Youssif


P.S.

Succcessful commands used so far:
hcitool lescan
hcitool lecc
gatttool -b <Mac Address> --primary
gatttool -b <MAC Address> --characteristics
gatttool -b <MAC Address> --char-read
gatttool -b <MAC Address> --char-des
gatttool -b <MAC Address> --interactive

Failed commands:
gatttool -b <MAC Address> --listen 		 	   		  