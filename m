Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: Persistent mapping from BT hardware to hci name
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAOeGgQbocwoLNTy3X23++6C4SOTdYFRK0OQ+r7ZkSrV35yaLVw@mail.gmail.com>
Date: Wed, 18 Mar 2015 19:02:45 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <2AE6E0C1-B1F5-4DDA-8B8D-122596D026C1@holtmann.org>
References: <CAOeGgQbocwoLNTy3X23++6C4SOTdYFRK0OQ+r7ZkSrV35yaLVw@mail.gmail.com>
To: Yey Yuan <yey@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Yey,

> I want a stable mapping from bluetooth hardware to hciX under
> /sys/class/bluetooth, similar to how wlanX maps to wifi chips.
> 
> I wrote a udev rule. The rule is matching correctly by vender/product.
> But how do i actually change the name? With wlan, i can simply specify
> NAME="wlan0". It doesn't work with BT.
> 
> Here is the udev rule:
> SUBSYSTEM="bluetooth", ATTRS{idVendor}=="foo",
> ATTRS={idProduct}="bar", RUN+="some_no_op_script.sh"

renaming of Bluetooth HCI interfaces is not supported. Just give the name as parameter to the script you are executing. udev actually knows the name of the Bluetooth HCI interface.

Regards

Marcel

