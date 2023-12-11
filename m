Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a9MNs2V7"
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7919D
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Dec 2023 10:17:57 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3b9dd6886e2so1811968b6e.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Dec 2023 10:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702318676; x=1702923476; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zbqh3BqSklCQzgQjYtXJj14fj8qINvbD6FYASnOtRQg=;
        b=a9MNs2V7YRR/vXVrl3srm3SQcW+DEthrkwvTUgJx/N6TDBce2UuUqgleJ31f62Syj8
         ZhDhhI9w5mv0WuU7nahkahvWas4ZzrOXVMIz/M5WZ+DQ2jqhsoVBwDuaR2yL8JFCjlGg
         /rADGOxm+SXugLMpcc1QS+0w1rMV3utQA1n0PTmolvBEcY9cSEYkfzhtQP5+WMehRxle
         ohomii2cqbQjx6C17BGZ8+hxlDcTE/Xbuamh+XuwpqBmgniZg7uekDxo5d4rWlPJDpHH
         PEHlt4EuIrk1o6BK4fg72attVpWfvAs9u+94bIy2Soqc1lxgF5dbr3CM0mQPlQsRi4UW
         2B3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702318676; x=1702923476;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zbqh3BqSklCQzgQjYtXJj14fj8qINvbD6FYASnOtRQg=;
        b=PDkXJqK0UJkzGtIy9M4j6ocgE1IDymoLd8rXMVZRZFWMomdcXIUZy9gPSBFg3s3ZU2
         I82xiXxhPBZBrPtUDyvwtAyGH5c74dqDGFJt5zLMhJGonjgBhuRXV49b49Sexa3EtqIN
         lhDEgyzw93FeM693SlJ0Yn/2jIGdD8xEi5s5IATkNuQfZJ/dL8FxJ1DfNQ4rbcb6kPnx
         ZiMciJY6f7N6AqRcM1JySWHpcqolVxjt+eS9tlGGJ8yeWsNXLjXT90tPvy9N1jH/F2bg
         Tu5AMg6aQory/O74lTxBEtyW41zBAH964nJYvyDCXR48hULA1BgR8unhIveZ4tATP4TE
         bOuw==
X-Gm-Message-State: AOJu0Yx7Utv5p91Ez2w/qqQrGv1hdjpL7tGa+tk+iWr2WIqJ9TIzpK8i
	EKZKUWs/7srcUDCROJ/7y87Ri6ebhDA=
X-Google-Smtp-Source: AGHT+IGT5fPwjW6i/aFatSzJti0oOpZdbcA1gEnWPIFxUybNXSd4LFO639eYAg4lMjV2tp0qBd53ZA==
X-Received: by 2002:a05:6870:b520:b0:1fa:c97:220a with SMTP id v32-20020a056870b52000b001fa0c97220amr2599769oap.10.1702318676431;
        Mon, 11 Dec 2023 10:17:56 -0800 (PST)
Received: from [172.17.0.2] ([74.249.14.163])
        by smtp.gmail.com with ESMTPSA id bs36-20020a05620a472400b0077d8a162babsm3095044qkb.13.2023.12.11.10.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 10:17:56 -0800 (PST)
Message-ID: <65775254.050a0220.258a.dbf2@mx.google.com>
Date: Mon, 11 Dec 2023 10:17:56 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5888769026504583879=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, xiaokeqinhealth@126.com
Subject: RE: [1/2] adapter: Fix addr_type for smp_irk/ltk_info/link_key
In-Reply-To: <20231211162729.1183207-1-xiaokeqinhealth@126.com>
References: <20231211162729.1183207-1-xiaokeqinhealth@126.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5888769026504583879==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=808867

---Test result---

Test Summary:
CheckPatch                    PASS      0.98 seconds
GitLint                       PASS      0.64 seconds
BuildEll                      PASS      24.31 seconds
BluezMake                     PASS      717.35 seconds
MakeCheck                     PASS      11.35 seconds
MakeDistcheck                 PASS      157.03 seconds
CheckValgrind                 PASS      220.60 seconds
CheckSmatch                   PASS      329.27 seconds
bluezmakeextell               PASS      103.85 seconds
IncrementalBuild              PASS      1351.13 seconds
ScanBuild                     PASS      930.85 seconds



---
Regards,
Linux Bluetooth


--===============5888769026504583879==--
