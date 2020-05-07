Return-Path: <SRS0=Gf0L=6V=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C1DCC54E4A
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 May 2020 10:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 162AE21582
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 May 2020 10:32:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgEGKcg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 7 May 2020 06:32:36 -0400
Received: from esa1.mentor.iphmx.com ([68.232.129.153]:15976 "EHLO
        esa1.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbgEGKcc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 7 May 2020 06:32:32 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 May 2020 06:32:32 EDT
IronPort-SDR: uo9hrDQDfhiUZH7KlkrrFh5aOTE+5r53bagEtMzBK9ysHrlcfa+MWgh8ZMk//W8HoNcfrU9aB/
 FXJcY2e7JVEAk6EteFkG8Q3QTcB4ZgKihnhZrLwscEvxzNSW7DJsrAJTvmJWQDRNS/ZEWd4jwR
 1SHEuyT3LqiXW5lP6Zg+uS9qj5+SHyMoIz50oOOClASdA47wbMArf1KtufxLfpDO8RKggapilg
 DkpSj7BpPLUw1uELi4IE8xb3M6MRVLweQddh5FFarbcPej7NJNCzQSOwXJxRdWe4JYlIeADwSK
 CTM=
X-IronPort-AV: E=Sophos;i="5.73,363,1583222400"; 
   d="scan'208";a="50631763"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa1.mentor.iphmx.com with ESMTP; 07 May 2020 02:25:25 -0800
IronPort-SDR: akgImsJD5lWrMhT2KHEYj9PyikSb6QVUa5CnEW5onyUD+LtLjZ4wLcZoJKiRGMnm/BZhcdQaYT
 Ukaodt8jDc4gaHa9DlSGPJH31IK8PPDEhQCeavRB0XyI7jJdENaccYBwdGDlbyQHzCD0S4si+O
 FyV59FPRfhWeRFDf8ucBoywrbPUjzGrpfIrr7t3/5x060bK2OS/3YS547i/m8jFR9bSDuAcJCg
 6aWtnftAFf+srJDLfGZTVBKAB4dwAxs8c80P5p9LDVh8XuD/Q8boDBuq5Tq/wxPvzK2M+nIYbH
 5FY=
From:   "Karim, Hafiz Abdul" <HafizAbdul_Karim@mentor.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Incorrect advertise flags in bluetooth beacon using BlueZ
Thread-Topic: Incorrect advertise flags in bluetooth beacon using BlueZ
Thread-Index: AQHWJFl8xZEjmBN2EUOuRCCmrHEgow==
Date:   Thu, 7 May 2020 10:25:19 +0000
Message-ID: <1588847119436.26848@mentor.com>
Accept-Language: en-US, en-IE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [137.202.0.90]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


Using nRF Connect android application, I'm getting incorrect advertise flags in bluetooth beacon using BlueZ
I have tried on two bluez versions i.e 5.48 and 5.52.

I have set ControllerMode to "le" in main.conf. Using bluetootctl, when I turn on the advertisement using command "advertise on", I get 0x02 advertisement flag. Which means "BR/EDR Not Supported" (Bit 2) is not set.
Now, if i restart the bluetooth service, and turn on the advertisement again, I get 0x06 advertisement flags.

Here is my main.conf

[General]# Default adaper name
# Defaults to 'BlueZ X.YZ'
#Name = BlueZ# Default device class. Only the major and minor device class bits are
# considered. Defaults to '0x000000'.
Class = 0x000100# How long to stay in discoverable mode before going back to non-discoverable
# The value is in seconds. Default is 180, i.e. 3 minutes.
# 0 = disable timer, i.e. stay discoverable forever
DiscoverableTimeout = 0# How long to stay in pairable mode before going back to non-discoverable
# The value is in seconds. Default is 0.
# 0 = disable timer, i.e. stay pairable forever
#PairableTimeout = 0# Automatic connection for bonded devices driven by platform/user events.
# If a platform plugin uses this mechanism, automatic connections will be
# enabled during the interval defined below. Initially, this feature
# intends to be used to establish connections to ATT channels. Default is 60.
#AutoConnectTimeout = 60# Use vendor id source (assigner), vendor, product and version information for
# DID profile support. The values are separated by ":" and assigner, VID, PID
# and version.
# Possible vendor id source values: bluetooth, usb (defaults to usb)
#DeviceID = bluetooth:1234:5678:abcd# Do reverse service discovery for previously unknown devices that connect to
# us. This option is really only needed for qualification since the BITE tester
# doesn't like us doing reverse SDP for some test cases (though there could in
# theory be other useful purposes for this too). Defaults to 'true'.
#ReverseServiceDiscovery = true# Enable name resolving after inquiry. Set it to 'false' if you don't need
# remote devices name and want shorter discovery cycle. Defaults to 'true'.
#NameResolving = true# Enable runtime persistency of debug link keys. Default is false which
# makes debug link keys valid only for the duration of the connection
# that they were created for.
#DebugKeys = false# Restricts all controllers to the specified transport. Default value
# is "dual", i.e. both BR/EDR and LE enabled (when supported by the HW).
# Possible values: "dual", "bredr", "le"
ControllerMode = le# Enables Multi Profile Specification support. This allows to specify if
# system supports only Multiple Profiles Single Device (MPSD) configuration
# or both Multiple Profiles Single Device (MPSD) and Multiple Profiles Multiple
# Devices (MPMD) configurations.
# Possible values: "off", "single", "multiple"
#MultiProfile = off# Permanently enables the Fast Connectable setting for adapters that
# support it. When enabled other devices can connect faster to us,
# however the tradeoff is increased power consumptions. This feature
# will fully work only on kernel version 4.1 and newer. Defaults to
# 'false'.
#FastConnectable = false[Policy]# The ReconnectUUIDs defines the set of remote services that should try
# to be reconnected to in case of a link loss (link supervision
# timeout). The policy plugin should contain a sane set of values by
# default, but this list can be overridden here. By setting the list to
# empty the reconnection feature gets disabled.
#ReconnectUUIDs=00001112-0000-1000-8000-00805f9b34fb, 0000111f-0000-1000-8000-00805f9b34fb, 0000110a-0000-1000-8000-00805f9b34fb# ReconnectAttempts define the number of attempts to reconnect after a link
# lost. Setting the value to 0 disables reconnecting feature.
#ReconnectAttempts=7# ReconnectIntervals define the set of intervals in seconds to use in between
# attempts.
# If the number of attempts defined in ReconnectAttempts is bigger than the
# set of intervals the last interval is repeated until the last attempt.
#ReconnectIntervals=1, 2, 4, 8, 16, 32, 64# AutoEnable defines option to enable all controllers when they are found.
# This includes adapters present on start as well as adapters that are plugged
# in later on. Defaults to 'false'.
AutoEnable=true


And bluetooth.service


[Unit]
Description=Bluetooth service
Documentation=man:bluetoothd(8)
ConditionPathIsDirectory=/sys/class/bluetooth[Service]
Type=dbus
BusName=org.bluez
ExecStart=/usr/libexec/bluetooth/bluetoothd -d -n --configfile /etc/bluetooth/main.conf
NotifyAccess=main
#WatchdogSec=10
#Restart=on-failure
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
LimitNPROC=1
ProtectHome=true
ProtectSystem=full[Install]
WantedBy=bluetooth.target
Alias=dbus-org.bluez.service

Any guidance/pointers?


Thanks,
Abdul Karim


  
  
 
  
