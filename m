Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [RFC 0/3] Gatt Client Characteristic Configuration
Date: Tue, 27 May 2014 16:33:40 +0200
Message-Id: <1401201223-17852-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds Client Characteristic Configuration descriptor for Service Changed
Characteristic registered on gatt init. This stored value should be persistent
across connections for bonded devices, thus gatt specific api was aded to
bluetooth core profile exposing storage functionality.

We could consider creating more generic functions, allowing to store custom
<key, value> pairs. that other profiles could use aswell. Then on every value
read we would access the file as we do on write, instead of storing it in device
along with other properties.

I'm not sure which aproach would be better. Should we go with the generic
version already or do it later if it turns out that we need to store more
thing for more profiles?

Regards,

Jakub Tyszkowski (3):
  android: Add gatt CCC value storage
  android/gatt: Store CCC and indicate service change
  android/gatt: Make CCC descriptor readable

 android/bluetooth.c |  45 +++++++++++++++++
 android/bluetooth.h |   4 ++
 android/gatt.c      | 141 ++++++++++++++++++++++++++++++++++++++++++++++------
 3 files changed, 174 insertions(+), 16 deletions(-)

--
1.9.3

