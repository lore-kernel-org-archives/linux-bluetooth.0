Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [RFC obexd] Support for adding custom OBEX headers before body
Date: Mon, 27 Jun 2011 16:20:50 +0200
Message-Id: <1309184455-29752-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is another attempt in sending headers in correct order. 

New function is ready for using it for sending headers in parts. However
I'm postponing work on suspending after sending available non-body
headers, as it is causing some problems (e.g. when the handle_async_io
would be called before OpenOBEX reaches header with suspend flag set) and
so it needs finding a better solution.

Patch 2 breaks a bit PBAP functionality - in case of requesting phone
book size, the body header will be sent as well. This is due to patch
splitting. Exact proper behaviour is back after applying patch 4.

