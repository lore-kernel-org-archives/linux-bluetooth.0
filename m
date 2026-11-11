Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794414345;
	b=1Ysir73TTLhv3vMRrAnglk5nnzDOK71cVkF2Oy5pxOwJg9A04CJF5Yjsj0LJcop4f/N3
	 ta4pYSFxqnpNkA8dGIRZMnOgcqA/gaGgk2ODa1gYsEchZ/n/sByPWPasJZmdTLKowIFh+
	 jxC8CqFJR2ayZloIYIpgY0jL8J9kzP61/32/MtZZnHcUAw6rhG0XOnwJDKyezk/3hy47I
	 dDd5bYQ/dGIEX5TMcs9SC6nM6rEfexAZ1N+2sIQlWKasO8qZTW3ngW2asbIeyOU4YNsRC
	 DU7U+g2xICdpDDUDW0+woNVPGqMtBrOMOIVIszAC1m174EJFt9lGIOZw1Qz0OSHsp/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794414345;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8UWQwwIPzi1eSYvirGUpwcO4+98p/xAucINZYWnrkug=;
	b=3unogLDdt9bqSh4Q95ZQ7hCpjTlQDF0FkRNXRcu5Z5Stxln9xTgmgfi5Cb7P++5m8SWc
	 RoNpz+96ROqA1RK5EiP5XJ7JISQRZClYumeBE8KmTqlctcHZqxk0WQthHkMJQKtjRmc4P
	 IDeWeZG6VWY/OV0MA0hU6w/q3ObjbXtQTu4LKD7dd6szyY0XefcEX/c/EVN9WObjDfUa5
	 Er5aADIFtcQCg4Aj1qO75CBguY/74gx+fJX3ShVFAn5hbtn10D4CFtOJMebkgOAi7lanv
	 wDsJ88tznE7TXlCXHoW/QYCc5oltdGqPTKqcYFgoh8PZEluskezaE5x2WnwlrgjZODg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="rQ/RyRYm";
	arc=none smtp.remote-ip=209.85.222.42
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B880C606A324
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 16:25:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B880C606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rQ/RyRYm
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-97ccbba8e86so898137241.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 08:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794414343; x=1795019143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8UWQwwIPzi1eSYvirGUpwcO4+98p/xAucINZYWnrkug=;
        b=rQ/RyRYmiWWfTUZY3oMYMpAhu29kPPipXLd9Zpx1j2MpRdWqPY0X/hN9DwIU39QI7f
         ywASsfZz/9pWhdGzw+PVrt7l14I/GJspgkendRXyu1bR8glWuu9I+bKEMgBozEoeqx8e
         7HkRRedvJV73oiqn57dzYRUXsIdHr6q60HQCHeSe7wUhyE/47/BUWqgkLuRbSYNlnee3
         nFXz8EH2e+6MeN5cTfdVW00bfVgKNAZBbB5gGixmnEFwq4eQX0MklfBC9OJCi7GAuETi
         alq4pdDeST4UUMAtbx6lVcP9sE3IQDEKzAuHUTcbJV/LXDIlN6p8zVZXg4RHPXi+701r
         DsMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794414343; x=1795019143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=8UWQwwIPzi1eSYvirGUpwcO4+98p/xAucINZYWnrkug=;
        b=n3bTR4k/3fvfwXrBNHqQOR4PwznT3FkhrjA69v2cSAmnxbvITtx6fxASeat44qoXp9
         oO2IeYJJ2BW8QHXrPojb1jwrY7aQnmVDqoDVZBJl4favM3kuVPyMEKlJTrl3NsqTH5/s
         G4k2Oq+kuv0/BmoPP4G7krdhdYr/6ffomfzF4r00q/MNQfZnTsxIVujldvb9lWGO7Gd9
         M8XajwLx+Y6a0WcwwwaQCPcOUYW8af7Kar9OptfsZFOe4uWiGx+n/fHq6Y0fX6IwzlLO
         ER/n7VbR03DrlRK/susg+sYJa/h/iBrUuewsK4RagpUN+Bu15wGdkBcZWOG0fEPCwtrz
         CpjA==
X-Gm-Message-State: APuU4Z82NS8NDw8ZW996E8oLG0lNuB2TbAUZB1MD9js/MsXzqd1934gt
	D7QsuGTUbVc0EXpO6xeX++ondOK7XSkFOvbSbuIxmsCieBJVz5vdTjRrwdotpg==
X-Gm-Gg: AYBFou3wokyaWGSorXsFMPWh72YOfHCrwXbX7J4cfyZ4x0JEqM2HibVySUAqhP4u7mx
	ZFreKXtfc8vcFUqYAi7pqDDwQ0c0G3l7hVMUoqFrspHfRSK8OyNVRhHYj/gIRJy5/Xd2g+86UgX
	+bJWxL9b8p4kNmbfhjeQZPf4WRhe8vL7S6xRTbPLmN87m1WgCtQVvXuqs41QGAiOnmGzKca7Q59
	nJ+HWbPTsCsqmrbUtvMfjlRfGxrtngP5zo3PgJX9JzgbaWIWz9CsWZluGAS+EjOG859YL3yefSQ
	GFh32VLQcVgeStCvvi04SpEllwA1l0D6xjGyRJtPxShz95ZQdpOBEHyzy9eBzBd3flB3TXvp8cS
	JEzg4Rq4N1jpZsiHlh6Hdh14tRMZVxOGTAMNIz9ZAp1M2Rnyu8Yw+GwCsQB55eguoCTkbOaGgnE
	VCidbVyXUfKJGc43xU+eHU1viqjiHKSaLyEnCmcaeg2v0r4WI34AQkgRh2pMxY8nDGMpQp7A2Hm
	6PqtWSuvRx2ClxWRRXGUYccG38b99KsgGhthJNwY2LeDktk6RYWcUD8oHpWJW7czy7SG/leiEts
	tS3P8F9B5Birnpe5u8fozNd9GaXVrttvTMVbOOOLtXE1GJw0Vzb52O84OkIQ/hlqc9prLEOMDbB
	prKjdhmROjGMaIdAGWM5e/Xaw9uSWpo+kneyKq+BocxUZ4x1K+JXF65S6MhJUDlrQfp/5Aqcrnv
	aWbi0=
X-Received: by 2002:a05:6102:50a9:b0:7c0:1d48:b2a2 with SMTP id ada2fe7eead31-7d50610d956mr937509137.31.1794414343576;
        Wed, 11 Nov 2026 08:25:43 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99c200004e7sm4269659241.3.2026.11.11.08.25.41
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:25:41 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/6] shared/bap: Update the remote PAC when reusing an ASE
Date: Wed, 11 Nov 2026 11:25:18 -0500
Message-ID: <1c41577456acc2457f3c5177d9380eda950649f0.1794413813.git.luiz.von.dentz@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794413813.git.luiz.von.dentz@intel.com>
References: <cover.1794413813.git.luiz.von.dentz@intel.com>
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

