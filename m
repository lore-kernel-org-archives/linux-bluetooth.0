Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: passkey agent in bluez4.X
Date: Tue, 13 Jan 2009 12:50:41 +0800
Message-ID: <9F2B2656C8747B498D56A7B30FF5EB9FE556C1@CNMAIL13.cn.utstarcom.com>
From: "Yao Ye" <yeyao@utstar.com>
To: <linux-bluetooth@vger.kernel.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi, bluez-users:
     I have finished to boot up bluecore-4 on my pxa310, and can be
searched by other BT device. 
But, the problem is it can't bind to any other device, because there
isn't a BlueZ agent running to answer pin requests.

How to start a BlueZ agent running to answer pin requests ?

In bluez-4.25/test, i found agent.c and agent command.
so, i run it on my pxa310 board, but it failed while other BT device
connect to it and request a pin code..
the debug info is as following.

[root@Linux /]#./agent 0000 &
bluetoothd[907]: pin_code_request (sba=77:88:66:22:33:44,
dba=00:1A:77:77:14:84)
bluetoothd[907]: hcid_dbus_new_auth_request
bluetoothd[907]: Agent replied with an error:
org.freedesktop.DBus.Error.Unknown Method, Method "RequestPinCode" with
signature "o" on interface "org.bluez.Agent" doesn't exist
bluetoothd[907]: adapter_get_device(00:1A:77:77:14:84)

I have changed device_path and agent_path in agent.c, but it still
doesn't work. 
Could somebody know how to run a passkey agent in bluez4.X?
thanks a lot!
 
Best regards
YAO Ye
