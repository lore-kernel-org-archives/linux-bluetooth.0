Return-Path: <linux-bluetooth-owner@vger.kernel.org>
To: linux-bluetooth@vger.kernel.org
From: Lars Lindholm <lars.lindholm@vtab.se>
Subject: BlueZ api to retrieve complete service record
Message-ID: <565DB5FF.3060202@vtab.se>
Date: Tue, 1 Dec 2015 16:00:15 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I was looking for a way to retrieve the service record for all services 
from a remote device in bluez5. Similar to how 
org.bluez.Device.getRemoteDeviceServices() worked in bluez4. I asked in 
#bluez-users and got the information that it
is not possible and that I should open a discussion here about the 
possibility to use ServiceRecord to provide this
information in the future. As it currently is only used to provide 
ServiceRecord when providing a service.

The background is that I try to get bluecove-bluez to work with bluez5. 
Internally there is a api I try to fullfill
that has a method that returns all service records. If possible I would 
like to honor that api.

I'm very much not a expert regarding bluetooth so I'm sorry if I misused 
some terminology here.

Best regards
Lars Lindholm
Vibrationsteknik AB
