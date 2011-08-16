Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCH 3/8] Off-by-one error in uses_rfcomm
Date: Tue, 16 Aug 2011 11:46:44 +0200
Cc: "ovasik@redhat.com" <ovasik@redhat.com>
MIME-Version: 1.0
From: "Pavel Raiskup" <praiskup@redhat.com>
Message-ID: <op.v0av36jth52hc0@dhcp-25-209.brq.redhat.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Variable len could be assigned to PATH_MAX + 1 length (returned
 from readlink) and this variable is used as index to array link
of size only PATH_MAX + 1.
---
  compat/dun.c |    2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/compat/dun.c b/compat/dun.c
index 59f036f..de98830 100644
--- a/compat/dun.c
+++ b/compat/dun.c
@@ -104,7 +104,7 @@ static int uses_rfcomm(char *path, char *dev)

  	while ((de = readdir(dir)) != NULL) {
  		char link[PATH_MAX + 1];
-		int  len = readlink(de->d_name, link, sizeof(link));
+		int  len = readlink(de->d_name, link, PATH_MAX);
  		if (len > 0) {
  			link[len] = 0;
  			if (strstr(link, dev)) {
-- 
1.7.4.4
