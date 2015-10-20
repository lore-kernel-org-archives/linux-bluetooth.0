Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 20 Oct 2015 10:08:33 +0800
Message-ID: <CACw_oNeQP+FH2J0stR9ZGU5=xyHXiuN-XkAynrFwXqeyaq833A@mail.gmail.com>
Subject: Is it correct that bluez sometimes stores a negative value for RAND
 key in info file ?
From: M Ren <itux.ren@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I use bluetoothctl to pair with a BLE remote controller(RCU) ,
bluez creates a folder (named after RCU's bdaddr)
and 2 files under it (info , attributes),

odd thing is , in file info ,
there is a RAND key in [LongTermKey] group ,
paring many times , sometimes RAND will show a negative value in info ,

after look into source code , I found RAND is stored using
g_key_file_set_uint64(key_file, group, "Rand", rand); (src/adapter.c
store_longtermkey()) ,
from the api 's name , RAND should be a uint64 type , why it shows
negative sometimes?
