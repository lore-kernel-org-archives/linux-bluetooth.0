Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: ken Clark <kenidevices@gmail.com>
Date: Thu, 5 Apr 2018 13:53:12 -0400
Message-ID: <CANB6vTsVX7Wc2kcxYHFBTK-TCxn2S_J2TzmB+NN=m7H76pXe8w@mail.gmail.com>
Subject: Long Characteristic Reads
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Trying to determine how to respond to long characteristic reads over d-bus.
My application is based on client/bluetoothctl
When I read a characteristic of > MTU size, I get multiple callbacks
to chrc_read_value, with the different offsets that need to be send in
the next transaction.

However I do not see a path in gatt.c to get the MTU for the current
connection, so I know how much data to send.
When I hardcode MTU everything works, but MTU is going to be dynamic
in our application.

Is there a way to access the connections MTU, or is there another
method for handling long reads requests?

Thanks,
Ken
