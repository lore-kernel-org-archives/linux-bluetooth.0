Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/3] Make GATT example server a separate plugin
Date: Tue, 29 Mar 2011 12:15:25 -0400
Message-Id: <1301415328-14257-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

These patches move the example server into a separate plugin. Currently, it is
inside the "Attribute plugin" and was always enabled when GATT support was
enabled. Making a separate plugin allows to disable it on production systems.

The last two patches remove hard-coded attribute handles from the plugin, which
will avoid handle conflicts between multiple profile plugins. The
attrib_db_find_avail() function was borrowed from my previous RFC series.

Note that these patches should be applied after Vinicius' "Attrib client move"
series.

