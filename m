Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Health Thermometer Profile 
Date: Thu, 20 Oct 2011 11:46:43 +0200
Message-Id: <1319104011-27747-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This set of patches enable applications to register watchers in order to
receive final measurements.

[PATCH 1/8] Process characteristic descriptors in thermometer service.
[PATCH 2/8] Get valid range descriptor if it is supported
[PATCH 3/8] Implement D-Bus register watcher function
[PATCH 4/8] Implement D-Bus unregister watcher function
[PATCH 5/8] Enable final measurement indications when first watcher
[PATCH 6/8] Disable final measurements indication when last watcher
[PATCH 7/8] Manage watcher's disconnections from the bus
[PATCH 8/8] Implement D-Bus get properties function
