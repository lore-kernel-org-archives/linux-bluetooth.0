Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 18 Mar 2015 17:34:14 -0700
Message-ID: <CAOeGgQbocwoLNTy3X23++6C4SOTdYFRK0OQ+r7ZkSrV35yaLVw@mail.gmail.com>
Subject: Persistent mapping from BT hardware to hci name
From: Yey Yuan <yey@google.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I want a stable mapping from bluetooth hardware to hciX under
/sys/class/bluetooth, similar to how wlanX maps to wifi chips.

I wrote a udev rule. The rule is matching correctly by vender/product.
But how do i actually change the name? With wlan, i can simply specify
NAME="wlan0". It doesn't work with BT.

Here is the udev rule:
SUBSYSTEM="bluetooth", ATTRS{idVendor}=="foo",
ATTRS={idProduct}="bar", RUN+="some_no_op_script.sh"

Thanks!
