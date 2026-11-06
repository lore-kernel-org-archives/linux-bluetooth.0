Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.29
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793939043;
	b=XXXzdfNfoA+P7VI+HRc/7ZMT06oAy8qMQYkqXaNtduIrXhxkxjdgRPS3FOL8N4KYHx/x
	 bopYbtjPTZMil1P6q2nS01yVjmwuntB95Z8PRsLbwhd2jU1dpm9/tiCG5UiYfeinuaNZe
	 25qkwBF69P4pkffm/OXBw/d1cLUb0/me8IeOeb5nwe1xAfgdOUG05yW3wlxxidBYYyWyD
	 PgR1JJ9yiaR68WTnMKxBrL8kEXuVwdAIumZXg01Szm7+zKNCZenIGXToUDwrUePMsgJoX
	 3xe8vICYhEht/vzzWNB0GirIFHG1G3QUccXHyd4mL3W5RJ85IWZtPd8rFd7e6KUaz0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793939043;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=BMKYuXZmiYENzeVvhhpfUwHVIzKFteD70oizhmzgDgI=;
	b=NLdk+6Ym6e9JBK2266WPl+ElNhgbShZuovy5Asrsht9yb+FFMsV36KfjeHph1H4mnogU
	 uTysZt82l4H2LROAQ6wcnr/1csEgeoWyRcV9G707vZ9991F1bmADydNGzQx5Cz1pT5LNO
	 ObfnusziEY6Ie5ZQUtKhiOBL62QJpXXQXdDvjJIgNnKTDiMJETx9jz0z4uaCfT8ZZ1hSG
	 Dxm/totbiNkF5dbjY12PbF8LigBa56fR9EK8hDvXhA9sR2eNw2tR2PxmOfijwpBPqr890
	 TgImi2Qg/sM/cMddX5jBhBBR1iGk2DS1rBfmLeSFG3VLZLyUFj38jKx2CV8PylXkORA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=z2r5yeexsncgtdkzcaohxkwige.protonmail2 header.b="p/n+epzv";
	arc=none smtp.remote-ip=79.135.106.29
Received: from mail-10629.protonmail.ch (mail-10629.protonmail.ch [79.135.106.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159AC606A31B
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Nov 2026 04:24:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 159AC606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=z2r5yeexsncgtdkzcaohxkwige.protonmail2 header.b=p/n+epzv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=z2r5yeexsncgtdkzcaohxkwige.protonmail2; t=1793939039;
	x=1794198239; bh=BMKYuXZmiYENzeVvhhpfUwHVIzKFteD70oizhmzgDgI=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=p/n+epzvSnXX7qZhU944MctGk171TiZyzt0wTTKmBMAaiGo0ojJOSacJCsuzwARqu
	 6T59tbMqqZUtbdcE5QhIvgN2AesuheY+8pLhyaiqxk/tKe92yT9L0ifmmfR6zNteQR
	 WsIjfZK8pz1RVIwo+qUnpK+AKRHfgJjxeDv9AvEbn99E4snyAG/F3gsvg8KUhZJSTz
	 ReZ3Y6NQTxqPPKlbvdbDRfGQUz9w81aW40OxyhwaSir4zxiY2gDEm4sz+4uUGhRqBs
	 bBto0bw4EmdKETYYRXSLvn3QG4kaVsthUfIG6H9wpO/C5ad6yo34gHE2bmft/Z+cr6
	 KJM3bucRaOk6A==
Date: Fri, 06 Nov 2026 04:23:57 +0000
To: linux-bluetooth@vger.kernel.org
From: Kyle Pepper <cochcoder@proton.me>
Subject: [PATCH] shared/timeout: Keep callback data alive during removal
Message-ID: <20261106042339.811655-1-cochcoder@proton.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: 0cb1ccb90f6f0fb18a4e1b9072f379e4938802ec
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

A timeout callback can remove its own timer. The mainloop then destroys
the wrapper before timeout_callback reads its identifier again.

Hold a reference while dispatching and clear the identifier when the
timer is destroyed. This also prevents a removed callback from modifying
a replacement timer that reused its descriptor. Keep user destruction
synchronous for timerfd timers.

Add unit coverage for idle and timerfd timers with one-shot, repeating,
self-removing and replacement callbacks.

Fixes: 1f11ee8f5194 ("shared: Add timeout handling with mainloop support")
Assisted-by: Codex:GPT-6
---
 src/shared/timeout-mainloop.c |  26 +++++++--
 unit/test-mainloop.c          | 100 ++++++++++++++++++++++++++++++++++
 2 files changed, 121 insertions(+), 5 deletions(-)

diff --git a/src/shared/timeout-mainloop.c b/src/shared/timeout-mainloop.c
index e6f9c5e826..edcc801114 100644
--- a/src/shared/timeout-mainloop.c
+++ b/src/shared/timeout-mainloop.c
@@ -16,31 +16,46 @@
=20
 struct timeout_data {
 =09int id;
+=09unsigned int ref_count;
 =09timeout_func_t func;
 =09timeout_destroy_func_t destroy;
 =09unsigned int timeout;
 =09void *user_data;
 };
=20
+static void timeout_unref(struct timeout_data *data)
+{
+=09if (!--data->ref_count)
+=09=09free(data);
+}
+
 static void timeout_callback(int id, void *user_data)
 {
 =09struct timeout_data *data =3D user_data;
+=09bool repeat;
=20
-=09if (data->func(data->user_data) &&
-=09=09=09!mainloop_modify_timeout(data->id, data->timeout))
-=09=09return;
+=09/* The callback may remove the timeout. */
+=09data->ref_count++;
+=09repeat =3D data->func(data->user_data);
+
+=09if (data->id) {
+=09=09if (!repeat || mainloop_modify_timeout(data->id, data->timeout))
+=09=09=09mainloop_remove_timeout(data->id);
+=09}
=20
-=09mainloop_remove_timeout(data->id);
+=09timeout_unref(data);
 }
=20
 static void timeout_destroy(void *user_data)
 {
 =09struct timeout_data *data =3D user_data;
=20
+=09data->id =3D 0;
+
 =09if (data->destroy)
 =09=09data->destroy(data->user_data);
=20
-=09free(data);
+=09timeout_unref(data);
 }
=20
 unsigned int timeout_add(unsigned int timeout, timeout_func_t func,
@@ -49,6 +64,7 @@ unsigned int timeout_add(unsigned int timeout, timeout_fu=
nc_t func,
 =09struct timeout_data *data;
=20
 =09data =3D new0(struct timeout_data, 1);
+=09data->ref_count =3D 1;
 =09data->func =3D func;
 =09data->user_data =3D user_data;
 =09data->timeout =3D timeout;
diff --git a/unit/test-mainloop.c b/unit/test-mainloop.c
index 70ee03ee42..4cff654147 100644
--- a/unit/test-mainloop.c
+++ b/unit/test-mainloop.c
@@ -12,6 +12,7 @@
 #include <stdlib.h>
=20
 #include "src/shared/mainloop.h"
+#include "src/shared/timeout.h"
=20
=20
 #define test_failed_msg(msg) \
@@ -153,6 +154,104 @@ static void test_timeout(struct test_data *data)
 =09check(data->destroys =3D=3D 1);
 }
=20
+struct wrapper_data {
+=09unsigned int id;
+=09unsigned int calls;
+=09unsigned int destroys;
+=09unsigned int replacement_calls;
+=09unsigned int replacement_destroys;
+=09unsigned int interval;
+=09bool repeat;
+=09bool remove;
+=09bool replace;
+};
+
+static void wrapper_destroy(void *user_data)
+{
+=09struct wrapper_data *data =3D user_data;
+
+=09data->destroys++;
+}
+
+static void replacement_destroy(void *user_data)
+{
+=09struct wrapper_data *data =3D user_data;
+
+=09data->replacement_destroys++;
+}
+
+static bool replacement_callback(void *user_data)
+{
+=09struct wrapper_data *data =3D user_data;
+
+=09data->replacement_calls++;
+=09mainloop_exit_success();
+=09return false;
+}
+
+static bool wrapper_callback(void *user_data)
+{
+=09struct wrapper_data *data =3D user_data;
+=09unsigned int replacement;
+
+=09data->calls++;
+
+=09if (data->remove) {
+=09=09timeout_remove(data->id);
+
+=09=09if (data->interval)
+=09=09=09check(data->destroys =3D=3D 1);
+
+=09=09if (data->replace) {
+=09=09=09replacement =3D timeout_add(1, replacement_callback,
+=09=09=09=09=09=09  data, replacement_destroy);
+=09=09=09check(replacement > 0);
+
+=09=09=09if (data->interval)
+=09=09=09=09check(replacement =3D=3D data->id);
+=09=09} else {
+=09=09=09mainloop_exit_success();
+=09=09}
+
+=09=09return data->repeat;
+=09}
+
+=09if (data->repeat && data->calls < 3)
+=09=09return true;
+
+=09mainloop_exit_success();
+=09return false;
+}
+
+static void test_timeout_wrapper(void)
+{
+=09unsigned int interval, mode;
+
+=09for (interval =3D 0; interval < 2; interval++) {
+=09=09for (mode =3D 0; mode < 6; mode++) {
+=09=09=09struct wrapper_data data =3D {
+=09=09=09=09.interval =3D interval,
+=09=09=09=09.repeat =3D mode & 1,
+=09=09=09=09.remove =3D mode >=3D 2,
+=09=09=09=09.replace =3D mode >=3D 4,
+=09=09=09};
+
+=09=09=09mainloop_init();
+=09=09=09data.id =3D timeout_add(interval, wrapper_callback,
+=09=09=09=09=09      &data, wrapper_destroy);
+=09=09=09check(data.id > 0);
+=09=09=09check(mainloop_run() =3D=3D EXIT_SUCCESS);
+=09=09=09check(data.calls =3D=3D
+=09=09=09=09=09(!data.remove && data.repeat ? 3 : 1));
+=09=09=09check(data.destroys =3D=3D 1);
+=09=09=09check(data.replacement_calls =3D=3D data.replace);
+=09=09=09check(data.replacement_destroys =3D=3D data.replace);
+=09=09=09fprintf(stderr, "Timeout wrapper %u/%u passed\n",
+=09=09=09=09interval, mode);
+=09=09}
+=09}
+}
+
 #define define_test(name, function)=09=09=09=09\
 =09do {=09=09=09=09=09=09=09\
 =09=09static struct test_data data =3D {};=09=09\
@@ -167,5 +266,6 @@ int main(int argc, char *argv[])
 =09define_test("Test Modify File Descriptor", test_modify_fd);
 =09define_test("Test Re-Add Other Callback", test_readd_other_callback);
 =09define_test("Test Timeout", test_timeout);
+=09test_timeout_wrapper();
 =09return 0;
 }

base-commit: 34b6f8e0e998728ce9e8e64e280d9d390c511804
--=20
2.56.0


