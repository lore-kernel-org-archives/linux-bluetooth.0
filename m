Return-Path: <cyrus@holtmann.org>
From: Tomasz Bursztyka <tomasz.bursztyka@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Tomasz Bursztyka <tomasz.bursztyka@linux.intel.com>
Subject: [PATCH] gdbus: Fix double free when calling g_dbus_remove_all_watches
Date: Wed, 19 Dec 2012 14:01:37 +0200
Message-Id: <1355918497-21944-1-git-send-email-tomasz.bursztyka@linux.intel.com>
In-Reply-To: <20121128122318.GA30710@x220.ger.corp.intel.com>
References: <20121128122318.GA30710@x220.ger.corp.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Valgrind output:
==21779== Invalid free() / delete / delete[] / realloc()
==21779==    at 0x4A080BC: free (vg_replace_malloc.c:427)
==21779==    by 0x406700: filter_data_free (watch.c:285)
==21779==    by 0x406D92: g_dbus_remove_all_watches (watch.c:315)
==21779==    by 0x408787: connman_interface_finalize (interface.c:99)
==21779==    by 0x40EA14: main (main.c:113)
==21779==  Address 0x6893810 is 0 bytes inside a block of size 56 free'd
==21779==    at 0x4A080BC: free (vg_replace_malloc.c:427)
==21779==    by 0x406D81: g_dbus_remove_all_watches (watch.c:309)
==21779==    by 0x408787: connman_interface_finalize (interface.c:99)
==21779==    by 0x40EA14: main (main.c:113)
---
Hi Johan,

I finally put the valgrind output, since backtrace is actually useless:

*** glibc detected *** ./project: double free or corruption (fasttop): 0x000000000075b5a0 ***
======= Backtrace: =========
/lib64/libc.so.6(+0x7adf5)[0x7f6701e5adf5]
./project[0x4066b1]
./project[0x406d43]
./project[0x408738]
./project[0x40e9a5]
/lib64/libc.so.6(__libc_start_main+0xfd)[0x7f6701e024bd]
./project[0x4053f9] 

Anyway, this bug was never found before for a good reason: no projects (but mine) uses g_dbus_remove_all_watches()

 gdbus/watch.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/gdbus/watch.c b/gdbus/watch.c
index 9e4f994..9451d5d 100644
--- a/gdbus/watch.c
+++ b/gdbus/watch.c
@@ -309,6 +309,9 @@ static void filter_data_call_and_free(struct filter_data *data)
 		g_free(cb);
 	}
 
+	g_slist_free(data->callbacks);
+	data->callbacks = NULL;
+
 	filter_data_free(data);
 }
 
-- 
1.8.0.2

