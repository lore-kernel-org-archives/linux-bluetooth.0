Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Natalya Rozhnova <rozhnova.natalya@gmail.com>
Date: Tue, 16 May 2017 10:49:27 +0200
Message-ID: <CAMybWM3jHv75hrixjk3Ep8Er7Qkw8T5peKTN6SNE3qJLg9n2eg@mail.gmail.com>
Subject: Understanding Bluez mgmt events
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I'm trying to understand the mgmt events in Bluez.
If I understand correctly, the MGMT_OP_... commands are first sent as following:

mgmt_send(adapter->mgmt, MGMT_OP_START_DISCOVERY, ...)

And then it should trigger a corresponding event like
MGMT_EV_DISCOVERING, MGMT_EV_DEVICE_FOUND etc.

I'm quite lost in understanding who, where and how generates these
MGMT_EV... events...
Could anybody please explain this on a simple example or showing a
piece of code in bluez sources where it is done...

Thanks in advance for any help,
Natalya
