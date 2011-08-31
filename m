Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH obexd 0/2] obc_session_put enhancements
Date: Wed, 31 Aug 2011 15:35:12 +0200
Message-Id: <1314797714-25193-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Those two patches allows using application parameters header in PUT requests in
obex-client, also enabling more control over other headers and allowing
obex-client driver to receive notification upon transfer completion.

This is required for implementing MAP in obex-client.
