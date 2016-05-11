Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Wed, 11 May 2016 14:51:02 +0200
From: Arthur LAMBERT <lambertarthur22@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: gatt server and reset of hci device
Message-ID: <20160511125102.GC17904@arthur-bzh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I am working with bluez 5.39. I have a custom gatt server which used c api from
btgatt-server from bluez source. Eveything is working great exept when I reset
hci device. I need to disable bluetooth for few hours for specific use case.

If I run hci down/up and try again to connect to gatt server, the client is able
to connect but services are not available. Moreover my server does not see the
client connexion.

Do I need to make a specific stuff to be able to make it work this use case ?

Output from btgatt-client :

[arthur ] ./btgatt-client -d 00:AE:FA:BC:77:69
Connecting to device... Done
[GATT client]# services
GATT client not initialized

Output from server :

[arthur ] ./mygatt_server
Started listening on ATT channel. Waiting for connections

Thanks,
Arthur.
