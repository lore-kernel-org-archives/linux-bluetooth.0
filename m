Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Fri, 23 Oct 2015 10:03:00 -0700
Message-ID: <CAHugcUdZEwb1J8ephG9Nxk61UzTU-wbtArjcvj4tyU_jeSUbOA@mail.gmail.com>
Subject: Get the raw Bluetooth Low Energy advertising data
From: eroot <eigenroot@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I am trying to get raw BLE advertising information using Bluez tool
such as hcitool in a quick and dirty way. Someone (in this post
http://comments.gmane.org/gmane.linux.bluez.kernel/43422) modified the
"print_advertising_devices" function in "tools/hcitool.c", and he
claimed successfully printing out the advertising data from command
"sudo hcitool lescan". The "hcitool.c" can be conveniently viewed here
http://git.kernel.org/cgit/bluetooth/bluez.git/tree/tools/hcitool.c .
I guess the pointer "info" with type of "le_advertising_info" (defined
in "lib/hci.h") in  "print_advertising_devices" function has all
advertising information . A closer look into the struct definition

typedef struct {
uint8_t evt_type;
uint8_t bdaddr_type;
bdaddr_t bdaddr;
uint8_t length;
uint8_t data[0];
} __attribute__ ((packed)) le_advertising_info;

reveals that the data array has zero length. In that case, where is
the advertising data?
