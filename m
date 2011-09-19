Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: 
Date: Mon, 19 Sep 2011 10:52:30 +0200
Message-Id: <1316422359-16167-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Next set of patches enhances support for health thermometer thermomter profile.

[PATCH 1/9] Load device driver if thermometer service attribute
[PATCH 2/9] Register Health Thermometer Interface
[PATCH 3/9] Unregister Health Thermometer Interface
[PATCH 4/9] Add functions to manage attio callbacks
[PATCH 5/9] Add handler function to manage GATT indications
[PATCH 6/9] Get all characteristics in thermometer service
[PATCH 7/9] Read temperature type characteristic
[PATCH 8/9] Read measurement interval characteristic
[PATCH 9/9] Set Intermediate property if intermediate temp.
