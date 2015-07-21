Return-Path: <cyrus@holtmann.org>
From: Anupam Roy <anupam.r@samsung.com>
To: linux-bluetooth@vger.kernel.org
Subject: RE: [PATCH] android/client/if-hl.c:Handle failure from malloc() request
Date: Tue, 21 Jul 2015 09:01:17 -0400
Message-id: <1437483677-9793-1-git-send-email-anupam.r@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Ping

> -----Original Message-----
>From: Anupam Roy <anupam.r@samsung.com>
>To: linux-bluetooth@vger.kernel.org
>Cc:sachin.dev@samsung.com; anupam.r@samsung.com
>Date : Jun 23, 2015 21:04 (GMT+09:00)
>Title : [PATCH] android/client/if-hl.c:Handle failure from malloc() request
>
>
>In case malloc() request fails, just print error message
>and return. Dereferencing reg.mdep_cfg in case of failure
>can lead to crash.
>---
> android/client/if-hl.c | 4 ++++
> 1 file changed, 4 insertions(+)
>
>diff --git a/android/client/if-hl.c b/android/client/if-hl.c
>index e0818ba..bd05671 100644
>--- a/android/client/if-hl.c
>+++ b/android/client/if-hl.c
>@@ -201,6 +201,10 @@ static void register_application_p(int argc, const char **argv)
> 	reg.number_of_mdeps = atoi(argv[6]);
> 
> 	reg.mdep_cfg = malloc(reg.number_of_mdeps * sizeof(bthl_mdep_cfg_t));
>+	if (!reg.mdep_cfg) {
>+		haltest_error("malloc failed\n");
>+		return;
>+	}
> 	mdep_argc_init = 7;
> 
> 	for (i = 0; i < reg.number_of_mdeps; i++) {
>-- 
>1.9.1

