Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: RFC: GATT server multi-adapter support
Date: Fri, 16 Dec 2011 17:09:48 +0100
Message-Id: <1324051799-21439-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is an initial work to provide support for multiple adapters
in GATT server. Current implementation manages handlers and device
connections using global list without taking into account that we
can have many adapters plugged. These patches propose a separation
among handlers, clients management and other stuff in each adapter.

In this way, GATT servers plugins should register their attributes
on each adapter. Current interfaces doesn't provide support for that,
future work include exposing adapters in the APIS and using adapter
drivers to register attributes instead of doing that when the plugin
is initialized.

These patches don't modify current API yet, they use the default
adapter to manage GATT stuff when the adapter is not provided in
order to keep backward compatibility. In this way they can be
applied without causing compilation problems in GATT dependant
plugins which are using current GATT server interface.

Comments are welcome.

[PATCH 01/11] attrib-server: Initial steps to provide multi-adapter
[PATCH 02/11] attrib-server: Register GATT SDP record per each
[PATCH 03/11] attrib-server: Add attributes in adapter database
[PATCH 04/11] attrib-server: Attach attrib_channel in adapter
[PATCH 05/11] attrib-server: Remove global client list
[PATCH 06/11] attrib-server: Remove global le_io variable
[PATCH 07/11] attrib-server: Attah gatt channels to a adapters
[PATCH 08/11] attrib-server: Remove global database list
[PATCH 09/11] attrib-server: Mark attrib_channel_detach as
[PATCH 10/11] attrib-server: Remove
[PATCH 11/11] gatt-example: Use adapter driver to register GATT
