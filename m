Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQ/NGj32"
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C25084
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Nov 2023 03:25:08 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-423e7e0a619so4721751cf.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Nov 2023 03:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701257107; x=1701861907; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rdJXtXnkET/w2NPWWjLepq014cL4qeczUI7+mv+psAE=;
        b=gQ/NGj32Wq7VvG/4IJYuTSayMGNcvQ2sHPTK/kNcpGNGoece90H2dsmYRaEp6UE1f9
         YJQF6XM0PESFeWfPqjcVEkQ5tN7eZoaPTCKA5TQW+U1YRueuRu9lYbHzixuzpPG0UHrp
         PDA8iOqeF0yviQ22ieGpKpLpojv9ZdN4u1y3sriPg9UPHnnae11/b2B+UTfsbeSZ5S3O
         GS7gdenp3hETOFRCKfcgBmKx5OzMuwB3i/a7eR6Chbx9jbxW5xI+jmKfjA8/8+3vZTZv
         Wtz5Va3f6SCfI7UOzCkzfy5zaIaYk0yVTLcF6jcXPPoO+9iDh+fr/CGtdU/oxwwZvzRY
         hg3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701257107; x=1701861907;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rdJXtXnkET/w2NPWWjLepq014cL4qeczUI7+mv+psAE=;
        b=owi2PhVOuiRkQEf+QONzWlGQc5h7JEQLCH02U1P+v+g5UlSYIsoecfwfJVAqjiz0M/
         +a7m7FlLdc957xumHW9JVHBcu6cEUdkmBsD3ee4WcCFqma2G/w0fDj3Q/194ZnxpN+j0
         yx8qIWordtbAX4kws4ych63TlI8jJwAUKoD4U84n26S6vUwMd7gidSzNKSsY1rEq57eb
         Z0h4vzf2AHDhs1qEPrKQSd8GtxYacZpEDT0xJyWI0JcSbdJ4fYeKgvyyrnvW6iBDL/0p
         ESfSWLLZRz7G7EyYe+cE2P9Wimwmv/kt2eGtMlVreuHGwWrxf01q5cM9kVOBly15r/eD
         EB0A==
X-Gm-Message-State: AOJu0YwcTSWTPai4A5gKzvgGgh+AZR1aGf/V4Rantu2IsBcmfyVmcg54
	0ZTfhOI6qyKbeU7QUJXNlnFkVQBhdMq8hw==
X-Google-Smtp-Source: AGHT+IFs6PBD0/Vgixcxfx5RpeTW40MYnffaOK6A2XQRKfj25t5ksF3Bj10UoM/UruWwlfqUaG5EmA==
X-Received: by 2002:ac8:1016:0:b0:423:a9a5:da99 with SMTP id z22-20020ac81016000000b00423a9a5da99mr14711040qti.13.1701257107249;
        Wed, 29 Nov 2023 03:25:07 -0800 (PST)
Received: from [172.17.0.2] ([20.109.39.22])
        by smtp.gmail.com with ESMTPSA id fu26-20020a05622a5d9a00b004166905aa2asm5439980qtb.28.2023.11.29.03.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 03:25:07 -0800 (PST)
Message-ID: <65671f93.050a0220.7e112.58fd@mx.google.com>
Date: Wed, 29 Nov 2023 03:25:07 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7277900391942956462=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pwaago@cisco.com
Subject: RE: [BlueZ] adapter: Enable SSP after enabling BREDR
In-Reply-To: <20231129101627.1742015-1-pwaago@cisco.com>
References: <20231129101627.1742015-1-pwaago@cisco.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7277900391942956462==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=805204

---Test result---

Test Summary:
CheckPatch                    PASS      0.44 seconds
GitLint                       PASS      0.30 seconds
BuildEll                      PASS      23.91 seconds
BluezMake                     PASS      557.52 seconds
MakeCheck                     PASS      10.82 seconds
MakeDistcheck                 PASS      152.48 seconds
CheckValgrind                 PASS      210.35 seconds
CheckSmatch                   PASS      312.14 seconds
bluezmakeextell               PASS      96.32 seconds
IncrementalBuild              PASS      510.60 seconds
ScanBuild                     PASS      883.24 seconds



---
Regards,
Linux Bluetooth


--===============7277900391942956462==--
