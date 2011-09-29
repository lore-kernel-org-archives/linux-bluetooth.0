Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Health Thermometer Profile patches
Date: Thu, 29 Sep 2011 15:46:19 +0200
Message-Id: <1317303988-26310-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a new set of patches for health thermometer profile.
They include all fixes suggested previously.	

[PATCH 1/9] Get thermometer service range to load the driver.
[PATCH 2/9] Register Health Thermometer Interface
[PATCH 3/9] Unregister Health Thermometer Interface
[PATCH 4/9] Add functions to manage attio callbacks
[PATCH 5/9] Add handler function to manage GATT indications
[PATCH 6/9] Get all characteristics in thermometer service
[PATCH 7/9] Read temperature type characteristic
[PATCH 8/9] Read measurement interval characteristic
[PATCH 9/9] Set Intermediate property if intermediate temp.
