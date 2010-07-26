Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Notification of SDP changes to device drivers
Date: Mon, 26 Jul 2010 09:55:26 +0200
Message-Id: <1280130927-4137-1-git-send-email-santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

This patch is the one that I mentioned that was needed to HDP for 
updating the services. When a search services is performed using the
device API, the stored records will be compared with the new found and 
if there are any diferences the driver will receive a notification.

I've made this optional in order to keep backwards compatibility, so no extra
changes are needed in the drivers if they don't care about the SDP changes.

Regards

