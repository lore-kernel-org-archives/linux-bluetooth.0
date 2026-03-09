Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDCB2D23A5
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Mar 2026 04:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773032364; cv=none; b=SjzKexdVCwvohLGUiWJIkfr3dS+Olwz8jyLq49rx1RxUF1CL/pQ3b2GOJJaOPyo6Uwi7b/0GYkeUN0Cv7Uz7Wv6RXlRIzpPq3Zia2FX05KiaTexBSqJEC9ql+3n0DPKhhnoeFBFNjMlUWwvf/WTlQCFkdj7nrKzMM9quRAKtfIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773032364; c=relaxed/simple;
	bh=yNFJVzRpwO6TQe5TXWb22UnwIdnz/zs2/kWMv4Qltck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vj2YHuSsqjR/P2h913CNTlC9HGIO6k5Vb0/2R8Y7WL76dgqaTdRRYg3bvkDGpfexayTrAK+E8ijoSwnzjMt/BpMiHLaWhs9L813hW0sYcEsiR0io2kVQOKziLI1tYlKz43DXk2PV3eAIJmOAb9hY6hfeGOZGibE/BQuDbDjUwAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RIWEvj3X; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RIWEvj3X"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-89a133cdd4aso71912026d6.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 08 Mar 2026 21:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773032362; x=1773637162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DzNBi8a6WYUhidqF4/pppD09hJ6y83Rup3hwYwsa0qI=;
        b=RIWEvj3XaouqGP5WejPOw2K1+5EiLTBfBofb2y/KBqL/XmLsdW2b1GNzqGgdivoqcA
         0Ih1U1h/8U99pTHYwpoX7Jw1iobFwfjqBGGYo0ZTxceL4voFOh5X3KMWa2na7zOBmG1U
         tsMVLNiRPdUiSMoJoKzrM1fngf4CGidhiaiZrihl988NzruQYgnpfbSJ2Ou+dT3GSq4X
         50sO8DQkCO/E8huSX2eJ8GonkO/unjnpLhXKs2Hecc5U7F1ssYcV2SMTGF6GG9I6y+cE
         64q5RMVVzglk7XVmoXCENbojZudHPCGepZN93z7pJUxcXpSEC0NMA7OtSOtHkcBlU/Oo
         M23g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773032362; x=1773637162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DzNBi8a6WYUhidqF4/pppD09hJ6y83Rup3hwYwsa0qI=;
        b=SMgyDPumLyH4KNIvt6oqHmBN7UJClbMhw9b+i/3ZzFq1G87Qtvglt5sIGfvL8e0gV2
         sKqjq/7K2OX0j/5CrEiE8W/i7NrY1riGyVnfzgIlju7LfNvrrUg/RqTHRCCqPe00s2N4
         qZ1hl6Cylj+HAYzy0VIdSdEQiiy7Syp3iqCFd0XdCGsf05vD0U/nyBSGBEbwONs64ghZ
         lnYUaxWstnvQCA/PYoslyQj1o9qwMkRSDihXN+e9+2CrIu6OmADO4m7DepoYphd92+Bm
         +zPEMsiJcUxj00N//6GlKw7uSzE+1miiIAPYwuye11SeOwrvcNa5JmrEGh4yOoSf4c1T
         MhSw==
X-Gm-Message-State: AOJu0YxhkK9Qj6UXEU+nf+cjoHieMa15TqVJt7HxtjDvBK+prmzepG8Z
	Ha9pciHU0JOY8giAPaRqUGhLpR6fbFhr7MZULS7wCeg/U6mFMObvrPbmCb94AJXXnOU=
X-Gm-Gg: ATEYQzwmQ9SjX00tfLcfm434qjHFgo7Q/5bEWokP7BrBNx8j9WrbHnNuBCnzLj0HJVG
	m7DvuBXaJfwVDBoSa5PRDkGjD8AqH+8TEpmfY0/D7APHpfr9wy7pcycrgSxDk1mELJdhfrfcdYD
	iSFCaQkxRK7Fzf4Hqdq/YDu7QqZJBHoRy1KT6BYU5VjY/CTXDh7cJKS/qy6c0yjQCO8oUGFM9G6
	tamW3IxuX+nNCFybGm5x7RrfDJu3bdD+OWp1XAHUzqDsY8gDQfLGxcUiqczBeEwaLrkoexkzA5Y
	LH3TGCmJxQ3SQAfbnGtJ3f6QwDacVUllAQRhJaJGlzWI13CBGjZTwUS9TOKrWn1ZXnQOgGKoLpg
	G8jSKTkAIkwZhORI9ZVHrlSV0AKP6I6HkUvnx2d+A8ECO/iaZk5LgPzqCcw5HjyclQpk5xRjWUP
	rK5rPj2K4B3fK+6a/6bX+C70BknLeproKJKZ+O
X-Received: by 2002:a05:6214:d87:b0:899:eff6:6e76 with SMTP id 6a1803df08f44-89a30aecff6mr146364546d6.44.1773032361818;
        Sun, 08 Mar 2026 21:59:21 -0700 (PDT)
Received: from gabes-pc ([184.145.175.55])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a4df6eb9fsm13499086d6.5.2026.03.08.21.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 21:59:21 -0700 (PDT)
From: Gabriel Woloz <wolozgabriel@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Gabriel Woloz <wolozgabriel@gmail.com>
Subject: [PATCH BlueZ 1/1] lib/bluetooth/mgmt: Added missing command "HCI Cmd Sync" to mgmt_op
Date: Mon,  9 Mar 2026 00:59:02 -0400
Message-ID: <20260309045902.2354-2-wolozgabriel@gmail.com>
X-Mailer: git-send-email 2.53.0.windows.1
In-Reply-To: <20260309045902.2354-1-wolozgabriel@gmail.com>
References: <20260309045902.2354-1-wolozgabriel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 lib/bluetooth/mgmt.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bluetooth/mgmt.h b/lib/bluetooth/mgmt.h
index 1ad52529f..1c741ed55 100644
--- a/lib/bluetooth/mgmt.h
+++ b/lib/bluetooth/mgmt.h
@@ -1199,6 +1199,7 @@ static const char *mgmt_op[] = {
 	"Read Mesh Features",
 	"Mesh Send",
 	"Mesh Send Cancel",
+	"HCI Cmd Sync",
 };
 
 static const char *mgmt_ev[] = {
-- 
2.53.0.windows.1

