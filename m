Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4CF39F162
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Sep 2026 18:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788978538; cv=none; b=K9IuPao/GgME+7Y6x3uPaVzdRdsThbQupglq8kI09y2wHn0e8y33lACoPPne5PvHDrBzEoUXN210VsgWq9Qny7sCJ/4XXOlNFna2fQdYQVKYgFDClLIekw1TJa84bb4+2EwdzEdIYV4T4Wgnyew4zWr288BGLPukFi3AX6ZWKFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788978538; c=relaxed/simple;
	bh=RXkQRPs8F54Rs+c4a8fR3RTVrgja/eiWWi+SnnZLCAM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LLKjDCJjTPaDDD14t1Sk/7bHNNAOxOWfUqy5lK9/VfkY6zdyl92KT7CbU2YZx9yXKyK8E+Rmh4O2BxJlJ5/v2rtsYTSajtR7lBISZBSmALJLiO9uPHL6V+veBYMfp5NMDBqLMNQtG2txVXFsjFVAO2VjezIFW2a9fCOXP712KRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zet0Zy76; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zet0Zy76"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-96723c7151eso1618215241.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Sep 2026 11:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788978535; x=1789583335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mNgI/Ie9u56xNj+qWOpegFxZULvYpcAjJPERMrrTdbg=;
        b=Zet0Zy76sDIgp306hiuL73wLxuL+kFVu/czYl85Puc5ELSV79saAFUyQAPFIEtttML
         V01QUnWhYD1Dh7sPvEKIWJ6KWypm5F+2fyiFAFlIUFr4G+FgfFZYtTR9nCFWnCJhL4ri
         VqWmGJkgfXUcK6HmeWIuvz9dwewdkWnP+TT1/5qiS5PwNfs2I7muFUCW4Cjtk+KxFhKW
         ouQ+6fkY837Uc8BEBiIYfbjiC+VlKTKIcNfL/8l5YIHQ7IUieYrV6vmNrB9o8ssTF/VW
         bjWt7L0Dl/tK+2viurCmTNXc+8i0+zpJRmBR8a5QPZYLU3MuMLIzF4NWppoqT/tHjPVf
         eLUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788978535; x=1789583335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=mNgI/Ie9u56xNj+qWOpegFxZULvYpcAjJPERMrrTdbg=;
        b=dp3fC+EZrD77xRqjnjfA0zia7aGBnuvLLBXfS9WkkmIyg3W+9H5s1uFmIDMBXrWOKd
         Jh1I6l5HQxIoTlBWv9zjHyFMjH/PGgk+vCtrAB7z+YNvIlBmnF6zvzShZ2Vww3idWZnH
         1L620aGklZXU4QpnZ8gQPbD/9m2AKbjNrBlOerfi5k/V7K3/tGsotImRLQA9ZLCXyt2T
         xf4SjgIfFV3IBCMvBESCUKgdJavA2nnj5gCOaqL2whzdcpXDOD4Lnrl3puHaNsvGBC3M
         sVnjdSKDW1mUY55A9LM7K1ph9tOF1cxOKdHxQzlL8CiwCQ1TRBnowKvlbmhRHmDgWt78
         T2Zw==
X-Gm-Message-State: AFuF++nxhbJSATJMt5XNAS2lr7ZscO0En+poXUagOl7pS544kRYbHEFY
	TxkC4cL8yucdksHLG2qdkKLVZJ118Vrl3kbootRDB4oabHpaGq/gAQVHxiXXjdlE
X-Gm-Gg: AYBFou26YmI7fQ+/pTnUGjJfr3lZOcTcwlOnBhUdkc6R+xh3Yb9tBrGQetzAlipOcez
	RW7q+cBKJnPe8Jv2BrR0Mz+Wvg9H/g5EdKzKjSJ1Clb0sT4FRxwDoM2QqTUf+JG+r+wjRbvZDw8
	5RSk+eGI49ZkjumQgx11sj44lxSI0RFz9BCUhJjklxP1ds8wIK9GernsSM9/OHv58siiIQoUgYE
	b7B+oKuhqhhNYx+kWYvvMk7/FdiCxQ4d6urBACpktjYQD9vdZ5PNRdMG7qa1pYMeVehU4t1uu0t
	LU81fSmRI4j6k4uk2gRgE50mIRbqS3Xw8btVDBlEjN5wA5lglRqExYO0Yp9YfEb+FdBccutwD5d
	+pVhkIJ/dCpnK7qn1hxZJUr6jkInPVx/fHEdTJwmTFrcucUkwG1+bW0bStX2XzoS2MeldTx6/rH
	quesZ+yTZtS0wlJwJ2EguVN/5VENuMu2eJ6w8nV4EVyJtvcSqZv9EVAz9wARY4qnzIygA2KsUxo
	voEv5vp0dVvJcJ7zvMBaD2chusQio6Lxn/9ZA4OG520ztJnRqbpaLtuPJk1o3vUif8=
X-Received: by 2002:a05:6122:5104:b0:5c8:2ad8:1484 with SMTP id 71dfb90a1353d-5c82ad81902mr3862270e0c.1.1788978535031;
        Wed, 09 Sep 2026 11:28:55 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c81c506f31sm5399388e0c.11.2026.09.09.11.28.54
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 11:28:54 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 05/10] monitor: Report command latency in analyze mode
Date: Wed,  9 Sep 2026 14:28:35 -0400
Message-ID: <20260909182840.1289776-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909182840.1289776-1-luiz.dentz@gmail.com>
References: <20260909182840.1289776-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

A trace shows every command and every response, but not how quickly the
controller answered, and a command that was never answered at all leaves
no trace beyond its absence.

Measure the interval between a command and the Command Complete or
Command Status that acknowledges it, and report it per controller along
with the number of commands still unanswered at the end of the trace:

  Command latency: 0-215 msec (~55 msec +/- 70 msec)
  Commands without response: 3

Commands that are only acknowledged by a Command Status and complete much
later through a separate event are measured up to the acknowledgement
only. A Create Connection waiting three seconds for its Connect Complete
is waiting on the remote device, not on the controller, and folding that
in would swamp both the average and the deviation and leave the figure
describing how many connections the trace happened to contain.

Commands are matched on the opcode, oldest first, since several may be
outstanding at once and they need not complete in order. The queue is
bounded so commands that never get a response cannot pile up.

The model wrote the tracking, which the author reviewed and verified
against a trace with a known latency spread and known unanswered
commands.

Assisted-by: opencode:claude-opus-5
---
 monitor/analyze.c | 99 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/monitor/analyze.c b/monitor/analyze.c
index 9742981ec21a..59c7e91b8758 100644
--- a/monitor/analyze.c
+++ b/monitor/analyze.c
@@ -57,8 +57,20 @@ struct hci_dev {
 	unsigned long unknown;
 	uint16_t manufacturer;
 	struct queue *conn_list;
+	struct queue *cmd_list;
+	struct packet_latency cmd_latency;
+	unsigned long num_cmd_rsp;
 };
 
+/* Command awaiting a Command Complete or a Command Status */
+struct hci_cmd {
+	uint16_t opcode;
+	struct timeval tv;
+};
+
+/* Bound the queue so commands that never get a response cannot pile up */
+#define CMD_LIST_MAX 64
+
 struct hci_stats {
 	size_t bytes;
 	size_t num;
@@ -488,6 +500,21 @@ static void dev_destroy(void *data)
 	printf("  %lu user logs\n", dev->user_log);
 	printf("  %lu control messages \n", dev->ctrl_msg);
 	printf("  %lu unknown opcodes\n", dev->unknown);
+
+	if (dev->num_cmd_rsp)
+		printf("  Command latency: %lld-%lld msec "
+				"(~%lld msec +/- %lld msec)\n",
+				TV_MSEC(dev->cmd_latency.min),
+				TV_MSEC(dev->cmd_latency.max),
+				TV_MSEC(dev->cmd_latency.med),
+				packet_latency_stddev(&dev->cmd_latency));
+
+	/* Whatever is left never got a Command Complete or Command Status */
+	if (!queue_isempty(dev->cmd_list))
+		printf("  Commands without response: %u\n",
+					queue_length(dev->cmd_list));
+
+	queue_destroy(dev->cmd_list, free);
 	queue_destroy(dev->conn_list, conn_destroy);
 	printf("\n");
 
@@ -504,6 +531,7 @@ static struct hci_dev *dev_alloc(uint16_t index)
 	dev->manufacturer = 0xffff;
 
 	dev->conn_list = queue_new();
+	dev->cmd_list = queue_new();
 
 	return dev;
 }
@@ -739,10 +767,20 @@ static void del_index(struct timeval *tv, uint16_t index,
 	dev_destroy(dev);
 }
 
+static bool match_cmd_opcode(const void *data, const void *user_data)
+{
+	const struct hci_cmd *cmd = data;
+
+	return cmd->opcode == PTR_TO_UINT(user_data);
+}
+
 static void command_pkt(struct timeval *tv, uint16_t index,
 					const void *data, uint16_t size)
 {
+	const struct bt_hci_cmd_hdr *hdr = data;
 	struct hci_dev *dev;
+	struct hci_cmd *cmd;
+	uint16_t opcode;
 
 	dev = dev_lookup(index);
 	if (!dev)
@@ -750,6 +788,51 @@ static void command_pkt(struct timeval *tv, uint16_t index,
 
 	dev->num_hci++;
 	dev->num_cmd++;
+
+	if (size < sizeof(*hdr))
+		return;
+
+	opcode = le16_to_cpu(hdr->opcode);
+
+	/* NOP carries no request and is only used to update ncmd */
+	if (opcode == BT_HCI_CMD_NOP)
+		return;
+
+	if (queue_length(dev->cmd_list) >= CMD_LIST_MAX)
+		free(queue_pop_head(dev->cmd_list));
+
+	cmd = new0(struct hci_cmd, 1);
+	cmd->opcode = opcode;
+	cmd->tv = *tv;
+
+	queue_push_tail(dev->cmd_list, cmd);
+}
+
+/*
+ * Measure how long the controller took to acknowledge a command. Commands
+ * that are only acknowledged here and complete later through a separate
+ * event are still measured up to the acknowledgement, so that the figure
+ * stays a property of the controller rather than of the remote device.
+ */
+static void cmd_rsp(struct hci_dev *dev, struct timeval *tv, uint16_t opcode)
+{
+	struct hci_cmd *cmd;
+	struct timeval res;
+
+	/*
+	 * Several commands may be outstanding at once and they need not
+	 * complete in order, so match on the opcode and take the oldest.
+	 */
+	cmd = queue_remove_if(dev->cmd_list, match_cmd_opcode,
+							UINT_TO_PTR(opcode));
+	if (!cmd)
+		return;
+
+	timersub(tv, &cmd->tv, &res);
+	packet_latency_add(&dev->cmd_latency, &res);
+	dev->num_cmd_rsp++;
+
+	free(cmd);
 }
 
 static void evt_conn_complete(struct hci_dev *dev, struct timeval *tv,
@@ -812,6 +895,8 @@ static void evt_cmd_complete(struct hci_dev *dev, struct timeval *tv,
 
 	opcode = le16_to_cpu(evt->opcode);
 
+	cmd_rsp(dev, tv, opcode);
+
 	switch (opcode) {
 	case BT_HCI_CMD_READ_BD_ADDR:
 		rsp_read_bd_addr(dev, tv, data, size);
@@ -819,6 +904,17 @@ static void evt_cmd_complete(struct hci_dev *dev, struct timeval *tv,
 	}
 }
 
+static void evt_cmd_status(struct hci_dev *dev, struct timeval *tv,
+					const void *data, uint16_t size)
+{
+	const struct bt_hci_evt_cmd_status *evt = data;
+
+	if (size < sizeof(*evt))
+		return;
+
+	cmd_rsp(dev, tv, le16_to_cpu(evt->opcode));
+}
+
 static bool match_plot_latency(const void *data, const void *user_data)
 {
 	const struct plot *plot = data;
@@ -1114,6 +1210,9 @@ static void event_pkt(struct timeval *tv, uint16_t index,
 	case BT_HCI_EVT_CMD_COMPLETE:
 		evt_cmd_complete(dev, tv, data, size);
 		break;
+	case BT_HCI_EVT_CMD_STATUS:
+		evt_cmd_status(dev, tv, data, size);
+		break;
 	case BT_HCI_EVT_NUM_COMPLETED_PACKETS:
 		evt_num_completed_packets(dev, tv, data, size);
 		break;
-- 
2.55.0

