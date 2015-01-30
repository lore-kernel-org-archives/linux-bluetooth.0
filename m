Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, davem@davemloft.net,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH] sched/wait: Introduce wait_on_bit_timeout()
Date: Fri, 30 Jan 2015 13:14:36 +0200
Message-Id: <1422616476-2917-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1422616476-2917-1-git-send-email-johan.hedberg@gmail.com>
References: <1422616476-2917-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Add a new wait_on_bit_timeout() helper, basically the same as
wait_on_bit() except that it also takes a timeout parameter.
All the building blocks like bit_wait_timeout() and
out_of_line_wait_on_bit_timeout() are already in place so the addition
is rather simple.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
---
 include/linux/wait.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/linux/wait.h b/include/linux/wait.h
index 2232ed16635a..920de6df1210 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -991,6 +991,32 @@ wait_on_bit_io(void *word, int bit, unsigned mode)
 }
 
 /**
+ * wait_on_bit_timeout - wait for a bit to be cleared or a timeout elapses
+ * @word: the word being waited on, a kernel virtual address
+ * @bit: the bit of the word being waited on
+ * @mode: the task state to sleep in
+ * @timeout: timeout, in jiffies
+ *
+ * Use the standard hashed waitqueue table to wait for a bit
+ * to be cleared. This is similar to wait_on_bit(), except also takes a
+ * timeout parameter.
+ *
+ * Returned value will be zero if the bit was cleared before the
+ * @timeout elapsed, or non-zero if the @timeout elapsed or process
+ * received a signal and the mode permitted wakeup on that signal.
+ */
+static inline int
+wait_on_bit_timeout(void *word, int bit, unsigned mode, unsigned long timeout)
+{
+	might_sleep();
+	if (!test_bit(bit, word))
+		return 0;
+	return out_of_line_wait_on_bit_timeout(word, bit,
+					       bit_wait_timeout,
+					       mode, timeout);
+}
+
+/**
  * wait_on_bit_action - wait for a bit to be cleared
  * @word: the word being waited on, a kernel virtual address
  * @bit: the bit of the word being waited on
-- 
2.1.0

