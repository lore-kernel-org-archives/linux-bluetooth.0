Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 13 May 2016 14:34:44 +0100
Message-ID: <CADF5PPHmyUGR3dcyrCnQm3V2BSRDRJ0LBfx_BimKE6wYJx7j9g@mail.gmail.com>
Subject: Forcing bonding between cen & peri impl. using cmdline tools
From: paul grant <home.paul.grant@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I trying to understand the commands required to create a
bonding between a BLE central and peripheral.

To test understanding I'm using the bluez command line tools
to create a central and peripheral, and initiate bonding
between them!

The following are my scripts so far:

On Central:

sudo btmgmt le on
sudo btmgmt sc on
sudo btmgmt bondable on
sudo btmgmt pair -t 1 60:02:92:B4:C8:9E

On Peripheral:
sudo btmgmt sc on
sudo btmgmt bondable on
sudo hciconfig hci0 leadv 0

To check if bonding has occured I'm looking under

/var/lib/bluetooth<mac>/<mac>/info for link keys

Can some one point me to example scripts which perform
the desired action?

Alternatively stripped down c++ code for the central and peripherla
would equal;y as useful.

BR
Paul Grant
