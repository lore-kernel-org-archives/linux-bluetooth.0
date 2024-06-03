Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B363838F
	for <linux-bluetooth@vger.kernel.org>; Mon,  3 Jun 2024 19:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717443433; cv=none; b=d4Wv6x6qYp3wqcixSdpB9oGm9cf0HpogK7XITcpg6HA2V+sJVObY2ODqaySPTwDi4cLXP7OMnwoYhYd3K0safw/bebVuD86HH8kU1E3z4J3lwV7Qm/4AVdMmLzUWCHncmbhcrYiGlTAoQLVLJqbb7N6ENUvMu7vAcBZNHptflUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717443433; c=relaxed/simple;
	bh=Ddd09cat16fHOw/NOzoi7B1hgZ3Rj7nXKq++4WzKzJY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=qbboZRgHEnVKGQ3fFD3bspO96Capws6vUuTp3C7T22sKR/siOqBvuWnMKK4rNglIANkpVDCriMmQ/8thWXGLup6FEDPweQcpXWsbs9nbupA7tjCg4uGQSVeDwoiEBGBhDsCtcpEkqQcoT/XekaO1o1y3LCzHSbZnxrJ0TwPKMsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=OLJ0PQAG; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="OLJ0PQAG"
Received: from github.com (hubbernetes-node-f316f69.va3-iad.github.net [10.48.159.15])
	by smtp.github.com (Postfix) with ESMTPA id 2436A4E0FF5
	for <linux-bluetooth@vger.kernel.org>; Mon,  3 Jun 2024 12:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1717443431;
	bh=TWYSbdhKGEGhqSDp9uCS5B6EWrxymWnOHFrnIpuCmNk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=OLJ0PQAG2Heqyz7qden/H8kl3E4ZC/Oe5ewdSq/l/LB0YvMRgbF7pEJxHfwIK4hqX
	 5CRUr7LWP95VWrv/dAKgFOZZDbTm/258J/NaYC3bzhIzez9G1UpHikkGnhkvVuj/za
	 qPvk6e8Hg8Xcqm8848cCgG+GwGhMkzRPufc6LLfA=
Date: Mon, 03 Jun 2024 12:37:11 -0700
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/3f7477-cc8e6e@github.com>
Subject: [bluez/bluez] 684a17: test/example-gatt: fix deprecation warning
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 684a17f7cc789735f4cf46847525d70483dbb148
      https://github.com/bluez/bluez/commit/684a17f7cc789735f4cf46847525d70483dbb148
  Author: Preston Hunt <me@prestonhunt.com>
  Date:   2024-06-03 (Mon, 03 Jun 2024)

  Changed paths:
    M test/example-gatt-client
    M test/example-gatt-server

  Log Message:
  -----------
  test/example-gatt: fix deprecation warning

Use GLib instead of GObject to fix deprecation warning. Remove python2
gobject import.


  Commit: 24cf049395020c360534328a8c6b931a03a5f7dd
      https://github.com/bluez/bluez/commit/24cf049395020c360534328a8c6b931a03a5f7dd
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2024-06-03 (Mon, 03 Jun 2024)

  Changed paths:
    M tools/rctest.c

  Log Message:
  -----------
  rctest: Fix possible overrun

Error: OVERRUN (CWE-119): [#def57] [important]
tools/rctest.c:557:3:
overrun-buffer-arg: Calling "send" with "buf" and "len" is suspicious
because of the very large index, 18446744073709551615.
The index may be due to a negative parameter being interpreted as unsigned.
555|		}
556|		len = read(fd, buf, data_size);
557|->		send(sk, buf, len, 0);
558|		close(fd);
559|		return;


  Commit: aa54087f13d54320f57473b5a8e6d979314266bc
      https://github.com/bluez/bluez/commit/aa54087f13d54320f57473b5a8e6d979314266bc
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2024-06-03 (Mon, 03 Jun 2024)

  Changed paths:
    M tools/mgmt-tester.c

  Log Message:
  -----------
  mgmt-tester: Fix buffer overrun

Error: OVERRUN (CWE-119): [#def56] [important]
tools/mgmt-tester.c:12674:2: overrun-local:
Overrunning array "buf" of 513 bytes at byte offset 513 using
index "read + 1" (which evaluates to 513).
12672|		}
12673|		/* Make sure buf is nul-terminated */
12674|->	buf[read + 1] = '\0';
12675|
12676|		/* Verify if all devcoredump header fields are present */

Fixes: 49d06560692f ("mgmt-tester: Fix non-nul-terminated string")


  Commit: ccec5e8ef171e87ded5a6caf8caee7f1e2731552
      https://github.com/bluez/bluez/commit/ccec5e8ef171e87ded5a6caf8caee7f1e2731552
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2024-06-03 (Mon, 03 Jun 2024)

  Changed paths:
    M tools/l2test.c

  Log Message:
  -----------
  l2test: Add missing error checking

send() might fail and return a negative len, catch that to avoid
advancing the send buffer in the wrong direction and causing all sorts
of problems.

977|->			len = send(sk, buf + sent, buflen, 0);
978|
979|			sent += len;


  Commit: c9fcea121f9ad8b9c36263ea6254158c8fa793c8
      https://github.com/bluez/bluez/commit/c9fcea121f9ad8b9c36263ea6254158c8fa793c8
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2024-06-03 (Mon, 03 Jun 2024)

  Changed paths:
    M src/rfkill.c

  Log Message:
  -----------
  rfkill: Avoid using a signed int for an unsigned variable

Error: INTEGER_OVERFLOW (CWE-190): [#def37] [important]
src/rfkill.c:105:3: underflow:
The cast of "event.idx" to a signed type could result in a negative
number.
103|			break;
104|
105|->		id = get_adapter_id_for_rfkill(event.idx);
106|
107|		if (index == id) {

Error: INTEGER_OVERFLOW (CWE-190): [#def38] [important]
src/rfkill.c:157:2: underflow:
The cast of "event.idx" to a signed type could result in a negative
number.
155|		return TRUE;
156|
157|->	id = get_adapter_id_for_rfkill(event.idx);
158|	if (id < 0)
159|		return TRUE;


  Commit: 6cf9117bfd3f3b19cd6cfcf32910e29e57a4b1f7
      https://github.com/bluez/bluez/commit/6cf9117bfd3f3b19cd6cfcf32910e29e57a4b1f7
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2024-06-03 (Mon, 03 Jun 2024)

  Changed paths:
    M src/shared/mainloop-notify.c

  Log Message:
  -----------
  shared/mainloop: Fix integer overflow

signalfd_siginfo uses a u32 for the signal number, but siginfo_t uses a
signed integer for it, so an (unlikely) big value for the signal number
could result in a negative value being passed to the callbacks. Catch
that and bail early.

Error: INTEGER_OVERFLOW (CWE-190): [#def44] [important]
src/shared/mainloop-notify.c:137:3: underflow:
The cast of "si.ssi_signo" to a signed type could result in a negative
number.
135|
136|	if (data && data->func)
137|->		data->func(si.ssi_signo, data->user_data);
138|
139|	return true;


  Commit: bd954700e6314a19c56697a4a617233987f5654e
      https://github.com/bluez/bluez/commit/bd954700e6314a19c56697a4a617233987f5654e
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2024-06-03 (Mon, 03 Jun 2024)

  Changed paths:
    M lib/sdp.c

  Log Message:
  -----------
  sdp: Fix ineffective error guard

The return value from gen_attridseq_pdu() can be -ENOMEM or the always
positive return value from sdp_gen_pdu(), but we only guard against a
single negative return value "-1" (-EPERM).

Check for all negative values to avoid manipulating a negative length as
a valid one.

Error: INTEGER_OVERFLOW (CWE-190): [#def10] [important]
lib/sdp.c:4097:2: overflow_sink:
"t->reqsize + cstate_len", which might have underflowed, is passed to
"sdp_send_req(session, t->reqbuf, t->reqsize + cstate_len)".
4095|		reqhdr->plen = htons((t->reqsize + cstate_len) - sizeof(sdp_pdu_hdr_t));
4096|
4097|->		if (sdp_send_req(session, t->reqbuf, t->reqsize + cstate_len) < 0) {
4098|			SDPERR("Error sending data:%m");
4099|			t->err = errno;

Error: INTEGER_OVERFLOW (CWE-190): [#def11] [important]
lib/sdp.c:4492:3: overflow_sink:
"reqsize", which might have underflowed, is passed to
"sdp_send_req_w4_rsp(session, reqbuf, rspbuf, reqsize, &rspsize)".
4490|			reqhdr->plen = htons(reqsize - sizeof(sdp_pdu_hdr_t));
4491|			rsphdr = (sdp_pdu_hdr_t *) rspbuf;
4492|->			status = sdp_send_req_w4_rsp(session, reqbuf, rspbuf, reqsize, &rspsize);
4493|			if (rspsize < sizeof(sdp_pdu_hdr_t)) {
4494|				SDPERR("Unexpected end of packet");


  Commit: 1764cea5c7fd4f4a7af06c183822158c1e4c6fe7
      https://github.com/bluez/bluez/commit/1764cea5c7fd4f4a7af06c183822158c1e4c6fe7
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2024-06-03 (Mon, 03 Jun 2024)

  Changed paths:
    M gobex/gobex.c

  Log Message:
  -----------
  obexd: Fix buffer overrun

Don't access path at byte 2 when it might only contain a single byte.

Error: OVERRUN (CWE-119): [#def27] [important]
obexd/client/session.c:1142:2: overrun-buffer-val:
Overrunning buffer pointed to by "first" of 1 bytes by passing it to a
function which accesses it at byte offset 2.
1140|		req->index++;
1141|
1142|->		p->req_id = g_obex_setpath(p->session->obex, first, setpath_cb, p, err);
1143|		if (*err != NULL)
1144|			return (*err)->code;


  Commit: cc8e6ef63509ff69f8b2399802c6de320e957c2b
      https://github.com/bluez/bluez/commit/cc8e6ef63509ff69f8b2399802c6de320e957c2b
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2024-06-03 (Mon, 03 Jun 2024)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: Fix more memory leaks on error

Error: RESOURCE_LEAK (CWE-772): [#def32] [important]
profiles/audio/bap.c:1178:5: leaked_storage:
Variable "path" going out of scope leaks the storage it points to.
1176|					free(l3_caps);
1177|					ret = false;
1178|->					goto group_fail;
1179|				}
1180|

Error: RESOURCE_LEAK (CWE-772): [#def33] [important]
profiles/audio/bap.c:1199:5: leaked_storage:
Variable "path" going out of scope leaks the storage it points to.
1197|
1198|				if (matched_lpac == NULL || merged_caps == NULL)
1199|->					continue;
1200|
1201|				create_stream_for_bis(bap_data, matched_lpac, qos,


Compare: https://github.com/bluez/bluez/compare/3f747788c1b1...cc8e6ef63509

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
