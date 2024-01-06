Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5E21078A
	for <linux-bluetooth@vger.kernel.org>; Sat,  6 Jan 2024 23:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IOLpXfLE"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d3ef33e68dso4671675ad.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 06 Jan 2024 15:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704583767; x=1705188567; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CVkVh046vzJWhjvQiXxcb9ZF67OFGOD7PWI7x6DwPYE=;
        b=IOLpXfLEbne9ZLzc0xuPH4jKKbTK0GzpR9UutnxtJnGFJ+/St2oqfdgBCVKbI2EUoq
         whRJlIqon2iIrLik/2C/RUnCS5nQe2X22selqu7dhRU+deIYWm5aJlh7yDqxvwRnUSHk
         RviHTF9Zh2wfxknuhQtZ6eW0R35VDJF5udrSIBeSwY89TuIuOis54FeJTSSAS/ighj4J
         OFONK4jlBH/BS7/avQLNCIiIDpzrV2w9HRXRGL8b3D21PSud0bv9EvGOOupOoBgv10r3
         tb8HvvaVSzZhtI9ZgWnNDxR9PlJc5x4j4cLVhPWW9zaMkLQZ8r5LzPeJUOmCL2AE+BBE
         5ptA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704583767; x=1705188567;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CVkVh046vzJWhjvQiXxcb9ZF67OFGOD7PWI7x6DwPYE=;
        b=LRxQvycL/CPrNcawyuZLIqF0KIpQw1bcZbMnjvEMdJNEX/qO28CLBPlEW1PxuIFAY0
         9C4gPXu4ZclKNQqlIdNkg0+tD2ynilLNXH1nVeHUSODfCzBKZCx4H8AIImztvP4P6e/6
         zjPtVcTZA74efScu9m0MbGu0naeNAn9K4e8Pny46iMHIYcJIESu0X9UH35PvSoqknVon
         TVtznyfVWP2BFyXR+VHFXx3+HpMZG7nK02pzUIxHZeLfuuVzH74c4I4rC6uNTGtXh8GA
         YYjk3Z0MFHiqNVHdqvryJkqjdK5623VxJUCncQnwFS5hNN7N/Jy5LSkCyMW4x8OYJpgQ
         RiCg==
X-Gm-Message-State: AOJu0YzBLCEsn5Fh5YFZv6KiLrLxElytsBMNol2AAKiaJiiqKZgkoW0S
	avnMZBjGyovuHkegbXUqhicffN0Nl7Q=
X-Google-Smtp-Source: AGHT+IHJUR0pGvOdTpwzWlps/pE6/mQ6Ew2yFWsDDtdyZLGmaKxKp3oYGYEMCU4s4XTXGUkuBGh2HA==
X-Received: by 2002:a17:902:e881:b0:1d4:e6d0:34db with SMTP id w1-20020a170902e88100b001d4e6d034dbmr4284702plg.19.1704583766745;
        Sat, 06 Jan 2024 15:29:26 -0800 (PST)
Received: from [172.17.0.2] ([4.227.114.177])
        by smtp.gmail.com with ESMTPSA id u2-20020a170902a60200b001d4c316e3a4sm3530203plq.189.2024.01.06.15.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jan 2024 15:29:26 -0800 (PST)
Message-ID: <6599e256.170a0220.9b6ef.7b1a@mx.google.com>
Date: Sat, 06 Jan 2024 15:29:26 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7080393785968522112=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, contact@willowbarraco.fr
Subject: RE: [v2] mpris-proxy: add --target to target a specific player
In-Reply-To: <20240106221626.8140-2-contact@willowbarraco.fr>
References: <20240106221626.8140-2-contact@willowbarraco.fr>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7080393785968522112==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=814873

---Test result---

Test Summary:
CheckPatch                    PASS      0.32 seconds
GitLint                       PASS      0.21 seconds
BuildEll                      PASS      23.60 seconds
BluezMake                     PASS      706.83 seconds
MakeCheck                     PASS      12.02 seconds
MakeDistcheck                 PASS      157.79 seconds
CheckValgrind                 PASS      220.22 seconds
CheckSmatch                   PASS      323.93 seconds
bluezmakeextell               PASS      105.13 seconds
IncrementalBuild              PASS      667.43 seconds
ScanBuild                     PASS      918.76 seconds



---
Regards,
Linux Bluetooth


--===============7080393785968522112==--
