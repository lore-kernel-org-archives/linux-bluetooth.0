Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Dr Nukular <dr.nukular@outlook.at>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Bluetooth connection drops after idle time
Date: Sat, 7 Apr 2018 06:32:56 +0000
Message-ID: <AM5PR0502MB3059AD084567C3660CF64B2DEAB90@AM5PR0502MB3059.eurprd05.prod.outlook.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Bluetooth connection drops if the device, such as mouse or keyboard, is inactive for some time. Once the device is used again the bluetooth connection comes back on. This would not be an issue, if it wasn't for the time that it takes until the connection is re-established again. It is not responsive enough and interferes with the workflow, if you have to wait several seconds until you can use your device again, especially since you naturally expect an immediate response.

If this is not a bug, then please enable a setting to disable that "feature" or improve the time by reducing it to a minimum to reconnect the device.