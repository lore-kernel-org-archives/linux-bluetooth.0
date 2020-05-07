Return-Path: <SRS0=Gf0L=6V=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3034EC38A2A
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 May 2020 12:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C6CF2083B
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 May 2020 12:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bshg.com header.i=@bshg.com header.b="VWyWVuAB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgEGMUU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 7 May 2020 08:20:20 -0400
Received: from de-out1.bosch-org.com ([139.15.230.186]:35670 "EHLO
        de-out1.bosch-org.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbgEGMUT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 7 May 2020 08:20:19 -0400
Received: from si0vm1948.rbesz01.com (unknown [139.15.230.188])
        by fe0vms0187.rbdmz01.com (Postfix) with ESMTPS id 49Hswm1J3jz1XLDR1;
        Thu,  7 May 2020 14:20:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bshg.com;
        s=key3-intmail; t=1588854008;
        bh=aMGU/FeeFdXYsMU0R+m1NvLvbOddXjt7CYJNQbDICKU=; l=10;
        h=From:Subject:From:Reply-To:Sender;
        b=VWyWVuAB/xHP2jp/fsuW2JcVRGeMdkZSNAD6Nr22r+O7cXbJvIRTUebLLBRw00O8L
         yeSmf6GlcXeOB0Hz1lbPrVmZ8iMgEkEtNplcQcMeBQ2Dia/qKHJrvrsw57d8OXorkX
         iZrkSmWOX/DZyBSRBeAMyFtv3eqqDoRj5NWD1JhY=
Received: from si0vm4642.rbesz01.com (unknown [10.58.172.176])
        by si0vm1948.rbesz01.com (Postfix) with ESMTPS id 49Hswm12qxz4S9;
        Thu,  7 May 2020 14:20:08 +0200 (CEST)
X-AuditID: 0a3aad12-125ff70000004d66-b4-5eb3fcf6b6eb
Received: from si0vm1949.rbesz01.com ( [10.58.173.29])
        (using TLS with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by si0vm4642.rbesz01.com (SMG Outbound) with SMTP id D0.C1.19814.6FCF3BE5; Thu,  7 May 2020 14:20:06 +0200 (CEST)
Received: from SI0SWIEXHC01.bsh.corp.bshg.com (si0swiexhc01.bsh.corp.bshg.com [10.49.76.137])
        by si0vm1949.rbesz01.com (Postfix) with ESMTPS id 49Hswk0BDWz6CjZNx;
        Thu,  7 May 2020 14:20:06 +0200 (CEST)
Received: from SI0SWIEXMB2A.bsh.corp.bshg.com (10.49.76.131) by
 SI0SWIEXHC01.bsh.corp.bshg.com (10.49.76.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Thu, 7 May 2020 14:20:05 +0200
Received: from SI0SWIEXMB2B.bsh.corp.bshg.com (10.49.76.132) by
 SI0SWIEXMB2A.bsh.corp.bshg.com (10.49.76.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1913.5; Thu, 7 May 2020 14:20:05 +0200
Received: from SI0SWIEXMB2B.bsh.corp.bshg.com ([fe80::5154:c3ab:d4e0:8272]) by
 SI0SWIEXMB2B.bsh.corp.bshg.com ([fe80::5154:c3ab:d4e0:8272%5]) with mapi id
 15.01.1913.010; Thu, 7 May 2020 14:20:05 +0200
From:   "Ryll, Jan (GED-SDD2)" <Jan.Ryll@bshg.com>
To:     "Karim, Hafiz Abdul" <HafizAbdul_Karim@mentor.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: Incorrect advertise flags in bluetooth beacon using BlueZ
Thread-Topic: Incorrect advertise flags in bluetooth beacon using BlueZ
Thread-Index: AQHWJFl8xZEjmBN2EUOuRCCmrHEgo6iciZKw
Date:   Thu, 7 May 2020 12:20:05 +0000
Message-ID: <bd22ff8aaeb54fab9996a645e1f77c6a@bshg.com>
References: <1588847119436.26848@mentor.com>
In-Reply-To: <1588847119436.26848@mentor.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.49.87.17]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: fd782ad6-06f5-4690-bfdd-57c58a3839e9
X-Brightmail-Tracker: H4sIAAAAAAAAA22Te1BUdRTH+d1dtsu2F+9eQA4E5uwQzSguj9AsmHg4pvQAgzKG4dESV9ha
        dpm94IANBUFJKxhipDEIJA9nMIR2HRVBgQURmCVoVCReUTLxVIiNNxPdZXnsH/1z5vv7nvM5
        5/c7dy7Oocpxe1wqT6SVcolMxONz+a9XOe5bWNVEuj194HAwe+g252Bhz1mOL3a0bu5LdFSv
        3nUMC+N7x9Ay6Ula6frGR/y4itIpTkKTOHmhcRpLQ3ecVQjHgfSEkRWBClngFHkRA/1TmQrx
        Wd2JYGZNzzMe0jHoHljFjIdVBPXqSt5WWeZPcxwDzyPdoEc1sK6tyVTo78zHDNqKfBPOtd7A
        jP4R6Jpf3qjxgLH8qXWfSzpBYVbluk+Qr0LzUD3HeCcX6LvZzzVoC3If1I4Ur2tEOkJNTdd6
        DYe0BfVfC+YGDSQJZfVGH0gbGH/y74b/InSe+9vcWO8CJXWzPKPeCxU/Tm7MFUL7DyNcY70X
        XNEMo1wEBSYjCkzwAhO8wAQvQdxKZMNI3U7Gex7w9BAro2nmlJu7+GNFvBoZPxx1Cy1nzYi1
        CMORFu3HMZENUabXRFKW0YqYlDgJExelTJLRjMie+GLqmwjKastmkqLjpQwjVci1CHCOyJoQ
        LP4cSRExkpRTtFJhxLToBZwrsiWcBGyKjJUk0p/SdAKt3Mx64bgIiAOL7EChko6lk09IZYmb
        aZEjgczMzKidphnTsRhuoUWv4AJ2tnqZbUEwCZJ4Rhq7gdsZcWrT3UY7UBCeO37pMgevvVfE
        xiZDpLhyhZy2tyUa7rC9SAMVlyTfuo29A2EXxL7CxiSx3XEC/YZwJLIiKlZYWMD+Htv3ACLN
        sDrhhrkNeZSzDDkIUJqZg0HedDEGS6e7Mbh+9VcMxoYfs6F1gANFhelcyGtv5kL1yDgXLueP
        mkPvVAYPektGeZA3x4ZF3TgOZ1VlfOhVtfDh4Xzx87BWd1MAY7o2AdwqzCBAt6oiQJPXQsD5
        wTZLmM4asoTbdRd2QM2jUhIKvr1LQlHuEyE01OZQMPdMS0GW9iEF7f+MUxPskjF2yfpZtWHJ
        iZLE/1nyhrv9Ovs0zCJMcXEkYm1o9z3l+UbdS9/9mclUpwkXLXe0+/oF+b8c2pEiLu95b/fx
        SH2/X41n255Un6FnDo59NS7uAR1L/RmH736mi3otXOi303vyAw0v0r/CtWqwt/vRseayE+/6
        oNEzwa7FH1bJ5bPxeRy7XyaFukOKQ8Nky1etmgjrG7tSU6tCRVeZd95CDfO8guS+4vAj9zHf
        07qAt8W6mmHniJLYyYjq4OPi7wfuO6QUUSE5OUshTsEt6VHJeFO4U/mDlZn3Q65lN14JC7Wq
        t3M+XKjtanrsvbC/6NrekswEr08u+P8xwQ+RBe4KGPg66DlX3eyZmEAfiaOZq/JS9uddgQG/
        Xx/ViLhMnMR9D0fJSP4D4UDQNTgFAAA=
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Abdul,

we did also see this bug.

Following was observed:
5.48 	ControllerMode =3D le 	We never get Advertising Flags =3D 0x06 runnin=
g
5.52 	ControllerMode =3D le 	After reboot: Advertising Flags =3D 0x02 -> sy=
stemctl restart bluetooth -> Advertising Flags =3D 0x06

It seems to be that during first startup something goes wrong. We did not i=
nvestigate further but also need to have this fixed.

@Community: Is there a fix available or planned?

Best Regards
Jan


-----Original Message-----
From: linux-bluetooth-owner@vger.kernel.org <linux-bluetooth-owner@vger.ker=
nel.org> On Behalf Of Karim, Hafiz Abdul
Sent: Thursday, May 7, 2020 12:25 PM
To: linux-bluetooth@vger.kernel.org
Subject: Incorrect advertise flags in bluetooth beacon using BlueZ


Using nRF Connect android application, I'm getting incorrect advertise flag=
s in bluetooth beacon using BlueZ I have tried on two bluez versions i.e 5.=
48 and 5.52.

I have set ControllerMode to "le" in main.conf. Using bluetootctl, when I t=
urn on the advertisement using command "advertise on", I get 0x02 advertise=
ment flag. Which means "BR/EDR Not Supported" (Bit 2) is not set.
Now, if i restart the bluetooth service, and turn on the advertisement agai=
n, I get 0x06 advertisement flags.

Here is my main.conf

[General]# Default adaper name
# Defaults to 'BlueZ X.YZ'
#Name =3D BlueZ# Default device class. Only the major and minor device clas=
s bits are # considered. Defaults to '0x000000'.
Class =3D 0x000100# How long to stay in discoverable mode before going back=
 to non-discoverable # The value is in seconds. Default is 180, i.e. 3 minu=
tes.
# 0 =3D disable timer, i.e. stay discoverable forever DiscoverableTimeout =
=3D 0# How long to stay in pairable mode before going back to non-discovera=
ble # The value is in seconds. Default is 0.
# 0 =3D disable timer, i.e. stay pairable forever #PairableTimeout =3D 0# A=
utomatic connection for bonded devices driven by platform/user events.
# If a platform plugin uses this mechanism, automatic connections will be #=
 enabled during the interval defined below. Initially, this feature # inten=
ds to be used to establish connections to ATT channels. Default is 60.
#AutoConnectTimeout =3D 60# Use vendor id source (assigner), vendor, produc=
t and version information for # DID profile support. The values are separat=
ed by ":" and assigner, VID, PID # and version.
# Possible vendor id source values: bluetooth, usb (defaults to usb) #Devic=
eID =3D bluetooth:1234:5678:abcd# Do reverse service discovery for previous=
ly unknown devices that connect to # us. This option is really only needed =
for qualification since the BITE tester # doesn't like us doing reverse SDP=
 for some test cases (though there could in # theory be other useful purpos=
es for this too). Defaults to 'true'.
#ReverseServiceDiscovery =3D true# Enable name resolving after inquiry. Set=
 it to 'false' if you don't need # remote devices name and want shorter dis=
covery cycle. Defaults to 'true'.
#NameResolving =3D true# Enable runtime persistency of debug link keys. Def=
ault is false which # makes debug link keys valid only for the duration of =
the connection # that they were created for.
#DebugKeys =3D false# Restricts all controllers to the specified transport.=
 Default value # is "dual", i.e. both BR/EDR and LE enabled (when supported=
 by the HW).
# Possible values: "dual", "bredr", "le"
ControllerMode =3D le# Enables Multi Profile Specification support. This al=
lows to specify if # system supports only Multiple Profiles Single Device (=
MPSD) configuration # or both Multiple Profiles Single Device (MPSD) and Mu=
ltiple Profiles Multiple # Devices (MPMD) configurations.
# Possible values: "off", "single", "multiple"
#MultiProfile =3D off# Permanently enables the Fast Connectable setting for=
 adapters that # support it. When enabled other devices can connect faster =
to us, # however the tradeoff is increased power consumptions. This feature=
 # will fully work only on kernel version 4.1 and newer. Defaults to # 'fal=
se'.
#FastConnectable =3D false[Policy]# The ReconnectUUIDs defines the set of r=
emote services that should try # to be reconnected to in case of a link los=
s (link supervision # timeout). The policy plugin should contain a sane set=
 of values by # default, but this list can be overridden here. By setting t=
he list to # empty the reconnection feature gets disabled.
#ReconnectUUIDs=3D00001112-0000-1000-8000-00805f9b34fb, 0000111f-0000-1000-=
8000-00805f9b34fb, 0000110a-0000-1000-8000-00805f9b34fb# ReconnectAttempts =
define the number of attempts to reconnect after a link # lost. Setting the=
 value to 0 disables reconnecting feature.
#ReconnectAttempts=3D7# ReconnectIntervals define the set of intervals in s=
econds to use in between # attempts.
# If the number of attempts defined in ReconnectAttempts is bigger than the=
 # set of intervals the last interval is repeated until the last attempt.
#ReconnectIntervals=3D1, 2, 4, 8, 16, 32, 64# AutoEnable defines option to =
enable all controllers when they are found.
# This includes adapters present on start as well as adapters that are plug=
ged # in later on. Defaults to 'false'.
AutoEnable=3Dtrue


And bluetooth.service


[Unit]
Description=3DBluetooth service
Documentation=3Dman:bluetoothd(8)
ConditionPathIsDirectory=3D/sys/class/bluetooth[Service]
Type=3Ddbus
BusName=3Dorg.bluez
ExecStart=3D/usr/libexec/bluetooth/bluetoothd -d -n --configfile /etc/bluet=
ooth/main.conf NotifyAccess=3Dmain
#WatchdogSec=3D10
#Restart=3Don-failure
CapabilityBoundingSet=3DCAP_NET_ADMIN CAP_NET_BIND_SERVICE
LimitNPROC=3D1
ProtectHome=3Dtrue
ProtectSystem=3Dfull[Install]
WantedBy=3Dbluetooth.target
Alias=3Ddbus-org.bluez.service

Any guidance/pointers?


Thanks,
Abdul Karim


 =20
 =20
=20
 =20
