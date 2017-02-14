Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Dave Beal <dbeal@cardinalpeak.com>
Date: Mon, 13 Feb 2017 17:28:35 -0700
Message-ID: <CAHHBb0eePBK8bE3fkXJLdo5p1bhE42iOHxhwCiV1zgYvWg7k6g@mail.gmail.com>
Subject: How to receive Notifications?
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello -

I'm using the GATT API of BlueZ 5.43 via libdbus.  I've successfully
registered for notifications with the remote GATT server by calling
the StartNotify method on the characteristic.  I know that the
registration worked, because I see the remote server processing in.
How does my GATT client code get informed when a notification arrives?
 Thanks!

- Dave
