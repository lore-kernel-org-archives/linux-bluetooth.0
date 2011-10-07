Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH obexd 0/1] Fix OPP not sending TransferCompleted signal
Date: Fri,  7 Oct 2011 11:11:09 +0200
Message-Id: <1317978670-24903-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The following is kind of a lazy fix. Share your view on dealing with that. I'd
guess that more appropriate fix would be to remove the "os->object != NULL"
check from manager_emit_transfer_completed() and instead make a simple session
object in OPP being single gboolean or even use user_data pointer directly as a
boolean indicator to let the opp_reset() know whether or not
obex_put_stream_start() was successful.

Btw shouldn't we also do manager_emit_transfer_started() in opp_get()?
