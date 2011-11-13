Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/1] Remove driver only if remote has no matching UUID
Date: Sun, 13 Nov 2011 20:25:29 +0200
Message-Id: <1321208730-22957-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This patch of Daniel Orstadius seems to be was left without attention,
or lost. However, it fixes right thing. Currently, Headset interface
is removed for a device if one of HFP or HSP SDP records was not
provided. It doestn make sence, since the other profile is still valid.

What is done here is search of suported UUIDs of the given interface
on a remote device, and the interface is removed if none of supported
ones is found.

BR,
Dmitriy

