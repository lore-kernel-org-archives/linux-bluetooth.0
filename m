Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Dave Beal <dbeal@cardinalpeak.com>
Date: Thu, 9 Feb 2017 12:10:00 -0700
Message-ID: <CAHHBb0cUctkkkisSdhosNms9QWmbRVwJm2BTwuEb64+V1eepag@mail.gmail.com>
Subject: Don't understand BlueZ 5 GATT interface
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello -

I'm trying to write a GATT client using BlueZ 5.19. Neither Python nor
glib are available in my environment, so I'm reduced to using libdbus.
I understand that I call Bluez's RegisterProfile method to specify the
UUID of the profile/service that I want to connect to, and that when a
matching remote device is found, Bluez will call my NewConnection
method. (This currently isn't working for me, but that's a different
question, posed in an earlier email.) The NewConnection call passes a
file descriptor that I use to talk to the remote device. Then what?
What do I send over the connection in order to, for instance, read and
write an attribute? Link layer messages? ATT protocol commands?
Thanks!

- Dave Beal
  dbeal@cardinalpeak.com
  Cardinal Peak, LLC
