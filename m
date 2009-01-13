Return-Path: <cyrus@holtmann.org>
From: "Li, Zhigang" <zhigang.li@intel.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Tue, 13 Jan 2009 10:43:58 +0800
Subject: Question for PAN connection
Message-ID: <B94C62E7C2870743865418621F040C1303CEBFD8@pdsmsx502.ccr.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

HI all,

There are some problem in my PAN connection can somebody tell where is wrong and show the right step.

1, NAP Server side

  Pand - M ( there was strange behavior and the result look like pand -h ) Same result in upstream.  Maybe it's a bug

So only thing I have to change it by hciconfig 

Pand -s -r NAP

Pand -c [target device address] --service NAP
 

I wrote a dhclient script at /etc/sysconfig/network-script/

DEVICE=bnep0

BOOTPROTO=dhcp

ONBOOT=no


Also I modified the network.conf file to use default interface

2, PANU side

Pand -c [server bdaddr] - service PANU

3, pand -show 

  Nothing display

Ifconfig bnep0 

   Error report device not found

Thanks


