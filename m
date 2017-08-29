Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Anupam Roy <anupamroy4u@gmail.com>
Date: Tue, 29 Aug 2017 22:22:29 +0530
Message-ID: <CAM8s=c8JqfCoqZ5-to1ojuNc9rHMHUFR0T9myuY95a5GnPA+zQ@mail.gmail.com>
Subject: Regarding accept of GATT service
To: linux-bluetooth@vger.kernel.org
Cc: "anupam.r@samsung.com" <anupam.r@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
  I have a following query regarding accept callback of Bluez profiles.

Is it not possible to host multiple  GATT profiles in Bluez who could
be interested to same remote uuid?  for ex) GATT_UUID ?

It looks like even though Bluez does probe(.device_probe) of service
during device enumerations (either during loading of devices of
previously connected devices or during connect of fresh device), but
it does not accept (.accept) service to all the profiles who were
interested in the same remote uuid.
Bluez only seems to accept service for the first matching service from
the list of services filled in the device during probing.

Any insight to the above query will be helpful. Thank You very much!

BR,
-Anupam Roy
