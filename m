Return-Path: <SRS0=6WQ0=6W=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3565EC38A2A
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 May 2020 08:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AED6208CA
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 May 2020 08:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbgEHIkK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 8 May 2020 04:40:10 -0400
Received: from esa3.mentor.iphmx.com ([68.232.137.180]:40181 "EHLO
        esa3.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbgEHIkK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 8 May 2020 04:40:10 -0400
IronPort-SDR: EXy7cMWc/3DIokj017pKdBnOTg1d1W750yXBJyJv9CjRoyF/1D7O4xhxkCDN4HjDuxX9NNrtW0
 QBb5zPBx6XSxeeSczEfhuEBCgMSbXKsgHx8R3+d//3EB/Q6Xm3L05TmTEZB6o5k50Dx2271sxx
 +TMMJ5V1rL/sRSHnN4J4MLT2xt4IMAWs9NB0fjOVc3K033Znqx1CdoBQ1Hevy46po1Z2Cy/viM
 U2zb207rHZEMcdR8LKnl+C4E/nNikroPBnJvM1JHwo8fEyabWceKoVR2ZXszJCNk45dTgyhCiP
 m2I=
X-IronPort-AV: E=Sophos;i="5.73,367,1583222400"; 
   d="scan'208";a="48655132"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa3.mentor.iphmx.com with ESMTP; 08 May 2020 00:40:09 -0800
IronPort-SDR: QpNxk/YKtdtEHPzdEA4mOXnuFoHh0z6oNFPXjGKy0rRdX/fiu5qakZISQKR4+xGSXRegHyWYqV
 Zl3focUxP97GXFi1kh2NnxQHrrCt9ChSOPFtWHFnahtAYH8pHgLULRKgRXH8DjXXVP5IT3IkPW
 kpTTxF85RzoYSWAaPBmPR2HEuCfDdR9j9r8+kLl7rhyztfUKy+IRNyxlSqfmvtNxg2b1vdfPma
 haFI5BOx1kHYhYlkX6eLFml9k6O6EMWAYES3sLKtP5qdBqQ5K2mZJ3AqDV0rz9ffuzBCh2XZ9f
 Ob0=
From:   "Karim, Hafiz Abdul" <HafizAbdul_Karim@mentor.com>
To:     "Ryll, Jan (GED-SDD2)" <Jan.Ryll@bshg.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Incorrect advertise flags in bluetooth beacon using BlueZ
Thread-Topic: Incorrect advertise flags in bluetooth beacon using BlueZ
Thread-Index: AQHWJFl8xZEjmBN2EUOuRCCmrHEgo6idAXiAgADCI4CAABt2Lg==
Date:   Fri, 8 May 2020 08:40:04 +0000
Message-ID: <1588927203166.25304@mentor.com>
References: <1588847119436.26848@mentor.com>
 <CABBYNZ+a3Br71ExTi1XUa7UnDry2dNBaomz-+z7sVtVH_5toCQ@mail.gmail.com>,<dfb4035a86d24ffdb80b1c5b3eb52896@bshg.com>
In-Reply-To: <dfb4035a86d24ffdb80b1c5b3eb52896@bshg.com>
Accept-Language: en-US, en-IE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [192.94.31.225]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

We do update the service after main.conf is changed. 
I agree with Jan's understanding of problem statement here. 

Regards,
Hafiz Abdul Karim,
Senior Software Development Engineer | Mentor Embedded Linux
Mentor, A Siemens Business
6th Floor Ali Tower M. M. Alam Road Gulberg III Lahore Pakistan, 54660
HafizAbdul_karim@mentor.com  | office: +92-42-3609-9202 | cell: +92-334-5099746

________________________________________
From: Ryll, Jan (GED-SDD2) <Jan.Ryll@bshg.com>
Sent: Friday, May 8, 2020 12:59 PM
To: Luiz Augusto von Dentz; Karim, Hafiz Abdul
Cc: linux-bluetooth@vger.kernel.org
Subject: RE: Incorrect advertise flags in bluetooth beacon using BlueZ

Hi Luiz,

what I understood is that at first start of bluez bluetooth service the advertisement flags for "mode" are not set to the correct value, as defined (ControllerMode = le) in main.conf.
If you start the service a second time this flag is correct. For the first time it is always wrong.
This is the same we did see here with our equipment.

Regards
Jan


-----Original Message-----
From: linux-bluetooth-owner@vger.kernel.org <linux-bluetooth-owner@vger.kernel.org> On Behalf Of Luiz Augusto von Dentz
Sent: Thursday, May 7, 2020 10:24 PM
To: Karim, Hafiz Abdul <HafizAbdul_Karim@mentor.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Incorrect advertise flags in bluetooth beacon using BlueZ

Hi Hafiz Abdul,


On Thu, May 7, 2020 at 3:36 AM Karim, Hafiz Abdul <HafizAbdul_Karim@mentor.com> wrote:
>
>
> Using nRF Connect android application, I'm getting incorrect advertise
> flags in bluetooth beacon using BlueZ I have tried on two bluez versions i.e 5.48 and 5.52.
>
> I have set ControllerMode to "le" in main.conf. Using bluetootctl, when I turn on the advertisement using command "advertise on", I get 0x02 advertisement flag. Which means "BR/EDR Not Supported" (Bit 2) is not set.
> Now, if i restart the bluetooth service, and turn on the advertisement again, I get 0x06 advertisement flags.

Are you saying we are not updating the service once main.conf has changed? We don't do that automatically if that is what you are referring to, also if you want to advertise as a beacon/broadcaster and not as peripheral thean us you should use advertise broadcast.

> Here is my main.conf
>
> [General]# Default adaper name
> # Defaults to 'BlueZ X.YZ'
> #Name = BlueZ# Default device class. Only the major and minor device
> class bits are # considered. Defaults to '0x000000'.
> Class = 0x000100# How long to stay in discoverable mode before going
> back to non-discoverable # The value is in seconds. Default is 180, i.e. 3 minutes.
> # 0 = disable timer, i.e. stay discoverable forever
> DiscoverableTimeout = 0# How long to stay in pairable mode before
> going back to non-discoverable # The value is in seconds. Default is 0.
> # 0 = disable timer, i.e. stay pairable forever #PairableTimeout = 0#
> Automatic connection for bonded devices driven by platform/user events.
> # If a platform plugin uses this mechanism, automatic connections will
> be # enabled during the interval defined below. Initially, this
> feature # intends to be used to establish connections to ATT channels. Default is 60.
> #AutoConnectTimeout = 60# Use vendor id source (assigner), vendor,
> product and version information for # DID profile support. The values
> are separated by ":" and assigner, VID, PID # and version.
> # Possible vendor id source values: bluetooth, usb (defaults to usb)
> #DeviceID = bluetooth:1234:5678:abcd# Do reverse service discovery for
> previously unknown devices that connect to # us. This option is really
> only needed for qualification since the BITE tester # doesn't like us
> doing reverse SDP for some test cases (though there could in # theory be other useful purposes for this too). Defaults to 'true'.
> #ReverseServiceDiscovery = true# Enable name resolving after inquiry.
> Set it to 'false' if you don't need # remote devices name and want shorter discovery cycle. Defaults to 'true'.
> #NameResolving = true# Enable runtime persistency of debug link keys.
> Default is false which # makes debug link keys valid only for the
> duration of the connection # that they were created for.
> #DebugKeys = false# Restricts all controllers to the specified
> transport. Default value # is "dual", i.e. both BR/EDR and LE enabled (when supported by the HW).
> # Possible values: "dual", "bredr", "le"
> ControllerMode = le# Enables Multi Profile Specification support. This
> allows to specify if # system supports only Multiple Profiles Single
> Device (MPSD) configuration # or both Multiple Profiles Single Device
> (MPSD) and Multiple Profiles Multiple # Devices (MPMD) configurations.
> # Possible values: "off", "single", "multiple"
> #MultiProfile = off# Permanently enables the Fast Connectable setting
> for adapters that # support it. When enabled other devices can connect
> faster to us, # however the tradeoff is increased power consumptions.
> This feature # will fully work only on kernel version 4.1 and newer.
> Defaults to # 'false'.
> #FastConnectable = false[Policy]# The ReconnectUUIDs defines the set
> of remote services that should try # to be reconnected to in case of a
> link loss (link supervision # timeout). The policy plugin should
> contain a sane set of values by # default, but this list can be
> overridden here. By setting the list to # empty the reconnection feature gets disabled.
> #ReconnectUUIDs=00001112-0000-1000-8000-00805f9b34fb,
> 0000111f-0000-1000-8000-00805f9b34fb, 0000110a-0000-1000-8000-00805f9b34fb# ReconnectAttempts define the number of attempts to reconnect after a link # lost. Setting the value to 0 disables reconnecting feature.
> #ReconnectAttempts=7# ReconnectIntervals define the set of intervals
> in seconds to use in between # attempts.
> # If the number of attempts defined in ReconnectAttempts is bigger
> than the # set of intervals the last interval is repeated until the last attempt.
> #ReconnectIntervals=1, 2, 4, 8, 16, 32, 64# AutoEnable defines option to enable all controllers when they are found.
> # This includes adapters present on start as well as adapters that are
> plugged # in later on. Defaults to 'false'.
> AutoEnable=true
>
>
> And bluetooth.service
>
>
> [Unit]
> Description=Bluetooth service
> Documentation=man:bluetoothd(8)
> ConditionPathIsDirectory=/sys/class/bluetooth[Service]
> Type=dbus
> BusName=org.bluez
> ExecStart=/usr/libexec/bluetooth/bluetoothd -d -n --configfile
> /etc/bluetooth/main.conf NotifyAccess=main
> #WatchdogSec=10
> #Restart=on-failure
> CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
> LimitNPROC=1
> ProtectHome=true
> ProtectSystem=full[Install]
> WantedBy=bluetooth.target
> Alias=dbus-org.bluez.service
>
> Any guidance/pointers?
>
>
> Thanks,
> Abdul Karim
>
>
>
>
>
>


--
Luiz Augusto von Dentz
