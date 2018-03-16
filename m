Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Robert_Luba=C5=9B?= <robert.lubas@silvair.com>
Date: Fri, 16 Mar 2018 09:14:36 +0100
Message-ID: <CACgnnk=4aQiprXz1iY33kmPf2jYT=pPzr4c20N1n4Xt7m4322Q@mail.gmail.com>
Subject: [PATCH BlueZ] mesh: Fix proxy PDU SAR msg length
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In read_pipe function there was a mishandled case when the msg has
more than one segment. As a result e.g. after provisioning the
capabilities discovery was incorrect parsed.

---
 mesh/gatt.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/mesh/gatt.c b/mesh/gatt.c
index 9116a9de1..8fecac10b 100644
--- a/mesh/gatt.c
+++ b/mesh/gatt.c
@@ -383,7 +383,7 @@ static bool pipe_read(struct io *io, bool prov,
void *user_data)
        uint8_t buf[512];
        uint8_t *res;
        int fd = io_get_fd(io);
-       ssize_t len;
+       ssize_t len, len_sar;

        if (io != notify_io)
                return true;
@@ -393,14 +393,13 @@ static bool pipe_read(struct io *io, bool prov,
void *user_data)
                        break;

                res = buf;
-               mesh_gatt_sar(&res, len);
-
-               if (prov)
-                       prov_data_ready(node, res, len);
-               else
-                       net_data_ready(res, len);
+               if (len_sar = mesh_gatt_sar(&res, len)) {
+                       if (prov)
+                               prov_data_ready(node, res, len_sar);
+                       else
+                               net_data_ready(res, len_sar);
+               }
        }
-
        return true;
 }
