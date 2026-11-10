Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794349180;
	b=3H+93P16RW/jHO/ML1p8j01GZLcR3EHRTQmzQjAx+RAPzfIyAgeSNkB4InxbkaZXlKzR
	 TwRXJL6URKKlGC1gdJF8KvMhJUXL6teoOajr0H8I0jc1RxmL7tZDDb4A4LCxBbDnX7zpP
	 Jf5rtDCzDnqL4mubshjTR3e2LiximH0qqEVpvxwJDyB7YUouipViF1CbezQgzPSA3bePn
	 Xnudqz5CM+oPzN0EaO2tPH69LFEKM/5Ds/OukMeRP263fWsGdpExrTi/knQbOGuF0ejw+
	 dmrvgAJjg7Xq9hFfnytK+cvc2LdCo6GR/gKjMWjnb8JFp8+vShbc3CQ8VHPiD0tHQoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794349180;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vcPsqZTsKjA650KAhNuOyoT8omvFwcB+Bve7nXe/LBE=;
	b=EVDUAHXBQGT4kg6csuRx1c1kl6xgGqdiAdZaNV0X9heUjPoCQmk2sl6CicXsU0rQ7CKD
	 6NxO4pdmVtHDyD/6oZ3arsTLpE3IFeFRInKSnYWCFj+F4Ob4jJpZnEDkIICFYgxipE5/+
	 SBKDMdAN8avdMHME05ERSWoDwyeKW3DeXBG/gEAnxhaiJV6WJF5MhOZQNwhhDGHTVqdIY
	 T8bggAJYjpv1zDRYXd9n6QgGlBbaJpA0BUzlGa7Juny9X9iLerYtkR1u3yUkDFbQFz9xc
	 6Yu08hySFZ04Ey8bKpOmFIzc6o0mlDCnshl+yoB/8LyyoLE2VB/pkhhEiV3UsGbICXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bwX4sJLa;
	arc=none smtp.remote-ip=209.85.217.48
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6D1606A326
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 22:19:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B6D1606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bwX4sJLa
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-7d2e1abf3eeso1996307137.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 14:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794349178; x=1794953978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vcPsqZTsKjA650KAhNuOyoT8omvFwcB+Bve7nXe/LBE=;
        b=bwX4sJLafuk01S+k4QkeyqxRdDyDt8H5FBMVvd33xmqM79I+UkUsedXrTvW+UYexkF
         Af6lvGPOg6yb+WGUvDIDydsf+stZGYGfckMS7pvbxhkYmlJOLD6Kl6H/igt2ogOa52n6
         GZrglGjxozLGRey+G23EfTZSXA/IzybJlcem1nkbl88FB1GlfzW228hxTOqm3kbpoETk
         lb0G6V7SBRseUu2u1p2HnG3rsjvPaH6TUW1ZVIOvESpjFU6uDJDJY2J2VxIB0QXOxNs0
         Vrsk0l8fPFcwRzxRbs++WnSsLXdCJf9FROYu0a9YTH2CMufJUKDt0yPko+Lmep5oq85E
         rexg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794349178; x=1794953978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=vcPsqZTsKjA650KAhNuOyoT8omvFwcB+Bve7nXe/LBE=;
        b=Vi/EPuwsg0iLGu2A/q8s0FKqlNtiINS5jhdsf02Dry7d0DV6VSAuGVlw9d9MErzvkT
         vJyJVSqPEoCdjLBux/d+DZF7mZg27bfj634iFq+qekfg+1yZaBBhrUiYbzMXWuDDf4CA
         51oTR3wQuUc1DVkETBAIdO3q6DVFKduNZxi/i/wM6cJQ4rU41smlaitPrlimuQhnFpwC
         G5Da5HCdIKVwE1eqoV7cJOXZHEqc6j/iHYFGoab3Ijfehf/ljT1o6pmbcn3Kq4lwigiS
         Nx8bML5VEI3hfklnOtKnZYp79T9SESzs0Dzl7yj//Dk5YTJynpLLFeYZLH2avhsImfZH
         ngXw==
X-Gm-Message-State: APuU4Z/geozncmdGr8p4yemeGAr7J3smwgVlOjEYPr12vxzOQsKq5Na+
	UkJqq5ufyORl74hoDPBIuhsn395W1/SA5NQ2A745jjNGMB33c3rnHsZEBv/AGg==
X-Gm-Gg: AYBFou330DXw8RpsGni0m5UZ9zsH8YdMHNacnl0XznjdmbrAh2F/1nmc37kJPQqhf+D
	zZnDcmtR8C5GE1w+NpS7WVpHBBIrMq/LiWvt8V1aIXEUxc1XBgW/HLuE+0mPsPbvFhMWt9oSosR
	+i9MMFUY45HMOrshUEqIBxDrfkDHJSPls8s13Iyvxq12w5psUJfjpZBUV0yw4q8FPSWi0ngNjoD
	xblLsum8fYlWfqOKPybENJs2JkktMqNKPFmBKovtsKHvnjmDAY3LZklT6WJJ5qUT1js60pQ0EBr
	CFirmyx7ulGmXiMxPI4aMHqAM6tjisZjehTNDfqbfJdrBQIbQC27yI3b9YgZxfYPEVIMOD2yxe9
	4g5MhkcUt+n/MvLeqrb0Ls+MQeqtYFYEJhaVWv8wtKkoyFQrdD9YSI77U74tBjWdXR276OSIAQJ
	JGK6Reha8Um4FoNXCABQKvqq13Z3LLbkHoKuRWEaVtOmKSW0sac1mE+nIFQcFNLog0p0DvSRLE/
	BA2a1DOHtNXsUQIigX9tE2WBF+buXkLE4vWoEH0Rph1EmZH6ZpgsOD+/+ae4JJGMXoqztx7cy9F
	WeIs47M8a4j9cxlwJSiNqTsDe+mz6XCVELfyEonZxobAaUjzN1J+GkUXuzF7N6RSyvLIKbZiHJP
	LLHeGmOWSRZEE/d3HB+pltRyJbaB316mmaq5chtyqO53buzBotMBJIcOj2beTXOPa9edQ00uiVY
	pi8aM=
X-Received: by 2002:a05:6102:6e89:b0:7d2:fdb9:b189 with SMTP id ada2fe7eead31-7d494ee3097mr227010137.34.1794349178300;
        Tue, 10 Nov 2026 14:19:38 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee0c58ed55sm2605244e0c.5.2026.11.10.14.19.37
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 14:19:37 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 6/8] test: functional: Cover disabling one ASE of a shared owner
Date: Tue, 10 Nov 2026 17:19:15 -0500
Message-ID: <3fc5acb871f235254e0516b2a08d8b867de6d5e7.1794349049.git.luiz.von.dentz@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794349049.git.luiz.von.dentz@intel.com>
References: <cover.1794349049.git.luiz.von.dentz@intel.com>
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

Have the initiator acquire the transport of the Source ASE without
desynchronizing, so both ASEs are enabled together and bluetoothctl on
the acceptor acquires one transport, as an audio server would, its link
sharing the owner. Then desynchronize and release the transport to
disable the Source ASE alone, as when a microphone is closed while media
keeps playing, and check that the transport of the Sink ASE stays
active, as its ASE keeps streaming.

Assisted-by: Claude:claude-opus-5-5
---
 test/functional/test_bap.py | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/test/functional/test_bap.py b/test/functional/test_bap.py
index 56205a61e61d..b76417824f97 100644
--- a/test/functional/test_bap.py
+++ b/test/functional/test_bap.py
@@ -801,6 +801,40 @@ def test_bap_unicast_duplex_switch(duplex_hosts, acceptor_cis_count):
     expect_all(acceptor, [ACQUIRED, f"Transport {source} State: active"])
 
 
+@duplex_host_config
+def test_bap_unicast_duplex_disable_one(duplex_hosts):
+    initiator, acceptor, to_sink, from_source, sink, source = duplex_hosts
+
+    # Acquire the transport of the Source ASE without desynchronizing, so
+    # both ASEs are enabled together and bluetoothctl on the acceptor, as an
+    # audio server would, acquires one transport, whose link shares the
+    # owner
+    initiator.send(f"transport.acquire {from_source}\n")
+    expect_all(initiator, [ACQUIRED, f"Transport {from_source} State: active"])
+    expect_all(
+        acceptor,
+        [
+            ACQUIRED,
+            f"Transport {source} State: active",
+            f"Transport {sink} State: active",
+        ],
+    )
+
+    # Disable the Source ASE alone, as when a microphone is closed while
+    # media keeps playing
+    desync(initiator, to_sink, from_source)
+    initiator.send(f"transport.release {from_source}\n")
+    expect_all(
+        initiator, ["Release successful", f"Transport {from_source} State: idle"]
+    )
+    expect_all(acceptor, [f"Transport {source} State: idle"])
+
+    # The Sink ASE keeps streaming, so its transport has to stay active
+    time.sleep(2)
+    state = show_state(acceptor, sink)
+    assert state == "active", f"{sink} {state} while its ASE keeps streaming"
+
+
 # Broadcast code used by the broadcast scripts, see BCAST_CODE in
 # client/player.c
 BCAST_CODE = (
-- 
2.56.0

