Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: Initial set of Management interface patches
Date: Wed, 24 Nov 2010 15:39:32 +0100
Message-Id: <1290609575-28435-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Here's an initial (short) set of patches for the upcoming management
interface which should hopefully be quite straght forward. Since
bluetoothd will nowdays automatically pick up and try to use this
interface it's disabled by default and can be enabled with the
enable_mgmt module parameter. I.e. it should be safe to push these
towards upstream trees. Once I've received acks on these I'll start
preparing the patches which add some real functionality (i.e. message
handling) for managment sockets.

Johan

