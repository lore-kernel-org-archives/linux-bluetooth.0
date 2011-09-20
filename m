Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Health Thermomete Profile support
Date: Tue, 20 Sep 2011 19:47:12 +0200
Message-Id: <1316540841-14713-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Next set of patches enhances support for health thermometer thermomter profile.
They include fixes suggested in early set.

[PATCH 01/19] Get thermometer service range to load the driver.
[PATCH 02/19] Register Health Thermometer Interface
[PATCH 03/19] Unregister Health Thermometer Interface
[PATCH 04/19] Add functions to manage attio callbacks
[PATCH 05/19] Add handler function to manage GATT indications
[PATCH 06/19] Get all characteristics in thermometer service
[PATCH 07/19] Read temperature type characteristic
[PATCH 08/19] Read measurement interval characteristic
[PATCH 09/19] Set Intermediate property if intermediate temp.
