Return-Path: <cyrus@holtmann.org>
From: Nedim Hadzic <nhadzic@blackberry.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [Bluetooth Low Energy] Pairing and writing characteristic property
 issue
Date: Wed, 11 Sep 2013 12:34:57 +0000
Message-ID: <285F7E29A611CC4197B552ED66CC20B8CE7EBA@XMB102ADS.rim.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello everyone,

Recently I started working with Bluetooth Low Energy devices on Linux (developing some applications, testing devices etc). I am using two Bluetooth Low Energy devices SensorTag from Texas Instruments and HearRateMonitor BlueHR. 

Bluez version: 4.101-0ubuntu8b1

SensorTag: I can connect to the device, read and write characteristic values using gatttool and I can pair with the device using a simple-agent tool for this. After I pair with the device, I want to change value of the characteristic using org.bluez.Characteristic interface and SetProperty method, but it does not change; nor PropertyChanged signal is emitted nor I get any error. I checked hcidump:
2013-09-11 12:07:15.827211 < ACL data: handle 75 flags 0x00 dlen 8
    ATT: Write cmd (0x52)
      handle 0x0029 value  0x01

In case of changing the characteristic value with gatttool hcidump is following:
2013-09-11 12:20:07.239012 < ACL data: handle 75 flags 0x00 dlen 8
    ATT: Write req (0x12)
      handle 0x0029 value  0x01

Difference is in part of write cmd and req. Only difference between these two approaches is that with gatttool, you first connect to LE device (LE Create Connection in hcidump), and in hcdump when accessing through interface and using method SetProperty there is no interface or method for connecting. Any guesses what can be done? 


HearRateMonitor: I can connect to the device, read characteristic values using gatttool ( with adding "-t random" part to the command), but I can not pair with the device using simple-agent: Error: Creating device failed: org.bluez.Error.AuthenticationFailed: Authentication Failed.
Hcidump is the following:
2013-09-11 11:58:41.747749 < HCI Command: LE Create Connection (0x08|0x000d) plen 25
    bdaddr D5:EA:8B:A9:EC:70 type 1
2013-09-11 11:58:41.751989 > HCI Event: Command Status (0x0f) plen 4
    LE Create Connection (0x08|0x000d) status 0x00 ncmd 1
2013-09-11 11:58:44.311996 > HCI Event: LE Meta Event (0x3e) plen 19
    LE Connection Complete
      status 0x00 handle 75, role master
      bdaddr D5:EA:8B:A9:EC:70 (Random)
2013-09-11 11:58:44.312173 < ACL data: handle 75 flags 0x00 dlen 11
    SMP: Pairing Request (0x01)
      capability 0x04 oob 0x00 auth req 0x01
      max key size 0x10 init key dist 0x00 resp key dist 0x01
      Capability: KeyboardDisplay (OOB data not present)
      Authentication: Bonding (No MITM Protection)
      Initiator Key Distribution:    
      Responder Key Distribution:  LTK  
2013-09-11 11:58:44.348985 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 75 packets 1
2013-09-11 11:58:44.418969 > ACL data: handle 75 flags 0x02 dlen 6
    SMP: Pairing Failed (0x05)
      reason 0x05
      Reason Pairing Not Supported
2013-09-11 11:58:44.560004 > HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 75 reason 0x13
    Reason: Remote User Terminated Connection

This device is using random device address, but I do not know how to pair with it in that case. I try to pair with it using a smartphone with support and it is working. Any help, or input on this?

Looking forward to reply;

Kind regards,
Nedim Hadzic
---------------------------------------------------------------------
This transmission (including any attachments) may contain confidential information, privileged material (including material protected by the solicitor-client or other applicable privileges), or constitute non-public information. Any use of this information by anyone other than the intended recipient is prohibited. If you have received this transmission in error, please immediately reply to the sender and delete this information from your system. Use, dissemination, distribution, or reproduction of this transmission by unintended recipients is not authorized and may be unlawful.
