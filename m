Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Health Thermometer Profile patches 
Date: Wed, 28 Sep 2011 19:48:37 +0200
Message-Id: <1317232126-12640-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Next set of patches enhances support for health thermometer thermomter profile.
They include fixes suggested other set.

[PATCH 1/9] Get thermometer service range to load the driver.
[PATCH 2/9] Register Health Thermometer Interface
[PATCH 3/9] Unregister Health Thermometer Interface
[PATCH 4/9] Add functions to manage attio callbacks
[PATCH 5/9] Add handler function to manage GATT indications
[PATCH 6/9] Get all characteristics in thermometer service
[PATCH 7/9] Read temperature type characteristic
[PATCH 8/9] Read measurement interval characteristic
[PATCH 9/9] Set Intermediate property if intermediate temp.
