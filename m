Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com
Subject: Query regarding MAP 1.2 implementation
Date: Wed, 06 Aug 2014 17:00:41 +0530
Message-id: <000001cfb169$e4d01bc0$ae705340$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,

I am currently working on MAP implementation in BlueZ.
I am trying below things to make MAS connect with remote MCE client.

Below are the steps we followed;

On MCE device: 
--> MAS search
--> MAS connect
--> SET PATH (/)

On Bluez, obexd:
--> Run "bluetoothd"
--> Run "obexd"
--> On SET_PATH command it sends the obex session value as NULL.


obexd[32713]: obexd/plugins/bluetooth.c:profile_new_connection() device
/org/bluez/hci0/dev_00_1B_DC_07_33_4E
obexd[32713]: obexd/src/obex.c:obex_session_start()
obexd[32713]: obexd/src/obex.c:cmd_connect()
obexd[32713]: CONNECT(0x0), (null)(0xffffffff)
obexd[32713]: obexd/src/obex.c:cmd_connect() Selected driver: Message Access
server
obexd[32713]: obexd/plugins/mas.c:mas_connect() 
obexd[32713]: CONNECT(0x0), (null)(0x0)
obexd[32713]: obexd/src/obex.c:cmd_setpath()
obexd[32713]: obexd/src/obex.c:cmd_setpath() (null)
obexd[32713]: SETPATH(0x5), (null)(0xffffffff)
obexd[32713]: obexd/src/obex.c:parse_name() NAME:
obexd[32713]: obexd/plugins/mas.c:mas_setpath() SETPATH: name  nonhdr 0x20
obexd[32713]: SETPATH(0x5), NOT_FOUND(0x44)

Do we need to configure or run anything else before starting up obexd?



