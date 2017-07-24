Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Natalya Rozhnova <rozhnova.natalya@gmail.com>
Date: Mon, 24 Jul 2017 17:03:51 +0200
Message-ID: <CAMybWM1H9rxVW+np0r0y1cagPudcX15Xht5ZkSkmLn0gwFkCuw@mail.gmail.com>
Subject: Understanding GATT database
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I am trying to understand the difference between the gatt_db stored in
the device structure and the one stored in bt_gatt_client structure. I
see that the database stored in the device is recovered from the
cache. I would like to understand what it is used for if anyway the
new one is created during the discover_services phase? Another
question that would very probably help me to understand this better:
if I copy the device->db to client->db, would it still work or we
really need to pass by a communication with a BLE device and compose
the database from scratch?

Could anybody explain me this please?

Thanks a lot for your time,
Best regards,
Natalya
