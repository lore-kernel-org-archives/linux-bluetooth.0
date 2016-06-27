Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Mon, 27 Jun 2016 17:54:13 +0200
From: Arthur LAMBERT <lambertarthur22@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: gatt server and reset of hci device
Message-ID: <20160627155413.GA5294@arthur-bzh>
References: <20160511125102.GC17904@arthur-bzh>
 <CABBYNZ+c4mFuBUsR3uzOnMKMKJV-3GXkJiDZESoWzBvnXRg6Yg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CABBYNZ+c4mFuBUsR3uzOnMKMKJV-3GXkJiDZESoWzBvnXRg6Yg@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> Is that something preventing you to use bluetoothd and just create a
> plugin or use the GATT API for your server? Manually using hciconfig
> is not recommended since it may interfere with other users, for manual
> testing it is actually recommended to use btmgmt or bluetoothd +
> bluetoothctl. Also note that having btgatt-server along side with
> bluetoothd will not work because both listen on the same channel and
> the kernel can only redirect the packets to one process.

If I want to properly implement custom gatt service with dbus instead of low c api.
Can we use the python script test/example-gatt-server as reference ?
Is there any example in c using glibdbus ?

Is it normal that I am not able to run it with success ?


* Run bluetoothd with experimental mode enable :
sudo ./bluetoothd -E

* Run python script from test directory :
[arthur ] python3  ./example-gatt-server
Failed to register application: org.bluez.Error.Failed: No object received

Thanks,
Arthur.
