Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Fran=C3=A7ois_Beaufort?= <beaufort.francois@gmail.com>
Date: Tue, 24 Nov 2015 13:09:11 +0100
Message-ID: <CAEZxfGOFqWkC84Yq9emU76WYqBY-0rGhgGEEBQ_dCr1XTTk2CQ@mail.gmail.com>
Subject: Add name and namePrefix filter to SetDiscoveryFilter
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The SetDiscoveryFilter method already has UUIDs, RSSI, Pathloss and
Transport filters.
I was wondering if it would be possible to add "name" and "namePrefix"
filters to this list?

I'm shamelessly asking this because the Web Bluetooth API has added
these filters: http://webbluetoothcg.github.io/web-bluetooth/#dictdef-bluetoothscanfilter
