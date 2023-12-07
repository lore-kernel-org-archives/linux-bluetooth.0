Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SXRaP61u"
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEBB3E0
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Dec 2023 10:47:27 -0800 (PST)
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-58d06bfadf8so572661eaf.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 Dec 2023 10:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701974846; x=1702579646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=J0DMQvM0X0TWe5eEVe4BlNvp79zys3iQHTwQKtKgndg=;
        b=SXRaP61usOFFDb9PSE0cuzrj9ffBcbmcc/KhKPES0uoKULUmumvYyKDZ8u+qhxrUnk
         lRG7EEkJsC/Ta5OsztKkAmxK6xNfxJDy/OmCdKhHKumUXuAc+ZQqLfBG+RyXg5kgElat
         91nwtvnErL7NLGT9BUt0tifAS8osC9/S4x4hEs/Uy73BWeVbURWGi0UD2uHuR6k+nkXv
         pq5sj5h+Rc5ICMVFV2fyuz7WNCzlcg2H/1+FIPdrYD3h0TRwmQiUDOnJ4EfpNBbxPAE4
         uKeDmUpvbGXGkGx76NuMw8+0LmNGvxSwc+ck3/5v9Rd4JZ/ztbhi2bTns2BTnuuuagZm
         mktA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701974846; x=1702579646;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J0DMQvM0X0TWe5eEVe4BlNvp79zys3iQHTwQKtKgndg=;
        b=XjaUYb/YZQV/oA7s19G0fVnstid2ikRUcL1eLmb3jSlQO0jAYj+oyGUyn72nSa9K2A
         2T/cIv4RYfgFf0WYAP8lMhQhILP2ZiXXR4H1inXises2Yv61dQYBivR+wjyMY1AC3KX1
         3uT+DrH9z3VORgcXjJTbEigahQqrXEilth/F9o9fWufEx/hbiF35QhRQj0mUOYw0WIqd
         +W8RFIH9it/aoj0bKE3UV+X7hPeOr5Sv/GoTqtCvQ2VYMaRLz4mvbxUB1XDyESuO8n0V
         wHYw9Be1tvhxx6gg07HO47mPq1BivE5LInjNneIl25N/N03pHUX1EYnd1KXKEo4Ti6S/
         ovVQ==
X-Gm-Message-State: AOJu0YzBz1ANRIZYvuIc8fre64rTPH4xWd7Ioj81zwxb3C3MopkjSv9u
	33xoQk2sksKAGkJXVmSinBDEgy05pNo=
X-Google-Smtp-Source: AGHT+IEPp5nWOneR8ijDnxQ1klIkuZj5j3akRSDGzba5S0koChvR6UyKle/5UC7pwzPiqZEpv/36YA==
X-Received: by 2002:a05:6820:2a14:b0:590:77c3:9d7f with SMTP id dr20-20020a0568202a1400b0059077c39d7fmr882081oob.16.1701974845962;
        Thu, 07 Dec 2023 10:47:25 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id v10-20020a4a244a000000b00581fc1af0a7sm29889oov.28.2023.12.07.10.47.24
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 10:47:24 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] client/player: Fix not prompting all parameter on endpoint.register
Date: Thu,  7 Dec 2023 13:47:23 -0500
Message-ID: <20231207184723.3862261-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When Auto Accept is not enable not all parameters are requested.
---
 client/player.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/client/player.c b/client/player.c
index 4673d2efece8..4d49602c70d7 100644
--- a/client/player.c
+++ b/client/player.c
@@ -2813,17 +2813,13 @@ static void endpoint_auto_accept(const char *input, void *user_data)
 		return;
 	} else if (!strcasecmp(input, "n") || !strcasecmp(input, "no")) {
 		ep->auto_accept = false;
+		bt_shell_prompt_input(ep->path, "Max Transports (auto/value):",
+						endpoint_max_transports, ep);
+		return;
 	} else {
 		bt_shell_printf("Invalid input for Auto Accept\n");
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
-
-	if (ep->broadcast)
-		bt_shell_prompt_input(ep->path, "BIG (auto/value):",
-					endpoint_iso_group, ep);
-	else
-		bt_shell_prompt_input(ep->path, "CIG (auto/value):",
-					endpoint_iso_group, ep);
 }
 
 static void endpoint_set_metadata(const char *input, void *user_data)
-- 
2.43.0

