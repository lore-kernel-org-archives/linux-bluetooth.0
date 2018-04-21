Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAGuV3hPxvhDbsO1TZLcQwtQuAWrm5TqQrH=zG3UrFsvjfZOeFA@mail.gmail.com>
References: <CAGuV3hPxvhDbsO1TZLcQwtQuAWrm5TqQrH=zG3UrFsvjfZOeFA@mail.gmail.com>
From: Fulko Hew <fulko.hew@gmail.com>
Date: Fri, 20 Apr 2018 22:01:20 -0400
Message-ID: <CAGuV3hM+GPfDQf5C6-Ug8R+QPe-xo361TgVTem2HjWjnZ0To2Q@mail.gmail.com>
Subject: Fwd: Help with LE Create Connection
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I'm doing my first Bluetooth app, and I have a specific question and a
general question:

1/ Where can I find documentation on the BlueZ API?
   I've searched and haven't found anything yet.

2/ I've captured a trace of an existing conversation off of my Android phone,
   and I'm trying to re-create it via my own app using BlueZ.
   I've gotten to the point of trying to do an LE Create Connection
via hci_le_create_conn()
   and my first stumbling block is the value of the 'peer address type'.
   From my investigation, I need to use the 'public' address type
which according to
   the spec, and Wireshark is a value of 0x00, but bluetooth.h defines
'public' as 0x01
   (as per the following extract).  Can anyone explain it to me?

   #define BDADDR_BREDR           0x00
   #define BDADDR_LE_PUBLIC       0x01
   #define BDADDR_LE_RANDOM       0x02

TIA
Fulko
