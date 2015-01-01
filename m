Return-Path: <cyrus@holtmann.org>
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH bluez] src/shared/ecc.c: include <config.h>
Date: Thu,  1 Jan 2015 22:38:26 +0100
Message-Id: <1420148306-18471-1-git-send-email-thomas.petazzoni@free-electrons.com>
List-ID: <linux-bluetooth.vger.kernel.org>

The ecc.c file forgets to include <config.h>. This causes build
failures with certain C libraries, because ecc.c uses O_CLOEXEC, which
is only available when _GNU_SOURCE is defined. And _GNU_SOURCE gets
defined by <config.h>, so it should be included.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 src/shared/ecc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/shared/ecc.c b/src/shared/ecc.c
index 33c4187..41be02b 100644
--- a/src/shared/ecc.c
+++ b/src/shared/ecc.c
@@ -24,6 +24,10 @@
  * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
 #include <fcntl.h>
 #include <unistd.h>
 #include <sys/types.h>
-- 
2.1.0
