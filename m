Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: Patches to fix kernel side init/deinit of adapters
Date: Tue, 14 Dec 2010 14:04:02 +0200
Message-Id: <1292328244-5335-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Before I start implementing support for powering on and off adapters
through the management interface some basic things in the current code
need fixing. The first issue is that the __hci_request doesn't work the
way it's supposed to when called from hci_open_dev. It's supposed to
return when the entire request is complete but right now it returns as
soon as the first command in the request is complete.

The first patch in this set is needed to make it possible to take
advantage of the HCI_INIT flag in the second patch.

Johan

