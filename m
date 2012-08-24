Return-Path: <cyrus@holtmann.org>
From: Geay Franck <franck.geay@technicolor.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Fri, 24 Aug 2012 10:12:54 +0200
Subject: duplicate devices found when using StartDiscovery API
Message-ID: <453EEB4CD4162742B6EF3D3F84E88A6E01ADB2AAC3@MOPESMBX01.eu.thmulti.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi 

I have a problem with bluez scanning API 
When I call StartDiscovery dbus API, I get some duplicate devices found signal whereas using hcitool scan doesn't list duplicate devices
Is it normal, do I have to filter duplicate devices based on the BD address ? Is there a fix for this problem ?
I am using bluez version 4.87

root@localhost ~]# /usr/lib/bluez/test/test-discovery  | grep -e Name -e Addres
    Name = MyLapTop
    Address = 00:16:41:DB:FF:F2
    Name = C1-01
    Address = 78:2E:EF:10:F4:7B
    Name = Dell Wireless 370 Bluetooth Mini-card
    Address = 00:25:56:E4:0E:0C
    Name = Nokia 2730              
    Address = C8:DF:7C:CF:CE:E7
    Name = MyLapTop
    Address = 00:16:41:DB:FF:F2
    Name = Nokia 2730              
    Address = C8:DF:7C:CF:CE:E7
    Name = Dell Wireless 370 Bluetooth Mini-card
[root@localhost ~]# hcitool scan    
Scanning ...
        78:2E:EF:10:F4:7B       C1-01
        00:25:56:E4:0E:0C       Dell Wireless 370 Bluetooth Mini-card
        C8:DF:7C:CF:CE:E7       Nokia 2730  
        00:16:41:DB:FF:F2       MyLapTop
        34:4B:50:BC:EB:84       My Tara
                              

Thanks
Franck
