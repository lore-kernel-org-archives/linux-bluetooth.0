Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH RFC BlueZ 0/4] Time GATT Profile (server)
Date: Mon, 26 Sep 2011 17:01:33 -0400
Message-Id: <1317070897-17508-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Next in our "work in progress" profiles, is Time Profile. This short series
contain the implementation for the Current Time Service (including Local Time
Information characteristic), and a dummy "Reference Time Update Service"
(RTUS).

We are currently working on RTUS support for N9/harmattan, and we should send
an updated RFC containing it soon.

A few notes:

* Current Time Service implementation uses POSIX fuctions, so it should be
  platform independent.

* Reference Time Update Service needs a certain level of interaction with the
  platform, therefore we need an abstraction to support multiple platforms.

To follow current development (including the experimental N9 support), see:

git://gitorious.org/~lizardo/bluez/lizardo-bluez.git (branch "time-server")

Feedback is very welcome!
--
Anderson Lizardo
Instituto Nokia de Tecnologia (INdT)
Manaus - Brazil

