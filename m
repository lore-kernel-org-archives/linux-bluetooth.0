Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Travis Griggs <travisgriggs@gmail.com>
Content-Type: text/plain; charset=utf-8
Subject: Best schema to "stream" data over BLE
Message-Id: <EB98033C-EA6B-45A7-AC0D-DD2F2FAD69E6@gmail.com>
Date: Tue, 10 May 2016 18:23:06 -0700
To: linux-bluetooth@vger.kernel.org
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The GATT architecture of BLE lends itself to small fixed pieces of data (20 bytes max per characteristic). But in some cases, you end up wanting to “stream” some arbitrary length of data, that is greater than 20 bytes. For example, a firmware upgrade, even if you know its slow.

I’m curious what scheme others have used if any, to “stream” data (even if small and slow) over BLE characteristics. I’m also curious how fast I can expect the bluez stuff to go when it’s having to channel through dbus.  I’ve used two different schemes to date. One was to use a control characteristic, where the receiving device notify the sending device how much data it had received, and the sending device then used that to trigger the next write (I did both with_response, and without) on a different characteristic. Another scheme I did recently, was to basically chunk the data into 19 byte segments, where the first byte indicates the number of packets to follow, when it hits 0, that clues the receiver that all of the recent updates can be concatenated and processed as a single packet.

I’m finding bluez pretty slow. Running between iOS and an STMicro chip, I can get around 500bytes/sec. But between iOS and bluez (embedded Linux, python3 with dbus), I’m getting much less, about 125 bytes/sec. The speed isn’t a show stopper. I’m really just curious what schemes (if any) others have used.

TIA