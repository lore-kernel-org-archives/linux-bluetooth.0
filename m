Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Health Thermometer Profile 
Date: Thu, 13 Oct 2011 17:29:13 +0200
Message-Id: <1318519762-17475-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a new set of patches for HTP wich include all changes sugested previously.

[PATCH 1/9] Get thermometer service range to load the driver.
[PATCH 2/9] Register Health Thermometer Interface
[PATCH 3/9] Unregister Health Thermometer Interface
[PATCH 4/9] Add functions to manage attio callbacks
[PATCH 5/9] Add handler function to manage GATT indications
[PATCH 6/9] Get all characteristics in thermometer service
[PATCH 7/9] Read temperature type characteristic
[PATCH 8/9] Read measurement interval characteristic
[PATCH 9/9] Set Intermediate property if intermediate temp.
