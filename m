Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RHl0H56X"
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F6610F
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Dec 2023 01:31:32 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-dae7cc31151so4110453276.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Dec 2023 01:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702287091; x=1702891891; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wsZRZ+pMrrCjBTllBgo31vMrfg5KD+VpFROfOTv7vLE=;
        b=RHl0H56XFL021lOJdFMXKdYMuKUHZB5CQo8YO7WmQIfXV62WLmaBU/VcfCliJgSZxS
         gN8zICk98Jqw/hPX4LS5kiach6akf/9NYvcKRbaoytjxqaURXb8OMe4YQdctaw0f+nnH
         Zi7ExLgvOx73K5aE3sHIgi9GIhYeYSlv1Fnfn7l7lTH1SoAuiQNX/0Zbvh718eRqwCst
         eMTX0yXgjHlB4rHrd6KIBjZSudnHPEHd1MsQN+HN0ilP/Q+1JCRtwBzHRpnSJoNjwP3P
         zCZRmtzHZ2J8/+EboKofaCknBfeTTOAzhJvwNASYf1K6cf2CG8ZY8pv1rgYN0+VRYN0S
         qK9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702287091; x=1702891891;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wsZRZ+pMrrCjBTllBgo31vMrfg5KD+VpFROfOTv7vLE=;
        b=Bn9Ia4EgSvY853ktiASc0jx9eYscM9ZSx49j5BBBCPPupfzsMNMEoDkezgoqzj8Np+
         YNbZYNQ9OrwlqJlhdnm3acslM01EQf1JiisDCYnSZQcZqhhYWuBcJRHe+dVSES9rU5Nb
         ro18ZxsRZEK2x1D0YI29l8GwvnsqDoLavKyUIFZEbPfiSjtH4DWgZcBGeMTrFB/x5hkW
         xSEG7FMjwP7DowT1htmPZJIquVlJC0P+dFQa9a7nAsSHXbRfhqe7V/3J6fYPS+JA4COK
         N54Ynsh5t6IscbK0oB0xMGCYDWSFZMKpg6/v9P3VgNyug+FU6pJ3X5JenMxEzzTEN2Oq
         8kTw==
X-Gm-Message-State: AOJu0YwYi/3Cq8zLE4Myyc4T7vvhP9IpIMMqyH49pTzFQyOCMf4DNp9C
	LNMMm6I4iZYDqAPepbfdWNhBxv/4bKw=
X-Google-Smtp-Source: AGHT+IFYvp+WssgCaYYkoK7rpkf3uUHHkHC8idx3yCpgWfUD9fAUcziSSEL8JI80ntxK0XYboynmww==
X-Received: by 2002:a25:ab4e:0:b0:db7:dacf:6fd6 with SMTP id u72-20020a25ab4e000000b00db7dacf6fd6mr2772527ybi.94.1702287091028;
        Mon, 11 Dec 2023 01:31:31 -0800 (PST)
Received: from [172.17.0.2] ([20.109.36.214])
        by smtp.gmail.com with ESMTPSA id e5-20020a0cf745000000b0067a0eecf4easm3138405qvo.31.2023.12.11.01.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 01:31:30 -0800 (PST)
Message-ID: <6576d6f2.0c0a0220.ba9e5.bb31@mx.google.com>
Date: Mon, 11 Dec 2023 01:31:30 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1129260319535632166=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: shared/bap: Update Available context for source
In-Reply-To: <20231211083507.3363494-1-kiran.k@intel.com>
References: <20231211083507.3363494-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1129260319535632166==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=808691

---Test result---

Test Summary:
CheckPatch                    PASS      0.48 seconds
GitLint                       PASS      0.33 seconds
BuildEll                      PASS      24.02 seconds
BluezMake                     PASS      724.89 seconds
MakeCheck                     PASS      11.90 seconds
MakeDistcheck                 PASS      154.80 seconds
CheckValgrind                 PASS      216.04 seconds
CheckSmatch                   PASS      320.17 seconds
bluezmakeextell               PASS      100.97 seconds
IncrementalBuild              PASS      665.08 seconds
ScanBuild                     PASS      916.05 seconds



---
Regards,
Linux Bluetooth


--===============1129260319535632166==--
