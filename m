Return-Path: <cyrus@holtmann.org>
From: Randy Yates <yates@digitalsignallabs.com>
To: Bluez Mailing List <linux-bluetooth@vger.kernel.org>
Subject: RequestDisconnection() Operation
Date: Sun, 24 Feb 2013 16:09:40 -0500
Message-ID: <87d2vpv2p7.fsf@randy.site>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The following question is regarding bluez 5.2:

There are at least two cases in which a remote bluetooth device "client"
connected to a profile managed by a local bluetooth device "server"
(via bluez) would disconnect:

  1. The remote bluetooth device client initiates a disconnect.

  2. The remote bluetooth device goes out of range.

Would a RequestDisconnection() method be invoked by the bluez stack in
both these cases?
-- 
Randy Yates
Digital Signal Labs
http://www.digitalsignallabs.com
