Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20160629123310.GA11250@arthur-bzh>
References: <20160629123310.GA11250@arthur-bzh>
From: Tobias Svehagen <tobias.svehagen@gmail.com>
Date: Wed, 29 Jun 2016 15:22:52 +0200
Message-ID: <CADwkJj+eSMWVAR+4nP3w9BUzbc6Wuzu62gmtq6=-BdLEsJTowg@mail.gmail.com>
Subject: Re: gatt server and reset of hci device
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> [arthur ] sudo ./bluetoothd -nE -d src/gatt-database.
> bluetoothd[11131]: Bluetooth daemon 5.39
> bluetoothd[11131]: Starting SDP server
> bluetoothd[11131]: Bluetooth management interface 1.4 initialized
> bluetoothd[11131]: Failed to obtain handles for "Service Changed" characteristic
> bluetoothd[11131]: Failed to read advertising features: Unknown Command (0x01)
> bluetoothd[11131]: hci0 Load Connection Parameters failed: Unknown Command (0x01)
>
> This test is running on ubuntu 14.04. We stop bluetooth service before starting bluetoothd.
> We also run the test on arm target but without trouble this time.

Okay, the 'Unknown Command' lines don't look so good, what kernel are
you running?
