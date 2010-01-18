Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Mon, 18 Jan 2010 12:39:59 +0530
Message-ID: <912bb79a1001172309vf5ef65hc22bb364e51cdcf7@mail.gmail.com>
Subject: API for Headset AT Commands??
From: nirav rabara <niravrabara@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I am using bluez 4.58 with DBUS API for connection and HCI layer for
SCO connection.
Now, I want key press event command from HS, i.e. AT+CKPD=200, but
since I have used DBUS connect API of Headset Interface, I am able to
get this command.
Is is compulsory to create connection using RFCOMM socket to speak
with HS AT-commands.? OR is there any patch available which contains
API to handle AT Commands?

Any suggestion would be appreciable.

-- 
With Regards,
Nirav Rabara
