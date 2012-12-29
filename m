Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Sat, 29 Dec 2012 21:01:38 +0100
Message-ID: <CAJN7YmO4th=T2u0s9ya6fEwjO5RdEiVZCfyhTHRLb94u9Q2KeA@mail.gmail.com>
Subject: inconsistency in configure.ac for BlueZ 5.0 : GLib 2.32 required
From: Giovanni Gherdovich <g.gherdovich@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

I believe there is a little inconsistency in configure.ac
of BlueZ 5.0:

it requires GLib 2.28, but actually the files

/profiles/audio/avctp.c
/src/adapter.c

use the function g_queue_free_full which appeared in
GLib 2.32
http://developer.gnome.org/glib/2.31/glib-Double-ended-Queues.html#g-queue-free-full

Even if the documentation states clearly that g_queue_free_full
appeared in GLib 2.32, I used git bisect to be sure:

----------8<----------------------------
$ git clone http://git.gnome.org/browse/glib
$ cd glib
$ git bisect start 2.32.0 2.28.0
$ git bisect run /bin/bash -c "! grep -rq g_queue_free_full *"
[...]
1d4009e6f7e1d368b3e3df2fa41b007277b600d8 is the first bad commit
commit 1d4009e6f7e1d368b3e3df2fa41b007277b600d8
Author: Ravi Sankar Guntur <ravi.g@samsung.com>
Date:   Wed Dec 14 20:17:54 2011 +0530

    Added API g_queue_free_full().
[...]
----------8<----------------------------

so it was added here
http://git.gnome.org/browse/glib/commit/?id=1d4009e6f7e1d368b3e3df2fa41b007277b600d8
between tags 2.31.4 and 2.31.6

I don't know if it is better to change the configure.ac or to
substitute the (two) calls to g_queue_free_full with equivalent code
(that function is just a convenience method, its body is two lines).

In both cases, you can find a proposed patch below.
Or, maybe, I overlooked something obvious and there is no problem at all.

I used the git bisect trick to check when these two calls where
introduced in BlueZ, and here it is:

----------8<----------------------------
$ git clone http://git.kernel.org/pub/scm/bluetooth/bluez.git
$ cd bluez
$ git bisect start 5.0 4.0
$ git bisect run /bin/bash -c "! grep -rq g_queue_free_full *"
[...]
0314008ff39d156ff1a98c2f20f13284983d0d84 is the first bad commit
commit 0314008ff39d156ff1a98c2f20f13284983d0d84
Author: Mikel Astiz <mikel.astiz@bmw-carit.de>
Date:   Fri Sep 28 18:32:24 2012 +0200

    adapter: Queue parallel authorization requests
[...]
$ git bisect reset
$ git bisect run /bin/bash -c "! grep -rq g_queue_free_full .
--include=\"*avctp.c\""
[...]
a835942875da320cc2a2dba6898081d17a07efdf is the first bad commit
commit a835942875da320cc2a2dba6898081d17a07efdf
Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Date:   Mon Oct 15 16:05:30 2012 +0200

    AVCTP: Add proper queueing for channels
[...]
----------8<----------------------------

So the commits which introduced those two calls are

http://git.kernel.org/?p=bluetooth/bluez.git;a=commit;h=a835942875da320cc2a2dba6898081d17a07efdf
and
http://git.kernel.org/?p=bluetooth/bluez.git;a=commit;h=0314008ff39d156ff1a98c2f20f13284983d0d84

proposed patches follow.

Best regards,
Giovanni Gherdovich
ggherdov on #bluez @ freenode

----------8<----------------------------
>From 6e0047a014605237dbbd18f3dc69d7af74037fb5 Mon Sep 17 00:00:00 2001
From: Giovanni Gherdovich <g.gherdovich@gmail.com>
Date: Sat, 29 Dec 2012 18:26:03 +0100
Subject: [PATCH] Updated dependency to glib version from 2.28 to 2.32

the tree makes use of the function g_queue_free_full which is
available only from GLib 2.32, while configure.ac requires
GLib version 2.28
---
 configure.ac |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index cdfc013..8873af0 100644
--- a/configure.ac
+++ b/configure.ac
@@ -43,8 +43,8 @@ AC_CHECK_FUNC(signalfd, dummy=yes,
 AC_CHECK_LIB(dl, dlopen, dummy=yes,
 			AC_MSG_ERROR(dynamic linking loader is required))

-PKG_CHECK_MODULES(GLIB, glib-2.0 >= 2.28, dummy=yes,
-				AC_MSG_ERROR(GLib >= 2.28 is required))
+PKG_CHECK_MODULES(GLIB, glib-2.0 >= 2.32, dummy=yes,
+				AC_MSG_ERROR(GLib >= 2.32 is required))
 AC_SUBST(GLIB_CFLAGS)
 AC_SUBST(GLIB_LIBS)

-- 
1.7.4.1

----------8<----------------------------
>From 159bede1a24e060c614a4934627d696ab9bd8a7d Mon Sep 17 00:00:00 2001
From: Giovanni Gherdovich <g.gherdovich@gmail.com>
Date: Sat, 29 Dec 2012 19:32:29 +0100
Subject: [PATCH] Replaced calls to g_queue_free_full function

The function g_queue_free_full is available only from GLib 2.32.
If BlueZ has to build against GLib 2.28, as stated in the configure.ac,
this patch replaces the calls to g_queue_free_full with its
definition, taken from the sources of GLib 2.32.
---
 profiles/audio/avctp.c |    3 ++-
 src/adapter.c          |    3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
index 013c587..745ced8 100644
--- a/profiles/audio/avctp.c
+++ b/profiles/audio/avctp.c
@@ -395,7 +395,8 @@ static void avctp_channel_destroy(struct
avctp_channel *chan)
 		g_source_remove(chan->process_id);

 	g_free(chan->buffer);
-	g_queue_free_full(chan->queue, pending_destroy);
+	g_queue_foreach(chan->queue, (GFunc)pending_destroy, NULL);
+	g_queue_free(chan->queue);
 	g_slist_free_full(chan->processed, pending_destroy);
 	g_slist_free_full(chan->handlers, g_free);
 	g_free(chan);
diff --git a/src/adapter.c b/src/adapter.c
index e71cea8..a244ae2 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1697,7 +1697,8 @@ static void adapter_free(gpointer user_data)
 	if (adapter->auth_idle_id)
 		g_source_remove(adapter->auth_idle_id);

-	g_queue_free_full(adapter->auths, g_free);
+	g_queue_foreach (adapter->auths, (GFunc)g_free, NULL);
+	g_queue_free (adapter->auths);

 	sdp_list_free(adapter->services, NULL);

-- 
1.7.4.1

----------8<----------------------------
