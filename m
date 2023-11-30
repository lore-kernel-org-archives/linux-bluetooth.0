Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JdmB5vMA"
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4861989
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Nov 2023 07:24:55 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1f9e6a8b00aso519659fac.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Nov 2023 07:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701357894; x=1701962694; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MSOUn77w/xB5LeMizesHwVxPEigQZipSDTaraTsR3UA=;
        b=JdmB5vMA0ff5kAtXy7nyfm/xglZkm6PVIcRf/OivZrAUVEnt0yszXavGiM2BSByqA7
         /6ldQ7qXJQ4/b3hZaw8YvGW9qe7xyl7gYcMa2jUOJ2NsPZqqloQmGHwY1VIlJz62xGuP
         5dmiqmh8gtYIeKeRjbeJwvzeL7iOvlv6w9pu2EsNURFx1JGDjIei8es1JeBUN1JvIH8G
         M2TD7p247VyE6E6dWBQWsw7LWAVL1VePIfvvNTMT5gAEe94pEZNRklK6nAByEqCydg0B
         pHD15dzbHycldF2YZlh0T5Bd6bXgLuy0SADffIkLisY/dEus8vVpcW0RINDQ3nJSN219
         EXuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701357894; x=1701962694;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MSOUn77w/xB5LeMizesHwVxPEigQZipSDTaraTsR3UA=;
        b=kpjOIYEXQdOe6s8mPoiG+yn9d7k2WVXaxPuBuVzabDslO8NxnVe8lAswiIIlgQh7Qi
         vXQSE/hRoIvOD/10/LqgTRqQEVVegzSYQfMXeSY6wH/q1PHeTBZ6zT0zM4o3MIlpc+V3
         0Q7z+hdZi1TWiizGBm16Ab5co9j+jwQM4zxSMDOVH104n7XCFzv4blkKZjintD5aMX12
         OidfLeuIHNAd964K3swSFiJO56O549oIUcISraBsQ8WZ9QIeoF1Kl9nuBrt+D7bTqhwX
         M3KD6UkLYq4E+63Mhxd8lbH57ElF2iBaJy/3+L97hNugJw0/84b9zyoyDRymZbOWInFL
         6gEQ==
X-Gm-Message-State: AOJu0YwaGEjWIY59TaWv0aSwcTjJRpB29PR/Nltnlg5C7Dd11PBbhagf
	80VF+kjWpBNKr6s+1juKtqqgSCVOKnw=
X-Google-Smtp-Source: AGHT+IHWHGMUQ9B9Ghq5KKoOjqWXpU/STFhyAEM0CTCMmi4bkwijm2eh4G7UH/PeaVD6lGtc4YL81Q==
X-Received: by 2002:a05:6870:5d93:b0:1f0:656b:5b99 with SMTP id fu19-20020a0568705d9300b001f0656b5b99mr31676827oab.11.1701357894318;
        Thu, 30 Nov 2023 07:24:54 -0800 (PST)
Received: from [172.17.0.2] ([40.76.238.217])
        by smtp.gmail.com with ESMTPSA id km6-20020a05622a780600b004197079f2f8sm569041qtb.64.2023.11.30.07.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 07:24:54 -0800 (PST)
Message-ID: <6568a946.050a0220.ccf1e.23fb@mx.google.com>
Date: Thu, 30 Nov 2023 07:24:54 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6175790042630255851=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] shared/vcp: Fix build error
In-Reply-To: <20231130141040.2243867-1-luiz.dentz@gmail.com>
References: <20231130141040.2243867-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6175790042630255851==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=805627

---Test result---

Test Summary:
CheckPatch                    PASS      0.48 seconds
GitLint                       PASS      0.31 seconds
BuildEll                      PASS      24.06 seconds
BluezMake                     PASS      555.08 seconds
MakeCheck                     PASS      11.16 seconds
MakeDistcheck                 PASS      149.66 seconds
CheckValgrind                 PASS      209.53 seconds
CheckSmatch                   PASS      317.03 seconds
bluezmakeextell               PASS      100.79 seconds
IncrementalBuild              PASS      535.91 seconds
ScanBuild                     PASS      924.61 seconds



---
Regards,
Linux Bluetooth


--===============6175790042630255851==--
