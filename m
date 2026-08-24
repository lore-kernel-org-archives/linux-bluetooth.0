Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9DC377016
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Aug 2026 16:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787590042; cv=none; b=XJv3QwRIYSqzzlJte1ocq7ZctxWaSByHKkFYss0xnv724vZU0S5cJe9vSl6om2Wi2JKnaqNMFcXUWk+L1aaMMGWnUPyoRXvNOCqR5kjxGIpd7FupDp80ufUpQVJFRhgExhKJJKn+pS/D/EWEnQlsgfCecmBzd2la/YW47Vy3AuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787590042; c=relaxed/simple;
	bh=EldBGaQCctKlNw6i8Oo76gSRX7UnhycDMQTrPaiIjXs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=V+vVFRkhjUJvz1fnU1Z8m/P/VSfMPfl5GfCWcd/iBOFub/XUWTuBcSemrYLaxeeB6/0k2qEXRgI+bj5AsTj886MFTNdJYxPFboMaz50OasrxaKCqTGOIVB6s/bRxz3/1FYB3+2JnhMNvJxVu8gc4eeXZdKUhAvgM0QPKRVh5wR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wn7U0TzB; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wn7U0TzB"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-90a6b298889so30105646d6.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Aug 2026 09:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787590038; x=1788194838; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0YD4NMaorCnC2TkkNJBeOQG08XBFXGSqMhvUS+xArb4=;
        b=Wn7U0TzBDZlctrWFQqVnwvRvtAflTDYLAjBLbwcR+swrOdv1Yrn1R/IY46s3g299Yz
         agOXkc/glfvebFqqgDvst0R41XsclgwWG6Ontc5nndqLHyJ/bETxYFJMcSVtdPgsd/Ag
         QwDn9guXvxlaBdNL3vbntHGseao9Aav+HcRoCYrTZiG8V5pNRrEpCs2xB2EHeDxpExmt
         tENFqdjkchkMVFQu+DbZh3pZ1BdTsiu+/RPmfwNec/J5pxJajUisqPO2n0HrdFF1kE67
         hz3C2sxLcdbO4FIg4fy1CUfhDd26b6jPUfAit/Fbv5QK3lkOtiNYXMy2jO9BgEvrljH9
         a8yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787590038; x=1788194838;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0YD4NMaorCnC2TkkNJBeOQG08XBFXGSqMhvUS+xArb4=;
        b=rPTMHhySFuNDemLkh2+6OFnHDPgEyAKKSsOkHO/cFwMOrgdZiMQVu782I/71bxlKYF
         6UUbxLtJd4zamQaHyBqmAdjfqLlFsxIisApCgvNAj8yTROQ6W3rYtj4fjOeYaos9v29G
         2JluvytS/t1lTpwgFVmyFOvTOc94XIyLA8e8YOE/gDEL2Jugk8Zf+LPyK4xnQ0TjC8xQ
         Jq1LnqGTC8jkAFJxno2lN5DFLEEKxdGYutxNUTKaL97Rioka4EaebFQPFQzsrwh2QSnY
         ThucOtocYV6VDj0JU4fGsMJ6HRXTKBg3Dyy1PYrPKVM54k3moJRE30rDqI8FKeXfD5eZ
         BjVA==
X-Gm-Message-State: AFuF++lK4HviP5pNNy3xNtK7a+stEEhk5OVpJA347whj2F+U1DSDT9Ze
	7+FhpnsyLsrRT4fKV2lEnn0DC9EtX99uf9xnuO2Pu2wI9nG83rciq5i5HztThA==
X-Gm-Gg: AR+sD10Fv0PEM821XvWJSPixgtbp8HF4c0oIscnD0BbE/s19lFuzHjYnnKUNR5xL0g2
	QOndE3zuD2WaWo+kHFYxmLTb8/zVlu18pTLioN8ddjigr3mU9xjfpj0usWXE8GsOlhogtKn0ebN
	1IHfqRjChHyb+V5KxeGKOs2/FqvMVOnvRpOFAsT3a6SkQnpSU+gkqtYDEWeeP+cLAhfNaPPw6O8
	k2V68cvKtgZu5JzawSdYIIH32dKvGt8HoTpi6NX5dKUid43j/+n2/keyeKvxk27E5zr+soSJyRd
	47ijsoCugd8JAWiXTQ/NmHAa7mmGDEJdSZ5i8MsE1CNDV9T0JzFFAu5ZmiOdwEO9KaR1zA8+Gga
	3OM/ta96uFO6OHLnKm74ACKIxkZUgY6sj0/bcDtyr8Usf4dUyHUkimaBOB5FqI9AmGCmH1oKk+F
	0SllgHLP8i1/6/IyWC4S6+4410ERI0zJeHXgVSoWF+1wYilOM3a1quRRsUR48PwalGagE8s0gXQ
	Ipe
X-Received: by 2002:a05:620a:4016:b0:92e:e2fc:26d3 with SMTP id af79cd13be357-937469dfb10mr1679106785a.46.1787590037640;
        Mon, 24 Aug 2026 09:47:17 -0700 (PDT)
Received: from [172.17.0.2] ([9.234.151.21])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93749e9f94bsm532526985a.37.2026.08.24.09.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 09:47:17 -0700 (PDT)
Message-ID: <6a8c7595.858065bc.53bb8.0676@mx.google.com>
Date: Mon, 24 Aug 2026 09:47:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5277730770308473621=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, jjy600901@snu.ac.kr
Subject: RE: [BUG] general protection fault in __l2cap_chan_add
In-Reply-To: <20260824153908.2327306-1-jjy600901@snu.ac.kr>
References: <20260824153908.2327306-1-jjy600901@snu.ac.kr>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5277730770308473621==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1151028

---Test result---

Test Summary:
CheckPatch                    FAIL      1.08 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       FAIL      0.41 seconds
SubjectPrefix                 FAIL      0.12 seconds
BuildKernel                   PASS      26.80 seconds
CheckAllWarning               PASS      29.53 seconds
CheckSparse                   PASS      27.88 seconds
BuildKernel32                 PASS      25.82 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      471.45 seconds
TestRunner_l2cap-tester       PASS      68.40 seconds
IncrementalBuild              PASS      24.72 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BUG] general protection fault in __l2cap_chan_add
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#101: 
The issue was found by our own race fuzzer. We have not analyzed the root cause,

WARNING: Reported-by: should be immediately followed by Closes: or Link: with a URL to the report
#118: 
Reported-by: Eulgyu Kim <eulgyukim@snu.ac.kr>
Reported-by: Jaeyoung Chung <jjy600901@snu.ac.kr>

WARNING: Reported-by: should be immediately followed by Closes: or Link: with a URL to the report
#119: 
Reported-by: Jaeyoung Chung <jjy600901@snu.ac.kr>


WARNING: Commit log lines starting with '#' are dropped by git as comments
#128: 
#define _GNU_SOURCE

WARNING: Commit log lines starting with '#' are dropped by git as comments
#130: 
#include <errno.h>

WARNING: Commit log lines starting with '#' are dropped by git as comments
#131: 
#include <fcntl.h>

WARNING: Commit log lines starting with '#' are dropped by git as comments
#132: 
#include <pthread.h>

WARNING: Commit log lines starting with '#' are dropped by git as comments
#133: 
#include <stdint.h>

WARNING: Commit log lines starting with '#' are dropped by git as comments
#134: 
#include <stdio.h>

WARNING: Commit log lines starting with '#' are dropped by git as comments
#135: 
#include <stdlib.h>

WARNING: Commit log lines starting with '#' are dropped by git as comments
#136: 
#include <string.h>

WARNING: Commit log lines starting with '#' are dropped by git as comments
#137: 
#include <sys/ioctl.h>

WARNING: Commit log lines starting with '#' are dropped by git as comments
#138: 
#include <sys/prctl.h>

WARNING: Commit log lines starting with '#' are dropped by git as comments
#139: 
#include <sys/socket.h>

WARNING: Commit log lines starting with '#' are dropped by git as comments
#140: 
#include <sys/uio.h>

WARNING: Commit log lines starting with '#' are dropped by git as comments
#141: 
#include <unistd.h>

WARNING: Commit log lines starting with '#' are dropped by git as comments
#143: 
#ifndef AF_BLUETOOTH

WARNING: Commit log lines starting with '#' are dropped by git as comments
#144: 
#define AF_BLUETOOTH 31

WARNING: Commit log lines starting with '#' are dropped by git as comments
#145: 
#endif

WARNING: Commit log lines starting with '#' are dropped by git as comments
#146: 
#define BTPROTO_L2CAP 0

WARNING: Commit log lines starting with '#' are dropped by git as comments
#147: 
#define BTPROTO_HCI 1

WARNING: Commit log lines starting with '#' are dropped by git as comments
#149: 
#define HCI_COMMAND_PKT 0x01

WARNING: Commit log lines starting with '#' are dropped by git as comments
#150: 
#define HCI_EVENT_PKT 0x04

WARNING: Commit log lines starting with '#' are dropped by git as comments
#151: 
#define HCI_VENDOR_PKT 0xff

WARNING: Commit log lines starting with '#' are dropped by git as comments
#153: 
#define HCI_EV_CONN_COMPLETE 0x03

WARNING: Commit log lines starting with '#' are dropped by git as comments
#154: 
#define HCI_EV_CONN_REQUEST 0x04

WARNING: Commit log lines starting with '#' are dropped by git as comments
#155: 
#define HCI_EV_REMOTE_FEATURES 0x0b

WARNING: Commit log lines starting with '#' are dropped by git as comments
#156: 
#define HCI_EV_CMD_COMPLETE 0x0e

WARNING: Commit log lines starting with '#' are dropped by git as comments
#158: 
#define HCI_OP_RESET 0x0c03

WARNING: Commit log lines starting with '#' are dropped by git as comments
#159: 
#define HCI_OP_WRITE_SCAN_ENABLE 0x0c1a

WARNING: Commit log lines starting with '#' are dropped by git as comments
#160: 
#define HCI_OP_READ_BUFFER_SIZE 0x1005

WARNING: Commit log lines starting with '#' are dropped by git as comments
#161: 
#define HCI_OP_READ_BD_ADDR 0x1009

WARNING: Commit log lines starting with '#' are dropped by git as comments
#163: 
#define ACL_LINK 0x01

WARNING: Commit log lines starting with '#' are dropped by git as comments
#164: 
#define SCAN_PAGE 0x02

WARNING: Commit log lines starting with '#' are dropped by git as comments
#165: 
#define HCI_PRIMARY 0

WARNING: Commit log lines starting with '#' are dropped by git as comments
#166: 
#define HCI_HANDLE_1 200

WARNING: Commit log lines starting with '#' are dropped by git as comments
#168: 
#define HCIDEVUP _IOW('H', 201, int)

WARNING: Commit log lines starting with '#' are dropped by git as comments
#169: 
#define HCISETSCAN _IOW('H', 221, int)

WARNING: Commit log lines starting with '#' are dropped by git as comments
#249: 
#define RFKILL_TYPE_ALL 0

WARNING: Commit log lines starting with '#' are dropped by git as comments
#250: 
#define RFKILL_OP_CHANGE_ALL 3

WARNING: Commit log lines starting with '#' are dropped by git as comments
#256: 
#define LOG(fmt, ...)                                                          \

WARNING: Commit log lines starting with '#' are dropped by git as comments
#261: 
#define LOGE(fmt, ...)                                                         \

ERROR: Invalid commit separator - some tools may have problems applying this
#665: 
---[ end trace 0000000000000000 ]---

ERROR: Invalid commit separator - some tools may have problems applying this
#679: 
----------------

WARNING: The commit message has 'Call Trace:', perhaps it also needs a 'Fixes:' tag?

ERROR: Missing Signed-off-by: line(s)

total: 3 errors, 43 warnings, 0 checks, 52 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14765786.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BUG] general protection fault in __l2cap_chan_add

1: CC1 Body does not contain a 'Signed-off-by' line
42: B3 Line contains hard tab characters (\t): "	uint8_t b[6];"
46: B3 Line contains hard tab characters (\t): "	uint16_t l2_family;"
47: B3 Line contains hard tab characters (\t): "	uint16_t l2_psm;"
48: B3 Line contains hard tab characters (\t): "	my_bdaddr_t l2_bdaddr;"
49: B3 Line contains hard tab characters (\t): "	uint16_t l2_cid;"
50: B3 Line contains hard tab characters (\t): "	uint8_t l2_bdaddr_type;"
54: B3 Line contains hard tab characters (\t): "	uint16_t opcode;"
55: B3 Line contains hard tab characters (\t): "	uint8_t plen;"
59: B3 Line contains hard tab characters (\t): "	uint8_t evt;"
60: B3 Line contains hard tab characters (\t): "	uint8_t plen;"
64: B3 Line contains hard tab characters (\t): "	uint8_t ncmd;"
65: B3 Line contains hard tab characters (\t): "	uint16_t opcode;"
69: B3 Line contains hard tab characters (\t): "	my_bdaddr_t bdaddr;"
70: B3 Line contains hard tab characters (\t): "	uint8_t dev_class[3];"
71: B3 Line contains hard tab characters (\t): "	uint8_t link_type;"
75: B3 Line contains hard tab characters (\t): "	uint8_t status;"
76: B3 Line contains hard tab characters (\t): "	uint16_t handle;"
77: B3 Line contains hard tab characters (\t): "	my_bdaddr_t bdaddr;"
78: B3 Line contains hard tab characters (\t): "	uint8_t link_type;"
79: B3 Line contains hard tab characters (\t): "	uint8_t encr_mode;"
83: B3 Line contains hard tab characters (\t): "	uint8_t status;"
84: B3 Line contains hard tab characters (\t): "	uint16_t handle;"
85: B3 Line contains hard tab characters (\t): "	uint8_t features[8];"
89: B3 Line contains hard tab characters (\t): "	uint8_t status;"
90: B3 Line contains hard tab characters (\t): "	my_bdaddr_t bdaddr;"
94: B3 Line contains hard tab characters (\t): "	uint8_t status;"
95: B3 Line contains hard tab characters (\t): "	uint16_t acl_mtu;"
96: B3 Line contains hard tab characters (\t): "	uint8_t sco_mtu;"
97: B3 Line contains hard tab characters (\t): "	uint16_t acl_max_pkt;"
98: B3 Line contains hard tab characters (\t): "	uint16_t sco_max_pkt;"
102: B3 Line contains hard tab characters (\t): "	uint16_t dev_id;"
103: B3 Line contains hard tab characters (\t): "	uint32_t dev_opt;"
107: B3 Line contains hard tab characters (\t): "	uint8_t type;"
108: B3 Line contains hard tab characters (\t): "	uint8_t opcode;"
112: B3 Line contains hard tab characters (\t): "	uint32_t idx;"
113: B3 Line contains hard tab characters (\t): "	uint8_t type;"
114: B3 Line contains hard tab characters (\t): "	uint8_t op;"
115: B3 Line contains hard tab characters (\t): "	uint8_t soft;"
116: B3 Line contains hard tab characters (\t): "	uint8_t hard;"
124: B3 Line contains hard tab characters (\t): "	do {                                                                   \"
125: B3 Line contains hard tab characters (\t): "		fflush(stdout);                                                \"
126: B3 Line contains hard tab characters (\t): "	} while (0)"
128: B3 Line contains hard tab characters (\t): "	do {                                                                   \"
129: B3 Line contains hard tab characters (\t): "		fflush(stdout);                                                \"
130: B3 Line contains hard tab characters (\t): "	} while (0)"
133: B3 Line contains hard tab characters (\t): "				  size_t data_len)"
135: B3 Line contains hard tab characters (\t): "	struct iovec iv[3];"
136: B3 Line contains hard tab characters (\t): "	struct hci_event_hdr hdr;"
137: B3 Line contains hard tab characters (\t): "	uint8_t type = HCI_EVENT_PKT;"
139: B3 Line contains hard tab characters (\t): "	hdr.evt = evt;"
140: B3 Line contains hard tab characters (\t): "	hdr.plen = data_len;"
142: B3 Line contains hard tab characters (\t): "	iv[0].iov_base = &type;"
143: B3 Line contains hard tab characters (\t): "	iv[0].iov_len = sizeof(type);"
144: B3 Line contains hard tab characters (\t): "	iv[1].iov_base = &hdr;"
145: B3 Line contains hard tab characters (\t): "	iv[1].iov_len = sizeof(hdr);"
146: B3 Line contains hard tab characters (\t): "	iv[2].iov_base = data;"
147: B3 Line contains hard tab characters (\t): "	iv[2].iov_len = data_len;"
149: B3 Line contains hard tab characters (\t): "	if (writev(fd, iv, 3) < 0)"
150: B3 Line contains hard tab characters (\t): "		LOGE("writev(event) failed");"
154: B3 Line contains hard tab characters (\t): "					size_t data_len)"
156: B3 Line contains hard tab characters (\t): "	struct iovec iv[4];"
157: B3 Line contains hard tab characters (\t): "	struct hci_event_hdr hdr;"
158: B3 Line contains hard tab characters (\t): "	struct hci_ev_cmd_complete evt_hdr;"
159: B3 Line contains hard tab characters (\t): "	uint8_t type = HCI_EVENT_PKT;"
161: B3 Line contains hard tab characters (\t): "	hdr.evt = HCI_EV_CMD_COMPLETE;"
162: B3 Line contains hard tab characters (\t): "	hdr.plen = sizeof(struct hci_ev_cmd_complete) + data_len;"
163: B3 Line contains hard tab characters (\t): "	evt_hdr.ncmd = 1;"
164: B3 Line contains hard tab characters (\t): "	evt_hdr.opcode = opcode;"
166: B3 Line contains hard tab characters (\t): "	iv[0].iov_base = &type;"
167: B3 Line contains hard tab characters (\t): "	iv[0].iov_len = sizeof(type);"
168: B3 Line contains hard tab characters (\t): "	iv[1].iov_base = &hdr;"
169: B3 Line contains hard tab characters (\t): "	iv[1].iov_len = sizeof(hdr);"
170: B3 Line contains hard tab characters (\t): "	iv[2].iov_base = &evt_hdr;"
171: B3 Line contains hard tab characters (\t): "	iv[2].iov_len = sizeof(evt_hdr);"
172: B3 Line contains hard tab characters (\t): "	iv[3].iov_base = data;"
173: B3 Line contains hard tab characters (\t): "	iv[3].iov_len = data_len;"
175: B3 Line contains hard tab characters (\t): "	if (writev(fd, iv, 4) < 0)"
176: B3 Line contains hard tab characters (\t): "		LOGE("writev(cmd_complete) failed");"
181: B3 Line contains hard tab characters (\t): "	struct hci_command_hdr *hdr = (struct hci_command_hdr *)buf;"
183: B3 Line contains hard tab characters (\t): "	if (buf_size < (ssize_t)sizeof(struct hci_command_hdr))"
184: B3 Line contains hard tab characters (\t): "		return;"
186: B3 Line contains hard tab characters (\t): "	switch (hdr->opcode) {"
187: B3 Line contains hard tab characters (\t): "	case HCI_OP_READ_BD_ADDR: {"
188: B3 Line contains hard tab characters (\t): "		struct hci_rp_read_bd_addr rp;"
189: B3 Line contains hard tab characters (\t): "		memset(&rp, 0, sizeof(rp));"
190: B3 Line contains hard tab characters (\t): "		rp.status = 0;"
191: B3 Line contains hard tab characters (\t): "		memset(&rp.bdaddr, 0xaa, 6);"
192: B3 Line contains hard tab characters (\t): "		hci_send_event_cmd_complete(fd, hdr->opcode, &rp, sizeof(rp));"
193: B3 Line contains hard tab characters (\t): "		return;"
194: B3 Line contains hard tab characters (\t): "	}"
195: B3 Line contains hard tab characters (\t): "	case HCI_OP_READ_BUFFER_SIZE: {"
196: B3 Line contains hard tab characters (\t): "		struct hci_rp_read_buffer_size rp;"
197: B3 Line contains hard tab characters (\t): "		memset(&rp, 0, sizeof(rp));"
198: B3 Line contains hard tab characters (\t): "		rp.status = 0;"
199: B3 Line contains hard tab characters (\t): "		rp.acl_mtu = 1021;"
200: B3 Line contains hard tab characters (\t): "		rp.sco_mtu = 96;"
201: B3 Line contains hard tab characters (\t): "		rp.acl_max_pkt = 4;"
202: B3 Line contains hard tab characters (\t): "		rp.sco_max_pkt = 6;"
203: B3 Line contains hard tab characters (\t): "		hci_send_event_cmd_complete(fd, hdr->opcode, &rp, sizeof(rp));"
204: B3 Line contains hard tab characters (\t): "		return;"
205: B3 Line contains hard tab characters (\t): "	}"
206: B3 Line contains hard tab characters (\t): "	case HCI_OP_WRITE_SCAN_ENABLE: {"
207: B3 Line contains hard tab characters (\t): "		uint8_t status = 0;"
208: B3 Line contains hard tab characters (\t): "		hci_send_event_cmd_complete(fd, hdr->opcode, &status,"
209: B3 Line contains hard tab characters (\t): "					    sizeof(status));"
210: B3 Line contains hard tab characters (\t): "		return;"
211: B3 Line contains hard tab characters (\t): "	}"
212: B3 Line contains hard tab characters (\t): "	}"
214: B3 Line contains hard tab characters (\t): "	{"
215: B3 Line contains hard tab characters (\t): "		char dummy[0xf9];"
216: B3 Line contains hard tab characters (\t): "		memset(dummy, 0, sizeof(dummy));"
217: B3 Line contains hard tab characters (\t): "		hci_send_event_cmd_complete(fd, hdr->opcode, dummy,"
218: B3 Line contains hard tab characters (\t): "					    sizeof(dummy));"
219: B3 Line contains hard tab characters (\t): "	}"
224: B3 Line contains hard tab characters (\t): "	(void)arg;"
225: B3 Line contains hard tab characters (\t): "	prctl(PR_SET_NAME, "syzhci", 0, 0, 0);"
226: B3 Line contains hard tab characters (\t): "	for (;;) {"
227: B3 Line contains hard tab characters (\t): "		char buf[1024];"
228: B3 Line contains hard tab characters (\t): "		ssize_t n;"
230: B3 Line contains hard tab characters (\t): "		memset(buf, 0, sizeof(buf));"
231: B3 Line contains hard tab characters (\t): "		n = read(vhci_fd, buf, sizeof(buf));"
232: B3 Line contains hard tab characters (\t): "		if (n < 0) {"
233: B3 Line contains hard tab characters (\t): "			if (errno == EINTR)"
234: B3 Line contains hard tab characters (\t): "				continue;"
235: B3 Line contains hard tab characters (\t): "			return NULL;"
236: B3 Line contains hard tab characters (\t): "		}"
237: B3 Line contains hard tab characters (\t): "		if (n > 0 && (uint8_t)buf[0] == HCI_COMMAND_PKT)"
238: B3 Line contains hard tab characters (\t): "			process_command_pkt(vhci_fd, buf + 1, n - 1);"
239: B3 Line contains hard tab characters (\t): "	}"
240: B3 Line contains hard tab characters (\t): "	return NULL;"
245: B3 Line contains hard tab characters (\t): "	struct my_rfkill_event ev;"
246: B3 Line contains hard tab characters (\t): "	int fd = open("/dev/rfkill", O_WRONLY);"
248: B3 Line contains hard tab characters (\t): "	if (fd < 0) {"
249: B3 Line contains hard tab characters (\t): "		return;"
250: B3 Line contains hard tab characters (\t): "	}"
251: B3 Line contains hard tab characters (\t): "	memset(&ev, 0, sizeof(ev));"
252: B3 Line contains hard tab characters (\t): "	ev.idx = 0;"
253: B3 Line contains hard tab characters (\t): "	ev.type = RFKILL_TYPE_ALL;"
254: B3 Line contains hard tab characters (\t): "	ev.op = RFKILL_OP_CHANGE_ALL;"
255: B3 Line contains hard tab characters (\t): "	if (write(fd, &ev, sizeof(ev)) < 0)"
256: B3 Line contains hard tab characters (\t): "		LOGE("write rfkill failed");"
257: B3 Line contains hard tab characters (\t): "	close(fd);"
262: B3 Line contains hard tab characters (\t): "	struct hci_ev_conn_request request;"
263: B3 Line contains hard tab characters (\t): "	struct hci_ev_conn_complete complete;"
264: B3 Line contains hard tab characters (\t): "	struct hci_ev_remote_features features;"
266: B3 Line contains hard tab characters (\t): "	memset(&request, 0, sizeof(request));"
267: B3 Line contains hard tab characters (\t): "	memset(&request.bdaddr, 0xaa, 6);"
268: B3 Line contains hard tab characters (\t): "	request.bdaddr.b[5] = 0x10;"
269: B3 Line contains hard tab characters (\t): "	request.link_type = ACL_LINK;"
270: B3 Line contains hard tab characters (\t): "	hci_send_event_packet(vhci_fd, HCI_EV_CONN_REQUEST, &request,"
271: B3 Line contains hard tab characters (\t): "			      sizeof(request));"
273: B3 Line contains hard tab characters (\t): "	memset(&complete, 0, sizeof(complete));"
274: B3 Line contains hard tab characters (\t): "	complete.status = 0;"
275: B3 Line contains hard tab characters (\t): "	complete.handle = HCI_HANDLE_1;"
276: B3 Line contains hard tab characters (\t): "	memset(&complete.bdaddr, 0xaa, 6);"
277: B3 Line contains hard tab characters (\t): "	complete.bdaddr.b[5] = 0x10;"
278: B3 Line contains hard tab characters (\t): "	complete.link_type = ACL_LINK;"
279: B3 Line contains hard tab characters (\t): "	complete.encr_mode = 0;"
280: B3 Line contains hard tab characters (\t): "	hci_send_event_packet(vhci_fd, HCI_EV_CONN_COMPLETE, &complete,"
281: B3 Line contains hard tab characters (\t): "			      sizeof(complete));"
283: B3 Line contains hard tab characters (\t): "	memset(&features, 0, sizeof(features));"
284: B3 Line contains hard tab characters (\t): "	features.status = 0;"
285: B3 Line contains hard tab characters (\t): "	features.handle = HCI_HANDLE_1;"
286: B3 Line contains hard tab characters (\t): "	hci_send_event_packet(vhci_fd, HCI_EV_REMOTE_FEATURES, &features,"
287: B3 Line contains hard tab characters (\t): "			      sizeof(features));"
292: B3 Line contains hard tab characters (\t): "	struct vhci_vendor_pkt_request vendor_pkt_req;"
293: B3 Line contains hard tab characters (\t): "	struct hci_dev_req dr;"
294: B3 Line contains hard tab characters (\t): "	pthread_t th;"
295: B3 Line contains hard tab characters (\t): "	char buf[1024];"
296: B3 Line contains hard tab characters (\t): "	ssize_t n;"
297: B3 Line contains hard tab characters (\t): "	int ret, tries;"
299: B3 Line contains hard tab characters (\t): "	hci_sock = socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI);"
300: B3 Line contains hard tab characters (\t): "	if (hci_sock < 0) {"
301: B3 Line contains hard tab characters (\t): "		return -1;"
302: B3 Line contains hard tab characters (\t): "	}"
304: B3 Line contains hard tab characters (\t): "	vhci_fd = open("/dev/vhci", O_RDWR);"
305: B3 Line contains hard tab characters (\t): "	if (vhci_fd < 0) {"
306: B3 Line contains hard tab characters (\t): "		return -1;"
307: B3 Line contains hard tab characters (\t): "	}"
309: B3 Line contains hard tab characters (\t): "	vendor_pkt_req.type = HCI_VENDOR_PKT;"
310: B3 Line contains hard tab characters (\t): "	vendor_pkt_req.opcode = HCI_PRIMARY;"
311: B3 Line contains hard tab characters (\t): "	if (write(vhci_fd, &vendor_pkt_req, sizeof(vendor_pkt_req)) !="
312: B3 Line contains hard tab characters (\t): "	    (ssize_t)sizeof(vendor_pkt_req)) {"
313: B3 Line contains hard tab characters (\t): "		return -1;"
314: B3 Line contains hard tab characters (\t): "	}"
316: B3 Line contains hard tab characters (\t): "	for (tries = 0; tries < 64; tries++) {"
317: B3 Line contains hard tab characters (\t): "		memset(buf, 0, sizeof(buf));"
318: B3 Line contains hard tab characters (\t): "		n = read(vhci_fd, buf, sizeof(buf));"
319: B3 Line contains hard tab characters (\t): "		if (n < 0) {"
320: B3 Line contains hard tab characters (\t): "			return -1;"
321: B3 Line contains hard tab characters (\t): "		}"
322: B3 Line contains hard tab characters (\t): "		if (n >= 4 && (uint8_t)buf[0] == HCI_VENDOR_PKT) {"
323: B3 Line contains hard tab characters (\t): "			hci_dev_id = (uint8_t)buf[2] |"
324: B3 Line contains hard tab characters (\t): "				     ((uint8_t)buf[3] << 8);"
325: B3 Line contains hard tab characters (\t): "			break;"
326: B3 Line contains hard tab characters (\t): "		}"
327: B3 Line contains hard tab characters (\t): "		if (n > 0 && (uint8_t)buf[0] == HCI_COMMAND_PKT)"
328: B3 Line contains hard tab characters (\t): "			process_command_pkt(vhci_fd, buf + 1, n - 1);"
329: B3 Line contains hard tab characters (\t): "	}"
330: B3 Line contains hard tab characters (\t): "	if (hci_dev_id < 0) {"
331: B3 Line contains hard tab characters (\t): "		return -1;"
332: B3 Line contains hard tab characters (\t): "	}"
334: B3 Line contains hard tab characters (\t): "	if (pthread_create(&th, NULL, event_thread, NULL)) {"
335: B3 Line contains hard tab characters (\t): "		return -1;"
336: B3 Line contains hard tab characters (\t): "	}"
337: B3 Line contains hard tab characters (\t): "	pthread_detach(th);"
339: B3 Line contains hard tab characters (\t): "	ret = ioctl(hci_sock, HCIDEVUP, hci_dev_id);"
340: B3 Line contains hard tab characters (\t): "	if (ret) {"
341: B3 Line contains hard tab characters (\t): "		if (errno == ERFKILL) {"
342: B3 Line contains hard tab characters (\t): "			rfkill_unblock_all();"
343: B3 Line contains hard tab characters (\t): "			ret = ioctl(hci_sock, HCIDEVUP, hci_dev_id);"
344: B3 Line contains hard tab characters (\t): "		}"
345: B3 Line contains hard tab characters (\t): "		if (ret && errno != EALREADY) {"
346: B3 Line contains hard tab characters (\t): "			return -1;"
347: B3 Line contains hard tab characters (\t): "		}"
348: B3 Line contains hard tab characters (\t): "	}"
350: B3 Line contains hard tab characters (\t): "	memset(&dr, 0, sizeof(dr));"
351: B3 Line contains hard tab characters (\t): "	dr.dev_id = hci_dev_id;"
352: B3 Line contains hard tab characters (\t): "	dr.dev_opt = SCAN_PAGE;"
353: B3 Line contains hard tab characters (\t): "	if (ioctl(hci_sock, HCISETSCAN, &dr)) {"
354: B3 Line contains hard tab characters (\t): "		return -1;"
355: B3 Line contains hard tab characters (\t): "	}"
357: B3 Line contains hard tab characters (\t): "	inject_fake_acl_link();"
358: B3 Line contains hard tab characters (\t): "	usleep(200000);"
359: B3 Line contains hard tab characters (\t): "	return 0;"
370: B3 Line contains hard tab characters (\t): "	memset(sa, 0, sizeof(*sa));"
371: B3 Line contains hard tab characters (\t): "	sa->l2_family = AF_BLUETOOTH;"
372: B3 Line contains hard tab characters (\t): "	sa->l2_psm = 0x0021;"
373: B3 Line contains hard tab characters (\t): "	memset(&sa->l2_bdaddr, 0xaa, 6);"
374: B3 Line contains hard tab characters (\t): "	sa->l2_bdaddr.b[5] = 0x10;"
375: B3 Line contains hard tab characters (\t): "	sa->l2_cid = 0;"
376: B3 Line contains hard tab characters (\t): "	sa->l2_bdaddr_type = 0;"
381: B3 Line contains hard tab characters (\t): "	struct sockaddr_l2 sa;"
383: B3 Line contains hard tab characters (\t): "	(void)arg;"
384: B3 Line contains hard tab characters (\t): "	prctl(PR_SET_NAME, "syzrepro0", 0, 0, 0);"
385: B3 Line contains hard tab characters (\t): "	fill_addr(&sa);"
386: B3 Line contains hard tab characters (\t): "	pthread_barrier_wait(&barrier);"
388: B3 Line contains hard tab characters (\t): "	usleep(20000);"
389: B3 Line contains hard tab characters (\t): "	errno = 0;"
390: B3 Line contains hard tab characters (\t): "	if (connect(fd0, (struct sockaddr *)&sa, 14) < 0)"
391: B3 Line contains hard tab characters (\t): "		connect_err0 = errno;"
392: B3 Line contains hard tab characters (\t): "	else"
393: B3 Line contains hard tab characters (\t): "		connect_err0 = 0;"
394: B3 Line contains hard tab characters (\t): "	return NULL;"
399: B3 Line contains hard tab characters (\t): "	(void)arg;"
400: B3 Line contains hard tab characters (\t): "	prctl(PR_SET_NAME, "syzrepro1", 0, 0, 0);"
401: B3 Line contains hard tab characters (\t): "	pthread_barrier_wait(&barrier);"
402: B3 Line contains hard tab characters (\t): "	shutdown(fd0, SHUT_RDWR);"
403: B3 Line contains hard tab characters (\t): "	return NULL;"
408: B3 Line contains hard tab characters (\t): "	struct sockaddr_l2 sa;"
410: B3 Line contains hard tab characters (\t): "	(void)arg;"
411: B3 Line contains hard tab characters (\t): "	prctl(PR_SET_NAME, "syzrepro2", 0, 0, 0);"
412: B3 Line contains hard tab characters (\t): "	fill_addr(&sa);"
413: B3 Line contains hard tab characters (\t): "	pthread_barrier_wait(&barrier);"
415: B3 Line contains hard tab characters (\t): "	usleep(100000);"
416: B3 Line contains hard tab characters (\t): "	errno = 0;"
417: B3 Line contains hard tab characters (\t): "	if (connect(fd1, (struct sockaddr *)&sa, 14) < 0)"
418: B3 Line contains hard tab characters (\t): "		connect_err2 = errno;"
419: B3 Line contains hard tab characters (\t): "	else"
420: B3 Line contains hard tab characters (\t): "		connect_err2 = 0;"
421: B3 Line contains hard tab characters (\t): "	return NULL;"
426: B3 Line contains hard tab characters (\t): "	return err == EHOSTUNREACH || err == ECONNREFUSED ||"
427: B3 Line contains hard tab characters (\t): "	       err == EOPNOTSUPP || err == ETIMEDOUT || err == ENOTCONN ||"
428: B3 Line contains hard tab characters (\t): "	       err == EIO;"
433: B3 Line contains hard tab characters (\t): "	int iters = 40;"
434: B3 Line contains hard tab characters (\t): "	int i;"
436: B3 Line contains hard tab characters (\t): "	setvbuf(stdout, NULL, _IOLBF, 0);"
438: B3 Line contains hard tab characters (\t): "	if (setup_vhci() < 0) {"
439: B3 Line contains hard tab characters (\t): "		return 1;"
440: B3 Line contains hard tab characters (\t): "	}"
442: B3 Line contains hard tab characters (\t): "	for (i = 0; i < iters; i++) {"
443: B3 Line contains hard tab characters (\t): "		pthread_t t0, t1, t2;"
445: B3 Line contains hard tab characters (\t): "		fd0 = socket(AF_BLUETOOTH, SOCK_SEQPACKET | SOCK_NONBLOCK,"
446: B3 Line contains hard tab characters (\t): "			     BTPROTO_L2CAP);"
447: B3 Line contains hard tab characters (\t): "		if (fd0 < 0) {"
448: B3 Line contains hard tab characters (\t): "			return 1;"
449: B3 Line contains hard tab characters (\t): "		}"
450: B3 Line contains hard tab characters (\t): "		fd1 = socket(AF_BLUETOOTH, SOCK_SEQPACKET | SOCK_NONBLOCK,"
451: B3 Line contains hard tab characters (\t): "			     BTPROTO_L2CAP);"
452: B3 Line contains hard tab characters (\t): "		if (fd1 < 0) {"
453: B3 Line contains hard tab characters (\t): "			close(fd0);"
454: B3 Line contains hard tab characters (\t): "			return 1;"
455: B3 Line contains hard tab characters (\t): "		}"
457: B3 Line contains hard tab characters (\t): "		connect_err0 = -1;"
458: B3 Line contains hard tab characters (\t): "		connect_err2 = -1;"
460: B3 Line contains hard tab characters (\t): "		if (pthread_barrier_init(&barrier, NULL, 3)) {"
461: B3 Line contains hard tab characters (\t): "			return 1;"
462: B3 Line contains hard tab characters (\t): "		}"
463: B3 Line contains hard tab characters (\t): "		if (pthread_create(&t0, NULL, thread0, NULL) ||"
464: B3 Line contains hard tab characters (\t): "		    pthread_create(&t1, NULL, thread1, NULL) ||"
465: B3 Line contains hard tab characters (\t): "		    pthread_create(&t2, NULL, thread2, NULL)) {"
466: B3 Line contains hard tab characters (\t): "			return 1;"
467: B3 Line contains hard tab characters (\t): "		}"
468: B3 Line contains hard tab characters (\t): "		pthread_join(t0, NULL);"
469: B3 Line contains hard tab characters (\t): "		pthread_join(t1, NULL);"
470: B3 Line contains hard tab characters (\t): "		pthread_join(t2, NULL);"
471: B3 Line contains hard tab characters (\t): "		pthread_barrier_destroy(&barrier);"
473: B3 Line contains hard tab characters (\t): "		close(fd0);"
474: B3 Line contains hard tab characters (\t): "		close(fd1);"
476: B3 Line contains hard tab characters (\t): "		if (i == 0 || (i % 5) == 0)"
477: B3 Line contains hard tab characters (\t): "			LOG("iter %d: connect0=%d connect2=%d", i,"
478: B3 Line contains hard tab characters (\t): "			    connect_err0, connect_err2);"
480: B3 Line contains hard tab characters (\t): "		if (link_is_gone(connect_err0) || link_is_gone(connect_err2)) {"
481: B3 Line contains hard tab characters (\t): "			inject_fake_acl_link();"
482: B3 Line contains hard tab characters (\t): "			usleep(200000);"
483: B3 Line contains hard tab characters (\t): "		}"
484: B3 Line contains hard tab characters (\t): "	}"
486: B3 Line contains hard tab characters (\t): "	return 0;"
492: B1 Line exceeds max length (110>80): "Oops: general protection fault, probably for non-canonical address 0xfbd59bffffffffcc: 0000 [#1] SMP KASAN PTI"
494: B2 Line has trailing whitespace: "CPU: 3 UID: 0 PID: 404 Comm: syzrepro2 Not tainted 7.2.0-dirty #2 PREEMPT "
495: B1 Line exceeds max length (88>80): "Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014"
499: B1 Line exceeds max length (199>80): "Code: e9 64 04 00 00 4d 8b 6d 00 4d 39 e5 0f 84 e7 03 00 00 49 8d ad 66 fd ff ff 48 89 e8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <0f> b6 04 08 84 c0 0f 85 89 00 00 00 49 8d 85 40 fd ff ff 66 44 39"
522: B1 Line exceeds max length (199>80): "Code: 83 ec 18 89 54 24 0c 48 89 34 24 89 7c 24 08 e8 3b b0 f7 ff 8b 54 24 0c 48 8b 34 24 41 89 c0 8b 7c 24 08 b8 2a 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35 44 89 c7 89 44 24 08 e8 91 b0 f7 ff 8b 44"
535: B1 Line exceeds max length (199>80): "Code: e9 64 04 00 00 4d 8b 6d 00 4d 39 e5 0f 84 e7 03 00 00 49 8d ad 66 fd ff ff 48 89 e8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <0f> b6 04 08 84 c0 0f 85 89 00 00 00 49 8d 85 40 fd ff ff 66 44 39"
547: B3 Line contains hard tab characters (\t): "   0:	e9 64 04 00 00       	jmpq   0x469"
548: B3 Line contains hard tab characters (\t): "   5:	4d 8b 6d 00          	mov    0x0(%r13),%r13"
549: B3 Line contains hard tab characters (\t): "   9:	4d 39 e5             	cmp    %r12,%r13"
550: B3 Line contains hard tab characters (\t): "   c:	0f 84 e7 03 00 00    	je     0x3f9"
551: B3 Line contains hard tab characters (\t): "  12:	49 8d ad 66 fd ff ff 	lea    -0x29a(%r13),%rbp"
552: B3 Line contains hard tab characters (\t): "  19:	48 89 e8             	mov    %rbp,%rax"
553: B3 Line contains hard tab characters (\t): "  1c:	48 c1 e8 03          	shr    $0x3,%rax"
554: B3 Line contains hard tab characters (\t): "  20:	48 b9 00 00 00 00 00 	movabs $0xdffffc0000000000,%rcx"
555: B3 Line contains hard tab characters (\t): "  27:	fc ff df"
556: B3 Line contains hard tab characters (\t): "* 2a:	0f b6 04 08          	movzbl (%rax,%rcx,1),%eax <-- trapping instruction"
557: B3 Line contains hard tab characters (\t): "  2e:	84 c0                	test   %al,%al"
558: B3 Line contains hard tab characters (\t): "  30:	0f 85 89 00 00 00    	jne    0xbf"
559: B3 Line contains hard tab characters (\t): "  36:	49 8d 85 40 fd ff ff 	lea    -0x2c0(%r13),%rax"
560: B3 Line contains hard tab characters (\t): "  3d:	66                   	data16"
561: B3 Line contains hard tab characters (\t): "  3e:	44                   	rex.R"
562: B3 Line contains hard tab characters (\t): "  3f:	39                   	.byte 0x39"
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/645

---
Regards,
Linux Bluetooth


--===============5277730770308473621==--
