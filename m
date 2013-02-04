Return-Path: <cyrus@holtmann.org>
From: "Zheng, Wu" <wu.zheng@intel.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: rfcomm connection reset by peer 104
Date: Mon, 4 Feb 2013 03:25:16 +0000
Message-ID: <2CF57A644018A745B8FE029C7223E16E0FEA25D3@SHSMSX102.ccr.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

I use bluez-4.101 and obexd-0.46 and Linux kernel is 2.6.35 on a device to implement OPP server.

Obexd runs well on the device.

When I send a file by obex-client to the device, the connection reset by peer 104 error is reported.

Client OPP:
obex-client[1109]: client/bluetooth.c: transport_connect() port 9
obex-client[1109]: client/bluetooth.c: transport_callback()
obex-client[1109]: client/session.c : transport_func()
obex-client[1109]: Connection reset by peer (104)

Server OPP:
Obexd: nothing info is printed

Can somebody provide some hints? Thanks

Best Regards
Zheng Wu
