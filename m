Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Syam Sidhardhan <s.syam@samsung.com>
Subject: [PATCH 3/3] a2dp: Fix invalid memory access during abort_ind()
Date: Mon, 21 Jan 2013 19:03:31 +0530
Message-id: <1358775211-31005-3-git-send-email-s.syam@samsung.com>
In-reply-to: <1358775211-31005-1-git-send-email-s.syam@samsung.com>
References: <1358775211-31005-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There is an invalid memory access w.r.t to the callback
during the Abort_Ind finalize_setup_errno().

We should terminate the variable arguments with NULL.

Log:
bluetoothd[3353]: audio/avdtp.c:avdtp_parse_cmd() Received ABORT_CMD
bluetoothd[3353]: audio/a2dp.c:abort_ind() Source 0xb6f5ecc8: Abort_Ind
bluetoothd[3353]: audio/a2dp.c:setup_ref() 0xb6f63200: ref=2
bluetoothd[3353]: audio/transport.c:media_transport_remove() Transport
 /org/bluez/3353/hci0/dev_BC_47_60_F5_88_89/fd1 Owner :1.0
bluetoothd[3353]: audio/transport.c:media_transport_release() Transport
 /org/bluez/3353/hci0/dev_BC_47_60_F5_88_89/fd1: read lock released
bluetoothd[3353]: audio/transport.c:media_transport_release() Transport
 /org/bluez/3353/hci0/dev_BC_47_60_F5_88_89/fd1: write lock released
bluetoothd[3353]: audio/transport.c:media_request_reply() Request
 Acquire Reply Input/output error
bluetoothd[3353]: audio/transport.c:media_owner_free() Owner :1.0
bluetoothd[3353]: audio/transport.c:media_owner_remove() Owner :1.0 Request Acquire
bluetoothd[3353]: audio/a2dp.c:a2dp_sep_unlock() SEP 0xb6f5ecc8 unlocked
bluetoothd[3353]: audio/a2dp.c:setup_unref() 0xb6f63200: ref=1
[sys_assert]START of sighandler
[sys-assert]exepath = bluetoothd
[sys-assert]processname = bluetoothd
[sys_assert]this thread is main thread. pid=3353
[sys-assert]cs timestr 1358524835
bluetoothd[3353]: crashed [1358524835] processname=bluetoothd, pid=3353, tid=3353, signal=11
[sys-assert]start print_node_to_file
sighandler = 0xb6e8cfc9, g_sig_oldact[i] = (nil)
[sys_assert]END of sighandler
Segmentation fault (core dumped)
---
 profiles/audio/a2dp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 3c546d9..efb4178 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -957,7 +957,7 @@ static void abort_ind(struct avdtp *session, struct avdtp_local_sep *sep,
 
 	finalize_setup_errno(setup, -ECONNRESET, finalize_suspend,
 							finalize_resume,
-							finalize_config);
+							finalize_config, NULL);
 
 	return;
 }
-- 
1.7.9.5

