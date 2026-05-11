Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C0A28A72F
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 13:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778506362; cv=none; b=F4Szag96FRVOtw6v5eoA5ybl58xlPdk6rBsUbiEAomnOhp7cLEl8ZttLH1DPkwYoNPxzY3sQavkTwVEWQQdeRwHNzPvrmPvRvCA8VXXu709wP8SdxEgI7Q8HeHinQKwOKbPSH9eu353me99+3UgxN6lG2TNfPsJ0IwK6AVDb1wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778506362; c=relaxed/simple;
	bh=5teQI24YKKHEo+3eeWwpuEoaBsAY5iTnp+rCTTJ3njk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ntDlh0sCyJg1RvO8oIX9sEVVgGFYAmZip8hExVjGNJHPoJcdwwyGxevxKjLRJgOXppnMC7nI6acEN+EFGalem6DBmuAJd7J/sitCM3z+pPKYVQCFA9sYtetQa4niv2XtS14faXNSIJ4lAv0Uc0yk24EPojaM+Sl7pUk8/2+ZaPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 646B35813FC
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 13:21:48 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id B1B3D3EC3F
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 13:21:40 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ v3 2/6] shared/util: Add helper for "cleanup" variable attribute
Date: Mon, 11 May 2026 15:18:05 +0200
Message-ID: <20260511132131.1283892-3-hadess@hadess.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260511132131.1283892-1-hadess@hadess.net>
References: <20260511132131.1283892-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Cause: dmFkZTFWrjC4rbw2kUE4leMiEZylQ3RfD7xFrNoK0D1EDp1tpCkqHNRBYsbMxsr/VD+ImALuLtVXOCMLrsVhd0jYsBD69lMyPgClXpEjwLZEHmpyoG0ldNTnmvbv0VOhysSOzPgrJGC0q9mmEw0Xu3knMQgXLhUvrRyoBJWFKbYcPDxTaDKNG090z1CPeqwwUFJ2jT6qgH9bdhuOz4EOyyQJIfdA46ip6gIkT9HzZMg6h16wYW6sUfrYuUaKJZ5l3Wf5lOB0W0lp/RgH2buTwKm/fEFoqZgTd+aKV8mVTkTOS7iIEsZf3+/ScffbSzp6dBoDW4Idkl2/RFs6ezqU0iWO0RkmEHR6nE1e0ytbxOswGKQ8+xEwPu6WB93Qh5V6+XsI/o0PRnHZKHRGuYF/XfEyKO/GrfTJYytKnWsA6F5b71hsrrR8fm+fNs2PryGK9OV+KokRHZpSfp4Dv50nBraQhoLOhesPTCbEK4vXGMZt2/vrp9uS2t/4dKjFYjrQVAZZ4g8NJPpD32Yek/nftqNTNXFgJD0orMlvzxEzE+L68ut3Y9/1H4hYpqDvcuQ4cDlLzJf9WOK+GGNGctI0w1VTwUcoA9Bgh3/5+hasNadwZlg/xK2T2jy6F5KHBA4umOw9Ot0lVfEAlP77DhZAaTMRPdhSlNAN/N3I9Bt+D4riVdyHaA
X-GND-State: clean
X-GND-Score: 0

Use the widespread "cleanup" variable attribute:
https://gcc.gnu.org/onlinedocs/gcc/Common-Attributes.html#index-cleanup

It is implemented by both GCC and clang on platforms where bluez is
used, and can help reduce memory leaks, while improving readability.

This implements:
- generic cleanup (_cleanup_free_)
- cleanup with specific free function (_cleanup_())
- cleanup for specific types (_cleanup_type_(type))
- cleanup for file descriptors
- capturing a variable before it is freed (so it is only freed in error
  paths for example, _steal_() and _steal_fd())

This commit includes tests which should cover all those new helpers.

See also:
https://systemd.io/CODING_STYLE/#memory-allocation
https://docs.gtk.org/glib/auto-cleanup.html
---
 src/shared/util.h | 40 +++++++++++++++++++++++++++++
 unit/test-util.c  | 65 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 105 insertions(+)

diff --git a/src/shared/util.h b/src/shared/util.h
index 67629dddfaa9..c8ce90c5f1b5 100644
--- a/src/shared/util.h
+++ b/src/shared/util.h
@@ -15,9 +15,11 @@
 #include <stdbool.h>
 #include <alloca.h>
 #include <byteswap.h>
+#include <errno.h>
 #include <string.h>
 #include <sys/types.h>
 #include <sys/uio.h>
+#include <unistd.h>
 
 #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
 #define BIT(n)  (1 << (n))
@@ -93,6 +95,44 @@ do {						\
 #define newa(t, n) ((t*) alloca(sizeof(t)*(n)))
 #define malloc0(n) (calloc(1, (n)))
 
+static inline void freep(void *p)
+{
+	free(*(void **) p);
+}
+
+static inline void * _steal_(void *p)
+{
+	void **orig = (void **) p;
+	void *ret = *orig;
+	*orig = NULL;
+	return ret;
+}
+
+static inline int _steal_fd_(int *fdp)
+{
+	int fd = *fdp;
+	*fdp = -1;
+	return fd;
+}
+
+static inline void closefd(int *fdp)
+{
+	int errno_save = errno;
+	int fd = *fdp;
+	*fdp = -1;
+	if (fd < 0)
+		return;
+	close(fd);
+	errno = errno_save;
+}
+
+#define CLEANUP_FREEFUNC(type, func) static inline void cleanup_##type (type **_ptr) { (func) (*_ptr); }
+
+#define _cleanup_(f) __attribute__((cleanup(f)))
+#define _cleanup_type_(type) __attribute__((cleanup(cleanup_##type)))
+#define _cleanup_free_ _cleanup_(freep)
+#define _cleanup_fd_ _cleanup_(closefd)
+
 char *strdelimit(char *str, char *del, char c);
 int strsuffix(const char *str, const char *suffix);
 char *strstrip(char *str);
diff --git a/unit/test-util.c b/unit/test-util.c
index 443c4f70362c..1672b32eb39c 100644
--- a/unit/test-util.c
+++ b/unit/test-util.c
@@ -9,14 +9,73 @@
  */
 
 #include <assert.h>
+#include <sys/stat.h>
+#include <fcntl.h>
 
 #include "src/shared/util.h"
 #include "src/shared/tester.h"
+#include "bluetooth/bluetooth.h"
 
 /* XXX glib.h must not be included, or it will clobber the
  * MIN/MAX macros.
  */
 
+static void test_cleanup_free(const void *data)
+{
+	_cleanup_free_ char *p1 = NULL;
+	_cleanup_free_ char *p2 = NULL;
+	_cleanup_free_ char *is_null = NULL;
+
+	p1 = malloc0(10);
+	p2 = malloc0(15);
+
+	p1[0] = 1;
+	p2[0] = 1;
+
+	{
+		_cleanup_free_ uint8_t *data = NULL;
+		_cleanup_free_ uint8_t *is_null_too = NULL;
+
+		data = malloc0(128);
+		data[0] = 1;
+
+		assert(is_null_too == NULL);
+	}
+	{
+		_cleanup_free_ uint8_t *data = NULL;
+		data = malloc0(128 * 2);
+		data[0] = 3;
+	}
+
+	assert(is_null == NULL);
+	tester_test_passed();
+}
+
+CLEANUP_FREEFUNC(bdaddr_t, free);
+
+static void test_cleanup_type(const void *data)
+{
+#define ADDR "FF:FF:FF:FF:FF:FF"
+	_cleanup_type_(bdaddr_t) bdaddr_t *address = NULL;
+	char str[33];
+
+	address = strtoba(ADDR);
+	assert(bacmp(address, BDADDR_ALL) == 0);
+	printf("%d = ba2str(address, str)\n", ba2str(address, str));
+	assert(ba2str(address, str) == 17);
+	assert(strcmp(str, ADDR) == 0);
+	tester_test_passed();
+}
+
+static void test_cleanup_fd(const void *data)
+{
+	_cleanup_fd_ int fd = -1;
+
+	fd = open("/dev/null", O_RDONLY);
+	assert(fd != 0);
+	tester_test_passed();
+}
+
 static void test_min_max(const void *data)
 {
 	assert(MIN(3, 4) == 3);
@@ -30,6 +89,12 @@ int main(int argc, char *argv[])
 
 	tester_add("/util/min_max", NULL, NULL,
 			test_min_max, NULL);
+	tester_add("/util/cleanup_free", NULL, NULL,
+			test_cleanup_free, NULL);
+	tester_add("/util/cleanup_type", NULL, NULL,
+			test_cleanup_type, NULL);
+	tester_add("/util/cleanup_fd", NULL, NULL,
+			test_cleanup_fd, NULL);
 
 	return tester_run();
 }
-- 
2.54.0

