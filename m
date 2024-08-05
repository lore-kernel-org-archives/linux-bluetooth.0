Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094BA13D521
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Aug 2024 19:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722886140; cv=none; b=Xo7wBIA8L6vT6uGAlqr0gv+Heytg/atqzfFmzaq8zpRiKy/ZS1WaQMk8XP6opPosjpKJMbr/UnB4i/bqnyfwpcPsjlNV/OqaIXSrT6brCqV6+rWbLjtPzHd73GTUfVSkxMdKPE/txuDke93cgXNgTQpnL3YQhpXHtXTPT0dXYb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722886140; c=relaxed/simple;
	bh=Aw+2zEoUsPEi9WMaJfmbdxU7Jru8ahCteIzXoEI0kaw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=YGX0NZiws4vz2G22KdhTvGbsu6JZDffYHD/fE1tba2vI+nJcOO6yc1+njPODmsP/XmzJmcmZao4qFxATMQL+F5epSbN8oJn4dsJldI8wGbPuTMf7de3xCmGB13/KY8fO+r1t0E7M/GlVSn9utq5JgDJ8KTvnxBXAhbng4JJ1GI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C6POaSZ7; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6POaSZ7"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-44fded90c41so56089151cf.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Aug 2024 12:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722886138; x=1723490938; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ialmbtGNzqxReEQCJtYdICAo9sveXc6ODiOowf+Bf1Y=;
        b=C6POaSZ7VBNBQnFtX3qjKKLWMynOmL17HxE4uccycylPFvqgOGKSJZGiXlp3cpG3tG
         Kxgh4UjUYQ5VKp8HFNeO4XZAmiaBRi6oKerkh/iv33LW9bIWXgUxiv1vLyd48xq6D8jU
         HfQ3e1Rl05ifHLb5or7+XizmDeCDtgn7eZv7ErmgBSyFHSP2x33MvwTRWxCs1/xuy2rC
         qCzBPAL0ZdozlIgRdcsuHfMaYxXuM/Wq1W7glImc2sW9YUn/uL1KUCg0NtW1JTbyBZ8Q
         uKC4OFUc3rTQmju3E6HZQyETGd1/p7m+2zpzvapzK0Z9mSQFDs+4efkgnB3VHmJGv+wZ
         FeAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722886138; x=1723490938;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ialmbtGNzqxReEQCJtYdICAo9sveXc6ODiOowf+Bf1Y=;
        b=q6KEzd6o8tlRfNZpZ/aZ2n8dUyaI769j/TSOYjDJFLZLaVu7SknoGcKdqjhh88cBE5
         1Fz8+zp2ETAHApIHhVyYiXpTC2EXcx4XxfmIdv3TOnSnKBqw8q3tVg35P5Fw9qgEVUC8
         U9hbWXR8gksXfCZZjbwgiPAz9DPszyQdBxh/HmCcrZJmLF81S+09ZTgcrzvt73znYDS5
         QCXZ7jFQFiQ41xDzvI1HAt6Q3d7TURYGnJhUZN3ohRY77W91WlPLPPa3Z9/AP1OmMhkR
         lOaKLh/Xm7yjD3aakPCfTPXcaeSsGFJ4SuOgK4W8IB8V2uwHReBfcJti1cla9fVxPACt
         4CQw==
X-Gm-Message-State: AOJu0Yzm5Vk4q2W0pIfbwbldjVOd67l3Zo1j0kIVYU3GYlTpM7vjjWEz
	FQCkeovjKqlLO3HFOgG1PVFUWONeQH1V1Z8GAYartKKpKxpc1JgTvpxytQ==
X-Google-Smtp-Source: AGHT+IFaQBI5O+l5Bl/5OGfKDFC+wZyhGV9+hYKK1N+fJFoUZVgYoLiC9CN2sE3Zg7oO4eNxkcJBtQ==
X-Received: by 2002:ac8:5d8f:0:b0:446:59ab:56a2 with SMTP id d75a77b69052e-451892171f2mr145780661cf.9.1722886137603;
        Mon, 05 Aug 2024 12:28:57 -0700 (PDT)
Received: from [172.17.0.2] ([20.161.78.197])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4518a6c547asm31980171cf.30.2024.08.05.12.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 12:28:57 -0700 (PDT)
Message-ID: <66b127f9.c80a0220.162963.a59a@mx.google.com>
Date: Mon, 05 Aug 2024 12:28:57 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7521173863829911765=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: Fix a number of static analysis issues #6
In-Reply-To: <20240805140840.1606239-2-hadess@hadess.net>
References: <20240805140840.1606239-2-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7521173863829911765==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=876731

---Test result---

Test Summary:
CheckPatch                    PASS      3.58 seconds
GitLint                       FAIL      3.12 seconds
BuildEll                      PASS      24.61 seconds
BluezMake                     PASS      1794.29 seconds
MakeCheck                     PASS      13.96 seconds
MakeDistcheck                 PASS      179.69 seconds
CheckValgrind                 PASS      255.36 seconds
CheckSmatch                   PASS      357.62 seconds
bluezmakeextell               PASS      120.81 seconds
IncrementalBuild              PASS      13591.94 seconds
ScanBuild                     PASS      1074.61 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,1/8] sdp: Ensure size doesn't overflow

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
4: B1 Line exceeds max length (160>80): "bluez-5.77/lib/sdp.c:1685:2: tainted_data_argument: The check "sent < size" contains the tainted expression "sent" which causes "size" to be considered tainted."
5: B1 Line exceeds max length (142>80): "bluez-5.77/lib/sdp.c:1686:3: overflow: The expression "size - sent" is deemed overflowed because at least one of its arguments has overflowed."
6: B1 Line exceeds max length (152>80): "bluez-5.77/lib/sdp.c:1686:3: overflow_sink: "size - sent", which might have underflowed, is passed to "send(session->sock, buf + sent, size - sent, 0)"."
8: B3 Line contains hard tab characters (\t): "1685|		while (sent < size) {"
9: B3 Line contains hard tab characters (\t): "1686|->			int n = send(session->sock, buf + sent, size - sent, 0);"
10: B3 Line contains hard tab characters (\t): "1687|			if (n < 0)"
11: B3 Line contains hard tab characters (\t): "1688|				return -1;"
[BlueZ,2/8] tools/isotest: Ensure ret doesn't overflow

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
4: B1 Line exceeds max length (165>80): "bluez-5.77/tools/isotest.c:778:2: tainted_data_argument: The check "ret < count" contains the tainted expression "ret" which causes "count" to be considered tainted."
5: B1 Line exceeds max length (147>80): "bluez-5.77/tools/isotest.c:779:3: overflow: The expression "count - ret" is deemed overflowed because at least one of its arguments has overflowed."
6: B1 Line exceeds max length (237>80): "bluez-5.77/tools/isotest.c:779:3: overflow_sink: "count - ret", which might have underflowed, is passed to "read(fd, buf + ret, count - ret)". [Note: The source code implementation of the function has been overridden by a builtin model.]"
8: B3 Line contains hard tab characters (\t): "778|	while (ret < count) {"
9: B3 Line contains hard tab characters (\t): "779|->		len = read(fd, buf + ret, count - ret);"
10: B3 Line contains hard tab characters (\t): "780|		if (len < 0)"
11: B3 Line contains hard tab characters (\t): "781|			return -errno;"
[BlueZ,3/8] health: mcap: Ensure sent doesn't overflow

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
4: B1 Line exceeds max length (172>80): "bluez-5.77/profiles/health/mcap.c:390:2: tainted_data_argument: The check "sent < size" contains the tainted expression "sent" which causes "size" to be considered tainted."
5: B1 Line exceeds max length (154>80): "bluez-5.77/profiles/health/mcap.c:391:3: overflow: The expression "size - sent" is deemed overflowed because at least one of its arguments has overflowed."
6: B1 Line exceeds max length (155>80): "bluez-5.77/profiles/health/mcap.c:391:3: overflow_sink: "size - sent", which might have underflowed, is passed to "write(sock, buf_b + sent, size - sent)"."
8: B3 Line contains hard tab characters (\t): "390|	while (sent < size) {"
9: B3 Line contains hard tab characters (\t): "391|->		int n = write(sock, buf_b + sent, size - sent);"
10: B3 Line contains hard tab characters (\t): "392|		if (n < 0)"
11: B3 Line contains hard tab characters (\t): "393|			return -1;"
[BlueZ,4/8] shared/tester: Add early failure check

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
7: B1 Line exceeds max length (107>80): "bluez-5.77/src/shared/tester.c:946:2: return_constant: Function call "io_send(io, iov, 1)" may return -107."
8: B1 Line exceeds max length (123>80): "bluez-5.77/src/shared/tester.c:946:2: assignment: Assigning: "len" = "io_send(io, iov, 1)". The value of "len" is now -107."
9: B1 Line exceeds max length (258>80): "bluez-5.77/src/shared/tester.c:948:2: overrun-buffer-arg: Calling "tester_monitor" with "iov->iov_base" and "len" is suspicious because of the very large index, 18446744073709551509. The index may be due to a negative parameter being interpreted as unsigned."
10: B3 Line contains hard tab characters (\t): "946|	len = io_send(io, iov, 1);"
12: B3 Line contains hard tab characters (\t): "948|->	tester_monitor('<', 0x0004, 0x0000, iov->iov_base, len);"
14: B3 Line contains hard tab characters (\t): "950|	g_assert_cmpint(len, ==, iov->iov_len);"
[BlueZ,5/8] mesh: Fix possible integer overflow

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
4: B1 Line exceeds max length (120>80): "bluez-5.77/mesh/net.c:3164:4: cast_overflow: Truncation due to cast operation on "msg->len - seg_off" from 32 to 8 bits."
5: B1 Line exceeds max length (95>80): "bluez-5.77/mesh/net.c:3164:4: overflow_assign: "seg_len" is assigned from "msg->len - seg_off"."
6: B1 Line exceeds max length (306>80): "bluez-5.77/mesh/net.c:3178:2: overflow_sink: "seg_len", which might have overflowed, is passed to "mesh_crypto_packet_build(false, msg->ttl, seq_num, msg->src, msg->remote, 0, msg->segmented, msg->key_aid, msg->szmic, false, msg->seqZero, segO, segN, msg->buf + seg_off, seg_len, packet + 1, &packet_len)"."
8: B3 Line contains hard tab characters (\t): "3177|		/* TODO: Are we RXing on an LPN's behalf? Then set RLY bit */"
9: B3 Line contains hard tab characters (\t): "3178|->		if (!mesh_crypto_packet_build(false, msg->ttl, seq_num, msg->src,"
10: B3 Line contains hard tab characters (\t): "3179|						msg->remote, 0, msg->segmented,"
11: B3 Line contains hard tab characters (\t): "3180|						msg->key_aid, msg->szmic, false,"
[BlueZ,6/8] shared/gatt-db: Fix possible buffer overrun

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
13: B1 Line exceeds max length (152>80): "bluez-5.77/src/shared/gatt-db.c:612:2: assignment: Assigning: "len" = "uuid_to_le(uuid, value)". The value of "len" is now between 0 and 31 (inclusive)."
14: B1 Line exceeds max length (206>80): "bluez-5.77/src/shared/gatt-db.c:614:2: overrun-buffer-arg: Overrunning array "value" of 16 bytes by passing it to a function which accesses it at byte offset 30 using argument "len" (which evaluates to 31)."
15: B3 Line contains hard tab characters (\t): "612|	len = uuid_to_le(uuid, value);"
17: B3 Line contains hard tab characters (\t): "614|->	service->attributes[0] = new_attribute(service, handle, type, value,"
18: B3 Line contains hard tab characters (\t): "615|									len);"
19: B3 Line contains hard tab characters (\t): "616|	if (!service->attributes[0]) {"
[BlueZ,7/8] shared/btsnoop: Avoid underflowing toread variable

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
4: B1 Line exceeds max length (136>80): "bluez-5.77/src/shared/btsnoop.c:556:3: underflow: The decrement operator on the unsigned variable "toread" might result in an underflow."
5: B1 Line exceeds max length (236>80): "bluez-5.77/src/shared/btsnoop.c:572:2: overflow_sink: "toread", which might have underflowed, is passed to "read(btsnoop->fd, data, toread)". [Note: The source code implementation of the function has been overridden by a builtin model.]"
6: B3 Line contains hard tab characters (\t): "570|	}"
8: B3 Line contains hard tab characters (\t): "572|->	len = read(btsnoop->fd, data, toread);"
9: B3 Line contains hard tab characters (\t): "573|	if (len < 0) {"
10: B3 Line contains hard tab characters (\t): "574|		btsnoop->aborted = true;"
[BlueZ,8/8] monitor: Check for possible integer underflow

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
4: B1 Line exceeds max length (205>80): "bluez-5.77/monitor/control.c:1094:2: tainted_data_return: Called function "recv(data->fd, data->buf + data->offset, 1490UL - data->offset, MSG_DONTWAIT)", and a possible return value may be less than zero."
5: B1 Line exceeds max length (144>80): "bluez-5.77/monitor/control.c:1094:2: assign: Assigning: "len" = "recv(data->fd, data->buf + data->offset, 1490UL - data->offset, MSG_DONTWAIT)"."
6: B1 Line exceeds max length (119>80): "bluez-5.77/monitor/control.c:1099:2: overflow: The expression "data->offset" is considered to have possibly overflowed."
7: B1 Line exceeds max length (165>80): "bluez-5.77/monitor/control.c:1115:3: overflow: The expression "data->offset -= pktlen + 6" is deemed overflowed because at least one of its arguments has overflowed."
8: B1 Line exceeds max length (265>80): "bluez-5.77/monitor/control.c:1118:4: overflow_sink: "data->offset", which might have underflowed, is passed to "memmove(data->buf, data->buf + 6 + pktlen, data->offset)". [Note: The source code implementation of the function has been overridden by a builtin model.]"
10: B3 Line contains hard tab characters (\t): "1117|			if (data->offset > 0)"
11: B3 Line contains hard tab characters (\t): "1118|->				memmove(data->buf, data->buf + MGMT_HDR_SIZE + pktlen,"
12: B3 Line contains hard tab characters (\t): "1119|									data->offset);"
13: B3 Line contains hard tab characters (\t): "1120|		}"


---
Regards,
Linux Bluetooth


--===============7521173863829911765==--
