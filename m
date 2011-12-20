Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: RFC: Multi-adapter GATT server support
Date: Tue, 20 Dec 2011 16:57:53 +0100
Message-Id: <1324396681-27276-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Here you have a new set of rearranged patches wich initialize and stop
a GATT server in each adapter. Now, all GATT stuff is managed separately
in the adapter instead using global lists and variables.

Next step is to modify gatt server api in order to provide the adapter
in which GATT servers will able to register the attributes for each
service. This feature will enable plugins to register services when each
adapter is plugged instead doing that when the plugins are initialized.

comments are welcome.

[PATCH 1/8] attrib-server: Initial steps towards multi-adapter GATT
[PATCH 2/8] attrib-server: Register GATT SDP record per each adapter
[PATCH 3/8] attrib-server: Add attributes in adapter database
[PATCH 4/8] attrib-server: Attach attrib_channel in adapter clients
[PATCH 5/8] attrib-server: Remove global le_io variable
[PATCH 6/8] attrib-server: Remove global database list
[PATCH 7/8] attrib-server: Mark attrib_channel_detach as deprecated
[PATCH 8/8] gatt-example: Use adapter driver to register GATT
