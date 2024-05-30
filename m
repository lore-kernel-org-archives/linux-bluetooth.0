Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8863F158D6C
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 May 2024 20:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717100447; cv=none; b=BPmWZEjjMqpJCj8jcxmkuZEvuyNnlxioS/URSI1zFombyjxy69VL5g9uN6cfpwXynIYVFP1AFmb9GO9Eiii2KpeVEf7yO6P1g8dA8c1K4wDtmeSoVtvEaD8mEJ3/41glPHqQJgDzzTnqFmhjGE5R42hbHTksjB8pLjxJpk7PKBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717100447; c=relaxed/simple;
	bh=zDi8K0HVWk7kkl3GOdts/xAlfWxfKcnCMhsfGmBCG7A=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=SrdSDg+LCHd42dj/R52Ghd8aep8iPsOLKHyytWGG4u16bTdGy75bYPewaEp/S+kWSjhNfb16KmtMd9CAQm1eT0XjdCjvcOUXHDDVTuchDjcuwe5Iq88LcYrzDjq+s2kMif/0EuALXV3Lg+JnNtTkVUjz3Os1ynCnDUF9ukI040Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QMU6BMrv; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMU6BMrv"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-43f8e0d8616so6163621cf.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 May 2024 13:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717100444; x=1717705244; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Gbwkn3ehCJlmvT2Mla5zzkLSPBKDiaIWYrqsjCRwKk8=;
        b=QMU6BMrv4b9FjIb7Jsl8LUQ3/qX/7kprYxtPJMwXjUPO0OnYk/Ze8OwtqZJdxkwD4n
         ZtLRXlvhZJz9Q05ALPW7sj8fg/xp31IK8XozXfk3nDI0O4giDQNsScgopF6bfPKqeLum
         mP8fwiJ95ZAAtU2kqu/MXuHbqfkgvClKihucNH/B+O22wSdRKHZqBcDkzIf4lRILJYFg
         QNZyIzcfIIMEahrX2ltBGXwtiwe4zQDzPANJcCuFrkSBw5JsJGNfbFUFg1ZirOPeVihD
         KluiKaBtCkYXQg0k6nlK8Nrnzf5VrVv7QMPINlPi+n+f1hKxyrbwO/zE2GSehTHjYQ5P
         PJjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717100444; x=1717705244;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gbwkn3ehCJlmvT2Mla5zzkLSPBKDiaIWYrqsjCRwKk8=;
        b=Y64PUh7TSGPn9LtWd5Icizx89YPe7J6KH5/vEB/cNLb9yMdyX+8GTTHbtjZoQOPMCi
         SIR8M1vS7oZ8o9LCNRiKdDY/bUdDph1A2uCKDSKoq24BgcW7ryprEYXT9RGPixuQCXiU
         92+kaQbAiODk43smhpOrrxkurh6F0Tp+YT9IFhhlgF5sFhvA0AezsMwB0Fxe8iWiTGZB
         pKuV9M3P5Q4IFqHUS6EY14BqcMimaHk2T6WbDAZtuc4MP5+oo9q0YqrVk74HjTb/tpz7
         KM9S3oRuTtFCpqfd7oBuxCLFt45yMYlC7TFfHBlsKypfQah8ICYWPPp3oahX0X5rI7Ac
         YJcA==
X-Gm-Message-State: AOJu0YwFUeccGS2Icxuk2JwX9YiFYe4Y6tkd1ej0v3XYrA12kxvkWPRS
	69uo+E2pw+YST88wbK1gQzoLUsc60a+0dbrpgw+vT+eOZ7xARWn8WnUNWA==
X-Google-Smtp-Source: AGHT+IE802D9PiYyADW+uY31Nmt+dHK10RXlwdHmU3U/Mye9zBDVInyC7JjTTLwsXG4lDMov9BJR7A==
X-Received: by 2002:a05:622a:134b:b0:43f:e307:8125 with SMTP id d75a77b69052e-43fe931303bmr37369991cf.41.1717100443590;
        Thu, 30 May 2024 13:20:43 -0700 (PDT)
Received: from [172.17.0.2] ([20.51.198.157])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43ff25975easm1347141cf.97.2024.05.30.13.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 13:20:43 -0700 (PDT)
Message-ID: <6658df9b.050a0220.6e14f.0f20@mx.google.com>
Date: Thu, 30 May 2024 13:20:43 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5277816049093325895=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: Fix a number of static analysis issues #3
In-Reply-To: <20240530150057.444585-2-hadess@hadess.net>
References: <20240530150057.444585-2-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5277816049093325895==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=857401

---Test result---

Test Summary:
CheckPatch                    FAIL      4.74 seconds
GitLint                       FAIL      3.24 seconds
BuildEll                      PASS      25.18 seconds
BluezMake                     PASS      1728.81 seconds
MakeCheck                     PASS      13.48 seconds
MakeDistcheck                 PASS      183.04 seconds
CheckValgrind                 PASS      257.35 seconds
CheckSmatch                   WARNING   363.75 seconds
bluezmakeextell               PASS      122.78 seconds
IncrementalBuild              PASS      14512.82 seconds
ScanBuild                     WARNING   1040.80 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,2/9] mgmt-tester: Fix buffer overrun
WARNING:UNKNOWN_COMMIT_ID: Unknown commit id '49d06560692f', maybe rebased or not pulled?
#60: 
Fixes: 49d06560692f ("mgmt-tester: Fix non-nul-terminated string")

/github/workspace/src/src/13680511.patch total: 0 errors, 1 warnings, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13680511.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,6/9] sdp: Fix ineffective error guard
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#63: 
4095|		reqhdr->plen = htons((t->reqsize + cstate_len) - sizeof(sdp_pdu_hdr_t));

/github/workspace/src/src/13680516.patch total: 0 errors, 1 warnings, 32 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13680516.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,7/9] obexd: Fix buffer overrun
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#57: 
1142|->		p->req_id = g_obex_setpath(p->session->obex, first, setpath_cb, p, err);

/github/workspace/src/src/13680515.patch total: 0 errors, 1 warnings, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13680515.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,9/9] avdtp: Fix manipulating struct as an array
WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#185: FILE: profiles/audio/avdtp.c:1925:
+		struct seid *seid = suspend_req_get_nth_seid(req, seid_count, i);

/github/workspace/src/src/13680514.patch total: 0 errors, 1 warnings, 82 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13680514.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,1/9] rctest: Fix possible overrun

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
4: B1 Line exceeds max length (200>80): "bluez-5.76/tools/rctest.c:556:3: return_constant: Function call "read(fd, buf, data_size)" may return -1. [Note: The source code implementation of the function has been overridden by a builtin model.]"
5: B1 Line exceeds max length (121>80): "bluez-5.76/tools/rctest.c:556:3: assignment: Assigning: "len" = "read(fd, buf, data_size)". The value of "len" is now -1."
6: B1 Line exceeds max length (233>80): "bluez-5.76/tools/rctest.c:557:3: overrun-buffer-arg: Calling "send" with "buf" and "len" is suspicious because of the very large index, 18446744073709551615. The index may be due to a negative parameter being interpreted as unsigned."
7: B3 Line contains hard tab characters (\t): "555|		}"
8: B3 Line contains hard tab characters (\t): "556|		len = read(fd, buf, data_size);"
9: B3 Line contains hard tab characters (\t): "557|->		send(sk, buf, len, 0);"
10: B3 Line contains hard tab characters (\t): "558|		close(fd);"
11: B3 Line contains hard tab characters (\t): "559|		return;"
[BlueZ,2/9] mgmt-tester: Fix buffer overrun

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
4: B1 Line exceeds max length (148>80): "bluez-5.76/tools/mgmt-tester.c:12667:2: identity_transfer: Passing "512UL" as argument 3 to function "vhci_read_devcd", which returns that argument."
5: B1 Line exceeds max length (140>80): "bluez-5.76/tools/mgmt-tester.c:12667:2: assignment: Assigning: "read" = "vhci_read_devcd(vhci, buf, 512UL)". The value of "read" is now 512."
6: B1 Line exceeds max length (159>80): "bluez-5.76/tools/mgmt-tester.c:12674:2: overrun-local: Overrunning array "buf" of 513 bytes at byte offset 513 using index "read + 1" (which evaluates to 513)."
7: B3 Line contains hard tab characters (\t): "12672|		}"
8: B3 Line contains hard tab characters (\t): "12673|		/* Make sure buf is nul-terminated */"
9: B3 Line contains hard tab characters (\t): "12674|->	buf[read + 1] = '\0';"
11: B3 Line contains hard tab characters (\t): "12676|		/* Verify if all devcoredump header fields are present */"
[BlueZ,3/9] l2test: Add missing error checking

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
7: B3 Line contains hard tab characters (\t): "977|->			len = send(sk, buf + sent, buflen, 0);"
9: B3 Line contains hard tab characters (\t): "979|			sent += len;"
[BlueZ,4/9] rfkill: Avoid using a signed int for an unsigned variable

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
4: B1 Line exceeds max length (94>80): "bluez-5.76/src/rfkill.c:101:3: tainted_data_argument: The value "event" is considered tainted."
5: B1 Line exceeds max length (88>80): "bluez-5.76/src/rfkill.c:105:3: tainted_data_argument: "event.idx" is considered tainted."
6: B1 Line exceeds max length (117>80): "bluez-5.76/src/rfkill.c:105:3: underflow: The cast of "event.idx" to a signed type could result in a negative number."
7: B3 Line contains hard tab characters (\t): "103|			break;"
9: B3 Line contains hard tab characters (\t): "105|->		id = get_adapter_id_for_rfkill(event.idx);"
11: B3 Line contains hard tab characters (\t): "107|		if (index == id) {"
14: B1 Line exceeds max length (94>80): "bluez-5.76/src/rfkill.c:133:2: tainted_data_argument: The value "event" is considered tainted."
15: B1 Line exceeds max length (88>80): "bluez-5.76/src/rfkill.c:143:2: tainted_data_argument: "event.idx" is considered tainted."
16: B1 Line exceeds max length (117>80): "bluez-5.76/src/rfkill.c:157:2: underflow: The cast of "event.idx" to a signed type could result in a negative number."
17: B3 Line contains hard tab characters (\t): "155|		return TRUE;"
19: B3 Line contains hard tab characters (\t): "157|->	id = get_adapter_id_for_rfkill(event.idx);"
20: B3 Line contains hard tab characters (\t): "158|	if (id < 0)"
21: B3 Line contains hard tab characters (\t): "159|		return TRUE;"
[BlueZ,5/9] shared/mainloop: Fix integer overflow

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
9: B1 Line exceeds max length (107>80): "bluez-5.76/src/shared/mainloop-notify.c:132:2: tainted_data_argument: The value "si" is considered tainted."
10: B1 Line exceeds max length (107>80): "bluez-5.76/src/shared/mainloop-notify.c:137:3: tainted_data_argument: "si.ssi_signo" is considered tainted."
11: B1 Line exceeds max length (136>80): "bluez-5.76/src/shared/mainloop-notify.c:137:3: underflow: The cast of "si.ssi_signo" to a signed type could result in a negative number."
13: B3 Line contains hard tab characters (\t): "136|	if (data && data->func)"
14: B3 Line contains hard tab characters (\t): "137|->		data->func(si.ssi_signo, data->user_data);"
16: B3 Line contains hard tab characters (\t): "139|	return true;"
[BlueZ,6/9] sdp: Fix ineffective error guard

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
11: B1 Line exceeds max length (214>80): "bluez-5.76/lib/sdp.c:4082:2: tainted_data_return: Called function "gen_attridseq_pdu(pdata, attrid_list, ((reqtype == SDP_ATTR_REQ_INDIVIDUAL) ? 9 : 10))", and a possible return value is known to be less than zero."
12: B1 Line exceeds max length (148>80): "bluez-5.76/lib/sdp.c:4082:2: assign: Assigning: "seqlen" = "gen_attridseq_pdu(pdata, attrid_list, ((reqtype == SDP_ATTR_REQ_INDIVIDUAL) ? 9 : 10))"."
13: B1 Line exceeds max length (109>80): "bluez-5.76/lib/sdp.c:4091:2: overflow: The expression "t->reqsize" is considered to have possibly overflowed."
14: B1 Line exceeds max length (154>80): "bluez-5.76/lib/sdp.c:4097:2: overflow: The expression "t->reqsize + cstate_len" is deemed overflowed because at least one of its arguments has overflowed."
15: B1 Line exceeds max length (174>80): "bluez-5.76/lib/sdp.c:4097:2: overflow_sink: "t->reqsize + cstate_len", which might have underflowed, is passed to "sdp_send_req(session, t->reqbuf, t->reqsize + cstate_len)"."
16: B3 Line contains hard tab characters (\t): "4095|		reqhdr->plen = htons((t->reqsize + cstate_len) - sizeof(sdp_pdu_hdr_t));"
18: B3 Line contains hard tab characters (\t): "4097|->		if (sdp_send_req(session, t->reqbuf, t->reqsize + cstate_len) < 0) {"
19: B3 Line contains hard tab characters (\t): "4098|			SDPERR("Error sending data:%m");"
20: B3 Line contains hard tab characters (\t): "4099|			t->err = errno;"
23: B1 Line exceeds max length (210>80): "bluez-5.76/lib/sdp.c:4466:2: tainted_data_return: Called function "gen_attridseq_pdu(pdata, attrids, ((reqtype == SDP_ATTR_REQ_INDIVIDUAL) ? 9 : 10))", and a possible return value is known to be less than zero."
24: B1 Line exceeds max length (144>80): "bluez-5.76/lib/sdp.c:4466:2: assign: Assigning: "seqlen" = "gen_attridseq_pdu(pdata, attrids, ((reqtype == SDP_ATTR_REQ_INDIVIDUAL) ? 9 : 10))"."
25: B1 Line exceeds max length (106>80): "bluez-5.76/lib/sdp.c:4475:2: overflow: The expression "reqsize" is considered to have possibly overflowed."
27: B1 Line exceeds max length (187>80): "bluez-5.76/lib/sdp.c:4486:3: overflow: The expression "_reqsize + copy_cstate(_pdata, 2048U - _reqsize, cstate)" is deemed overflowed because at least one of its arguments has overflowed."
28: B1 Line exceeds max length (119>80): "bluez-5.76/lib/sdp.c:4486:3: assign: Assigning: "reqsize" = "_reqsize + copy_cstate(_pdata, 2048U - _reqsize, cstate)"."
29: B1 Line exceeds max length (164>80): "bluez-5.76/lib/sdp.c:4492:3: overflow_sink: "reqsize", which might have underflowed, is passed to "sdp_send_req_w4_rsp(session, reqbuf, rspbuf, reqsize, &rspsize)"."
30: B3 Line contains hard tab characters (\t): "4490|			reqhdr->plen = htons(reqsize - sizeof(sdp_pdu_hdr_t));"
31: B3 Line contains hard tab characters (\t): "4491|			rsphdr = (sdp_pdu_hdr_t *) rspbuf;"
32: B1 Line exceeds max length (83>80): "4492|->			status = sdp_send_req_w4_rsp(session, reqbuf, rspbuf, reqsize, &rspsize);"
32: B3 Line contains hard tab characters (\t): "4492|->			status = sdp_send_req_w4_rsp(session, reqbuf, rspbuf, reqsize, &rspsize);"
33: B3 Line contains hard tab characters (\t): "4493|			if (rspsize < sizeof(sdp_pdu_hdr_t)) {"
34: B3 Line contains hard tab characters (\t): "4494|				SDPERR("Unexpected end of packet");"
[BlueZ,7/9] obexd: Fix buffer overrun

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
6: B1 Line exceeds max length (141>80): "bluez-5.76/obexd/client/session.c:1135:2: alias: Assigning: "first" = """". "first" now points to byte 0 of """" (which consists of 1 bytes)."
7: B1 Line exceeds max length (177>80): "bluez-5.76/obexd/client/session.c:1142:2: overrun-buffer-val: Overrunning buffer pointed to by "first" of 1 bytes by passing it to a function which accesses it at byte offset 2."
8: B3 Line contains hard tab characters (\t): "1140|		req->index++;"
10: B1 Line exceeds max length (81>80): "1142|->		p->req_id = g_obex_setpath(p->session->obex, first, setpath_cb, p, err);"
10: B3 Line contains hard tab characters (\t): "1142|->		p->req_id = g_obex_setpath(p->session->obex, first, setpath_cb, p, err);"
11: B3 Line contains hard tab characters (\t): "1143|		if (*err != NULL)"
12: B3 Line contains hard tab characters (\t): "1144|			return (*err)->code;"
[BlueZ,8/9] bap: Fix more memory leaks on error

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
4: B1 Line exceeds max length (201>80): "bluez-5.76/profiles/audio/bap.c:1166:4: alloc_arg: "asprintf" allocates memory that is stored into "path". [Note: The source code implementation of the function has been overridden by a builtin model.]"
5: B1 Line exceeds max length (122>80): "bluez-5.76/profiles/audio/bap.c:1178:5: leaked_storage: Variable "path" going out of scope leaks the storage it points to."
6: B3 Line contains hard tab characters (\t): "1176|					free(l3_caps);"
7: B3 Line contains hard tab characters (\t): "1177|					ret = false;"
8: B3 Line contains hard tab characters (\t): "1178|->					goto group_fail;"
9: B3 Line contains hard tab characters (\t): "1179|				}"
13: B1 Line exceeds max length (201>80): "bluez-5.76/profiles/audio/bap.c:1166:4: alloc_arg: "asprintf" allocates memory that is stored into "path". [Note: The source code implementation of the function has been overridden by a builtin model.]"
14: B1 Line exceeds max length (122>80): "bluez-5.76/profiles/audio/bap.c:1199:5: leaked_storage: Variable "path" going out of scope leaks the storage it points to."
16: B3 Line contains hard tab characters (\t): "1198|				if (matched_lpac == NULL || merged_caps == NULL)"
17: B3 Line contains hard tab characters (\t): "1199|->					continue;"
19: B3 Line contains hard tab characters (\t): "1201|				create_stream_for_bis(bap_data, matched_lpac, qos,"
[BlueZ,9/9] avdtp: Fix manipulating struct as an array

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
7: B1 Line exceeds max length (122>80): "bluez-5.76/profiles/audio/avdtp.c:1675:2: address_of: Taking address with "&start->first_seid" yields a singleton pointer."
8: B1 Line exceeds max length (91>80): "bluez-5.76/profiles/audio/avdtp.c:1675:2: assign: Assigning: "seid" = "&start->first_seid"."
9: B1 Line exceeds max length (142>80): "bluez-5.76/profiles/audio/avdtp.c:1679:25: ptr_arith: Using "seid" as an array.  This might corrupt or misinterpret adjacent memory locations."
17: B1 Line exceeds max length (124>80): "bluez-5.76/profiles/audio/avdtp.c:1690:2: address_of: Taking address with "&suspend->first_seid" yields a singleton pointer."
18: B1 Line exceeds max length (93>80): "bluez-5.76/profiles/audio/avdtp.c:1690:2: assign: Assigning: "seid" = "&suspend->first_seid"."
19: B1 Line exceeds max length (142>80): "bluez-5.76/profiles/audio/avdtp.c:1694:25: ptr_arith: Using "seid" as an array.  This might corrupt or misinterpret adjacent memory locations."
20: B3 Line contains hard tab characters (\t): "1692|		int i;"
22: B3 Line contains hard tab characters (\t): "1694|->		for (i = 0; i < count; i++, seid++) {"
23: B3 Line contains hard tab characters (\t): "1695|			if (seid->seid == id) {"
24: B3 Line contains hard tab characters (\t): "1696|				req->collided = TRUE;"
27: B1 Line exceeds max length (120>80): "bluez-5.76/profiles/audio/avdtp.c:1799:2: address_of: Taking address with "&req->first_seid" yields a singleton pointer."
28: B1 Line exceeds max length (89>80): "bluez-5.76/profiles/audio/avdtp.c:1799:2: assign: Assigning: "seid" = "&req->first_seid"."
29: B1 Line exceeds max length (142>80): "bluez-5.76/profiles/audio/avdtp.c:1801:30: ptr_arith: Using "seid" as an array.  This might corrupt or misinterpret adjacent memory locations."
30: B3 Line contains hard tab characters (\t): "1799|		seid = &req->first_seid;"
32: B3 Line contains hard tab characters (\t): "1801|->		for (i = 0; i < seid_count; i++, seid++) {"
33: B3 Line contains hard tab characters (\t): "1802|			failed_seid = seid->seid;"
37: B1 Line exceeds max length (120>80): "bluez-5.76/profiles/audio/avdtp.c:1912:2: address_of: Taking address with "&req->first_seid" yields a singleton pointer."
38: B1 Line exceeds max length (89>80): "bluez-5.76/profiles/audio/avdtp.c:1912:2: assign: Assigning: "seid" = "&req->first_seid"."
39: B1 Line exceeds max length (142>80): "bluez-5.76/profiles/audio/avdtp.c:1914:30: ptr_arith: Using "seid" as an array.  This might corrupt or misinterpret adjacent memory locations."
40: B3 Line contains hard tab characters (\t): "1912|		seid = &req->first_seid;"
42: B3 Line contains hard tab characters (\t): "1914|->	for (i = 0; i < seid_count; i++, seid++) {"
43: B3 Line contains hard tab characters (\t): "1915|			failed_seid = seid->seid;"
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
tools/rctest.c:625:33: warning: non-ANSI function declaration of function 'automated_send_recv'
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
profiles/audio/avdtp.c:909:25: warning: Use of memory after it is freed
                session->prio_queue = g_slist_remove(session->prio_queue, req);
                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
profiles/audio/avdtp.c:916:24: warning: Use of memory after it is freed
                session->req_queue = g_slist_remove(session->req_queue, req);
                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
2 warnings generated.



---
Regards,
Linux Bluetooth


--===============5277816049093325895==--
