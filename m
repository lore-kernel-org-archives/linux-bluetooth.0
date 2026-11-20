Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795213608;
	b=QME038n4BEMmqK9amxXl+JoMGVXs3ieGQn9Q6kNAHLuws8GkWc/Ud1J6C84nPnfFIur5
	 PdetYQ7uAskoIvAQzIaEUxAwhDHAhjqeE8jqEeij9gGisM1dvAoOXRy+8CQ9pkz22y7ie
	 Grhsxmly1eSRDtH+dPpRNJK68L56a+HSwjuk0JL40adeXofvKFzYw/KtDG27sWAibp03B
	 ci2BAQKWe+gomehgCvRilYjaAGImTZw8a/+GBaIPgTDjasb6Phz5dNfaBbZpHBqHWabVi
	 jhRSHoueYiX+lPmmnLxhsy93WzXqbPNwMqMURq2GTyj70bUKyO0/zI4TQjez3L2oy1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795213608;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=OGaRvxM0ykqLA2aJKjIV+Bsk8wS8XhthmVgtUk6KBts=;
	b=Y61SYGidgl1zFacHAmxNc86dlAZxZ5DdEgFQvcP2Bni1Sls7HMTZo9ciOXUejU1ImL+X
	 0Kp1NXTFf0wnIVjtg4/n+DCvYcCeSKaRtHP8X80fIrqM5TVg1bHRMVp0/ow8VHpiwFB9m
	 XVGxD7JG2ql1usmYVMZV8eq5SvTmeYjcS58IJEMsPnUtcDKJ2M4lXDzHUH62HFXZ1i9L/
	 r01Llc94YDGC2WxbOiIjjh1OMnnL8mQldx9jr4EXTTiOSOszlOOTsnRkktUnrwE68Eh/U
	 M5OZgjEGfkrM5Dq0tWTw06Wj40LD9/Kebtx3MoeJaedlVS2JJfqJAeuC7Xs+N58fomg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dfWj+PsL;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D6B606A69C
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 22:26:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76D6B606A69C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dfWj+PsL
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4bb66245c51so856785e9.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 14:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795213603; x=1795818403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OGaRvxM0ykqLA2aJKjIV+Bsk8wS8XhthmVgtUk6KBts=;
        b=dfWj+PsLOsG962a95P3IBNktlLHkN1oGDEM/aul/ubT5iQDDAsMkka4/u/21ptV9Zx
         7CZTgv4mdaIP3Hi3nyOhE7ixhIuc4mcrKLG4yxpH/omgQOqyJUER+Wk7spvyHRjTJiwo
         PesbbZklE/0qo9+5edR/T0AHKVhdk2MS1fqLjrjYCALJPWkRWbUxOT18Y5Irz+ax2VUG
         m1kM3M9tgfBuSxRKGZOJgfwdDXDIFjkFf2ef6QACjzAjHKfGb1F/bPH6UE9vYByDK0Ob
         REKIkoQb+7NiVvh/HNsQxXgMcbRSuQ5dpu7vmfXHVbzkhsneApOwu5c3pmtg7g2ot2Sm
         kkUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795213603; x=1795818403;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OGaRvxM0ykqLA2aJKjIV+Bsk8wS8XhthmVgtUk6KBts=;
        b=eI9uak3CAZh0b0ZpZ+pSkAljb8P+DTj4x2cfb7D4eiGsxGDRrCkOXtnAE7bqqqp52L
         uALet3sQtRNilycY1K9viUEPRNN32GDX3f1sMGjlU0XCSNyyRxWDCnpruTy04urlCxTI
         o89xGwYp3fHb/Fc17QBMW8gYksh8aPvs8Ulmm4hkI2zHfGv7wAhe4kYkttwmrFLxsgJY
         gurQytWNxG/UK+u75BrTlv+W9bfUqUSiouz9YkqAvxdpe0e+NmmPOg5cJjPfvhCdmglR
         ZosWYz2SIGKjr/IHWDT2v1RLsyng95nfxIpeiz9/ZA7+joePjMeBp8mCDEiF5nZ3VJVo
         atVw==
X-Gm-Message-State: APuU4Z8UvYUPScvWlpof/6g6t3HALnTkeN7+NwJSZIbn40gBDFryafjM
	fyWajuyIWw0oWHS3B6IXpCh5N6gH2xLsdffwsS8KTgU04PPb9AfGQ9lmcrIJ+A==
X-Gm-Gg: AYBFou01w3KN5qtvWMOCG4r40oeRWqSleWIU8l2xs6DLCEanM8q60BJ29bXIXIBLhXO
	GAtXqjIhA2cZ9teblhwtVHYTKgjF7fV88+sQekm05uvcAaW8t5z/7A7XKgW6bOlLRTtARs/P8l8
	MDUGBlyiNGXq0nze3IqIpehcdqReSoXDtLaO9itisSPpF8vRKXjcl/nA7qTf63wbXzcUBvxTx31
	sOSyD+waVf8kO9CVy207Fne5TRHYsiLAFsg8v7/VEr/Yy0V0uaPRG613Y97v37Z0qUWbzM52EB3
	krCV5aHjBxkXEl72laWNbDyQTMQtG2J6Tr5O5HXdLZZ+OXpfXq+0qasQPJk2jhS8z/k5aLMMkUN
	l2T1F1Tlc7+eoJHWGWswzfr6EdyCk/JTWYEOgB+8QDDvH2pAimYMb+fIsPGF2KBwQvdIpLfQ8Fw
	AQgCGtIdSqNqD1GHkZtRcQ/Ud61XuLGP8FkDvwc2dd9SpQ4IFECs/6b4aSErsEMO2DsqW75LlcK
	nGdMin9CVtCu5iNQBSI4zNLlMLQDtJ8y26t+groEv5sD0lYX9slVLgcD+5emOPUA5VktlWeSrDY
	9Vxjt9mKLjh/R1/WBnARgL/UsrIOZ0mz05dVcU6ogOJf382YmsRd4ECMYsr3IiM+h5TJew==
X-Received: by 2002:a05:600c:21ca:b0:4bb:68ed:a356 with SMTP id 5b1f17b1804b1-4bb887ec919mr72931885e9.1.1795213602610;
        Fri, 20 Nov 2026 14:26:42 -0800 (PST)
Received: from schinder.fritz.box ([2001:9e8:b39e:f00:df5c:2a51:ff8a:45b1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb90660cb4sm23698785e9.2.2026.11.20.14.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 14:26:42 -0800 (PST)
From: Roland Schober <rolandschober1968@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Roland Schober <rolandschober1968@gmail.com>
Subject: [PATCH BlueZ 0/5] monitor: Fix reads beyond advertising data
Date: Fri, 20 Nov 2026 23:26:19 +0100
Message-ID: <20261120222624.150321-1-rolandschober1968@gmail.com>
X-Mailer: git-send-email 2.47.3
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

print_eir() and the decoders it calls take advertising data, which a
remote device chooses. This series fixes five places where btmon reads
or writes beyond that data, or decodes it from the wrong place:

 - a Shortened Local Name, Complete Local Name or Broadcast Name of
   240 or more octets is copied beyond a buffer of 239 octets,
 - the Flags and the Security Manager OOB Flags are read from an AD
   structure which has no data,
 - an Unprovisioned Device Beacon of 18 octets is decoded although its
   OOB Information lacks an octet,
 - the Apple identifier is printed as a string which nothing
   terminates,
 - a Public Broadcast Announcement is reported as invalid when it is
   well formed, and decoded from uninitialised variables when it is
   too short.

Copilot found the first one in its review of "monitor: Decode Periodic
Advertising with Responses" v4, whose new decoders hand advertising
data to print_eir() as well. The bug is older than that series and
can be reached without it, e.g. by an LE Periodic Advertising Report,
so the fixes come as a series of their own. A v5 of the decoding
series will follow on top of it.

The others were found by feeding print_eir() one AD structure of every
type with every length up to 250 octets, in a buffer of exactly that
size with AddressSanitizer, and by review. The same test passes with
the series applied. The reads of patches 1 to 4 show there as
AddressSanitizer reports; patch 5 was tested with hand-made btsnoop
traces only.

Roland Schober (5):
  monitor: Fix overflow of the name buffer in print_eir
  monitor: Fix reading Flags beyond empty AD structures
  monitor: Fix reading beyond a short Mesh Beacon
  monitor: Fix reading beyond the Apple manufacturer data
  monitor: Fix decoding of Public Broadcast Announcements

 monitor/packet.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

-- 
2.47.3

