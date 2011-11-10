Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Health Thermometer Profile (HTP)
Date: Thu, 10 Nov 2011 12:36:56 +0100
Message-Id: <1320925022-21891-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a new set of patches to enhance thermometer plugin fuctionality.
These patches enable watchers to receiave final/intermediate measurements
from thermometers devices. They also includes latest changes suggested
in the list.

[PATCH 1/6] Manage GATT attribute indications in handle callback.
[PATCH 2/6] Parse final measurement indication
[PATCH 3/6] Add org.bluez.ThermometerWatcher interface to default
[PATCH 4/6] Implement EnableIntermediateMeasurement D-Bus method
[PATCH 5/6] Implement DisableIntermediateMeasurement D-Bus method
[PATCH 6/6] Notify intermediate measurements
