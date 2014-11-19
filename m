Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 19 Nov 2014 12:52:16 +0100
Message-ID: <CAHwR_AWwpJUOmF0E7XmsNu6pF1BxpPqtssXMt6FPJ5b+ftb4Ug@mail.gmail.com>
Subject: [PATCH] hciattach: Send timeout increase to support CC2564B
From: Jonas Rydow <jrydow@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch increases the send timeout, which for the CC2564B caused
HCI_VS_LE_Enable
to timeout and fail.
---
 tools/hciattach_ti.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/hciattach_ti.c b/tools/hciattach_ti.c
index 8322b45..3d231e2 100644
--- a/tools/hciattach_ti.c
+++ b/tools/hciattach_ti.c
@@ -253,7 +253,7 @@ static int brf_send_command_socket(int fd, struct
bts_action_send *send_action)
        rq.rparam = response;
        rq.rlen   = sizeof(response);

-       if (hci_send_req(fd, &rq, 15) < 0) {
+       if (hci_send_req(fd, &rq, 150) < 0) {
                perror("Cannot send hci command to socket");
                return -1;
        }
