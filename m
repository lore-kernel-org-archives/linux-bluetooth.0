Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Daniel Lenski <dlenski@gmail.com>
Date: Sat, 22 Aug 2015 00:35:37 -0700
Message-ID: <CAOw_LSH1_BjH28+Kn2vwxTrrF+4WBgXCn3FM27rubmCYximR0Q@mail.gmail.com>
Subject: detecting BLE compatibility of an adapter?
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
Does Bluez provide a way to detect the compatibility of a Bluetooth
adapter with Bluetooth 4.0/Low Energy?

I have written some command-line tools to interact with BLE devices
and have received a couple of bug reports from users who don't realize
that they don't have Bluetooth 4.0 adapters.

It appears that connect() with a BLE destination address results in
errno=EBADRQC. Is this errno value a reliable way to detect an
incompatible adapter? Is it possible to query the hci device to detect
compatibility without trying and failing?

    struct sockaddr_l2 srcaddr, dstaddr;

    memset(&dstaddr, 0, sizeof(dstaddr));
    dstaddr.l2_family = AF_BLUETOOTH;
    dstaddr.l2_cid = htobs(4); // ATT_CID
    dstaddr.l2_bdaddr_type = BDADDR_LE_RANDOM;
    ...
    connect(sock, (struct sockaddr *) &dstaddr, sizeof(dstaddr))

Thanks,
Dan
