Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794515867;
	b=fdeoKbhhAesRT/c9IFGHaFxPUERCAET+qYNHlTe3pt20UlsK/ws3aSomhE0aZEkM9g0O
	 7cTPj3FT/86DYpbr27wMF1P2k8+XpNEDPv+kJiIg6L+6kQZ1mfcUCSCAN7gXWThz3f0iD
	 B4OacczgqVraKJhwum5cQCZYCS7g8IlvoFWNW1DM/npIOjq2oAffuW9tICDpMCo8wYzQd
	 3zB7uaax5GPz8962o4z9PI5qR8DG2ZfSxqZ/a/XgXFiiu40XaVhpAVqODanQWxAQQJvEu
	 5wFzODyqgkroHA8i9uhhoiavj5xFoowXQroiOcwy/D8Dl02mReFZlxokdB5ejCwPz6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794515867;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8UWQwwIPzi1eSYvirGUpwcO4+98p/xAucINZYWnrkug=;
	b=Y1GE/WB+kmJuGa8mALxT+0xQ4xOrRA8+YAV8XL/x9QzXHSdEKKBuD/JmwAmZfAyso9tJ
	 r+MS50SRfk6Zr5Q2e4loS+wbYeUSQW8PFZPzU7eG4Edo/sZE5Dzqqp4nZ6rigcjZecRvp
	 yndyJJIwqec9d9OTMRP0xTdmLInZp7keUqhTU7a+YiQesZjQNj43xEDx1YX1OkxMlWLEc
	 PSzzUkaOgKLR8jLR5MhKZLOWrIQw4rRc9ZAOs0OV67SeZQT8FX5uMXBu4SP8U2Q+VGkT3
	 aiNFzQtPd0pttkPf7gBLvqq3d1V5VawQYwUA6gxX5R8lDgdTaAaQm8nqxznLCfTC+CA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iq042eGF;
	arc=none smtp.remote-ip=209.85.221.178
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663FC606A323
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 20:37:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 663FC606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iq042eGF
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5ecda93627eso100686e0c.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 12:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794515866; x=1795120666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8UWQwwIPzi1eSYvirGUpwcO4+98p/xAucINZYWnrkug=;
        b=iq042eGFMz3sKLoApiwjD49yt1lAXIvHq5I9TfOJkorw1t9m9xo6LKr27KqFvS5/JT
         4zOlZmxib70BdqmkEsoiAeSW7ksYnDn3qPl9A8060oOhzB+/w0trf+Te+9IrdIsoWN7t
         KnukHLBnwhmKBMVz3KFLKhCvhhO1tH2lzTGIsfVTodMCYjGwzpLQRHqS1/plTZRQYdkq
         U5BeDfm9ypeyvuEbeDA3ausfIKNy/cukdcipiuebHhcfyKCJThG4WTaewEVKHSI2RB2j
         HM4cop64aWjrQ3XxQSVp0Ivy5fD1RO5hm/yzKFC9x8/9Sp2HyFMg7rxcRsWr+6Pl0BCQ
         UM2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794515866; x=1795120666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=8UWQwwIPzi1eSYvirGUpwcO4+98p/xAucINZYWnrkug=;
        b=DOd6VQ2MtTu+20DfpUozaL4BMHkVfFdVrN5WZhOXNzaY+WV1Io45f6qeMWDtAkJfqS
         6mK758Dm/HY+UE313vcSmgHOp+VwZq8GbwC3ItlaTO0UPBU1L2eB3QFwXUc6bES3MGxM
         sH/MKad9VZ/y3HwPZxN6sNkOGB7UFINemM9PvLFTVJgG3OhOxKCh/9/Dgc5g5lbunKfQ
         KeeBRR647jNkXUQE8v2XlEA7TRoCvz2OkV+iPuz2afYSBScjlYyeH3DOZqgO+9sOUzxs
         IgWyZkVHogOEu8alHmlCJFmfwVTwvN5tQ5lnEdV4G7S4j7Clr37TwKM5vpaj9Gu1+h6C
         Nkrg==
X-Gm-Message-State: APuU4Z8p0WTrR9mFvXtThC0E1kA6QuE5WqEwM8NGsVBxDeFV6YNQ6Z/q
	h1+lQvyj6oWidZ6NIHitk7zjzWLvlGOouDXKAoyj+HpP577QhJP3pc6/5hxWpQ==
X-Gm-Gg: AYBFou3PpNn2cICHSl9SqiXzrOLJ+dshGVSZa+L2EgoGu+d82KUrnpQmdIhbI4lVLpG
	IiMWwRlASWRhwiWuSpgVkAPLEsHktrAXA33b3pbPC9kgTTh+pgR6TJBsGa/g1PdaetByw0JusCH
	Vu6xNPYJq9mojb4KRJSq1XG2671jIf57Pn4z7liyyxrfDadMoaumT/alby/+Ji8+YBsJwuIYuY/
	SJczuD7A3oMa2FhuBgHi6BQBS5FV8x3PJRyBaFNzvoqbjIaoeQqr6qQ5rsnBgF4MoTBvNJMcj3N
	HeO1Sgv33/A1GA02R38NnesHS8CbZYk0rYrc754wiwIMu1oW6k5adoBiODkk3yNwLBU3Z0wyMa+
	gotlKY8NTXUznxzwwyeOuBpflQrV2+xbPymosPJpewFjusvSkT4jLkgqScwFbWoyMCkjzGDINJ5
	fPBs4SkXXP4vE5OI7P4Ve2EYrSPnFE1f98BOQgm1aZ9VngXujnM5cz9jYTr0ETmHaveI78kcU1t
	9+I9+ULdU1pOt/PWMflI8lE3o9zQ+ZYqwVXWI43dpHFa/fPgXISRAnvsySU7zHoZqN/F84L+GPd
	x/Forjyq+r4S5Pib4mqxKl+/QOw8lF1I9QHqTpFXnjvz+W2oN4KjRL/nTANgOyhsU8hg3KvCCkr
	hyPc1s5uKiu39NLXgYQgk/zDh5QX49IWvkTr5/EEAn45/1SRVRg9pTsfZ24fk32bmceY3RQUf3S
	ecDgc=
X-Received: by 2002:a05:6122:1d0d:b0:5ec:4112:6839 with SMTP id 71dfb90a1353d-5ee34aa3a38mr111906e0c.15.1794515866301;
        Thu, 12 Nov 2026 12:37:46 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee34bff0d2sm145765e0c.0.2026.11.12.12.37.45
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 12:37:45 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v5 2/6] shared/bap: Update the remote PAC when reusing an ASE
Date: Thu, 12 Nov 2026 15:37:39 -0500
Message-ID: <1c41577456acc2457f3c5177d9380eda950649f0.1794515788.git.luiz.von.dentz@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794515788.git.luiz.von.dentz@intel.com>
References: <cover.1794515788.git.luiz.von.dentz@intel.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

An ASE kept by a stream, e.g. one the server cached after its release,
may be reused for another remote PAC, which replaced the local PAC but
left the stream pointing to the previous remote one. Update it as well,
so that it matches the PAC the ASE is now configured for.

Assisted-by: Claude:claude-opus-5-5
---
 src/shared/bap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index e45d12144acb..4fd4055565f7 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -6975,6 +6975,7 @@ static struct bt_bap_stream *bap_ucast_stream_new(struct bt_bap *bap,
 		 */
 		bap_stream_clear_cfm(stream);
 		stream->lpac = lpac;
+		stream->rpac = rpac;
 		util_iov_free(stream->cc, 1);
 		stream->cc = util_iov_dup(data, 1);
 		stream->need_reconfig = true;
-- 
2.56.0

