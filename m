Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Multi-adapter GATT server support
Date: Tue, 27 Dec 2011 15:33:11 +0100
Message-Id: <1324996399-20245-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a new set of patches toward multiple adapter gatt server
support wich includes the changes suggested previously.

[PATCH 1/8] attrib-server: Initial steps towards multi-adapter GATT
[PATCH 2/8] attrib-server: Register GATT SDP record per each adapter
[PATCH 3/8] attrib-server: Add attributes in adapter database
[PATCH 4/8] attrib-server: Attach attrib_channel in adapter clients
[PATCH 5/8] attrib-server: Remove global le_io variable
[PATCH 6/8] attrib-server: Remove global database list
[PATCH 7/8] attrib-server: Mark attrib_channel_detach as deprecated
[PATCH 8/8] gatt-example: Use adapter driver to register GATT
