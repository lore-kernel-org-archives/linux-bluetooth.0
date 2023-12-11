Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYwesuSE"
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78241F1
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Dec 2023 14:28:38 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1d04c097e34so39048325ad.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Dec 2023 14:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702333718; x=1702938518; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IyzGhJRaoWgLwW2FuMaoaPOukkVqCLoroEzs9ki6/o4=;
        b=lYwesuSEkgC0kBTpxpRKlkeRpQG4H9vha6b59+L6fje5sUCFj4lie0cOGb+KOfLOOJ
         tdjH70uR4HVVWnZ+nXm88JM2GvMWg5dFozprsyfG83r5aJtD06LotfQtGvxkCB5eaZkU
         4qF36bZDIu2WzrLTo5Ys2eWYSc/+hWYz0yS+j/b5I3qjl2dsmxkCeGu5J62jud9b6gIj
         cS3Xs6Xk9Fw8Swr8e6KkkxDnEyjS/YSJM8hYF94JYvZN54S4JIY0v6B6TkWNfXWzQWhT
         t1G0CCvwCPQ9Q0MhyjQx7nL7TmH7MOwBZ3hMAk2qbPtCzF+X5fxBUx8b52bwuHYutEbF
         XorA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702333718; x=1702938518;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IyzGhJRaoWgLwW2FuMaoaPOukkVqCLoroEzs9ki6/o4=;
        b=OUa7IRs90l6Jpe9a4Suw+e50Uu8TD5CMGPo3ytH+S4cVpUGNrHwHAQ2sV1rjUP+RDW
         YVkFkJ9zDE/YXELyFz0LiBK8t1sfmP3rFSj5vdSQEBYk59eunHFrgLBDTm7alMHd4al1
         +yXnvNTdJf+vKYHWbpcdEjM2xPx3bY6XQpflslRussotexR9a3KoDLV5Qh2+moj4Ofmw
         L01QX+QBZB18tRwsTD7FhWRbC7pSTtrQKxRIvFmQrHY30/PReFoVbuqrwjZvwHnwcPb+
         TJpWi3/JsvEz0QRiE4qIl1HW6bJaibZ37Fz2GjVTqHwLeCZyvyJjAjXbwTjNK+XIFpAs
         5FsQ==
X-Gm-Message-State: AOJu0YyJxdviJs6EuvjgeXUFjDsqrlr1jkt2BIJKYSdoPK6l2O/7xWKV
	OytXilxDQ/AON8gsXTWEsaELzs9o7gk=
X-Google-Smtp-Source: AGHT+IEaq3VARsCzkXw1cf3bv6hsgKaOULsQ0uK6JQEd1jUOZhHE+Lq+ezr46wnOtGlGUXcUSsfpJg==
X-Received: by 2002:a17:902:7fc3:b0:1d0:a9fa:58e8 with SMTP id t3-20020a1709027fc300b001d0a9fa58e8mr4459647plb.63.1702333717664;
        Mon, 11 Dec 2023 14:28:37 -0800 (PST)
Received: from [172.17.0.2] ([4.227.114.98])
        by smtp.gmail.com with ESMTPSA id q19-20020a170902bd9300b001d1d5fb96f9sm7167536pls.27.2023.12.11.14.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 14:28:37 -0800 (PST)
Message-ID: <65778d15.170a0220.ec84a.5372@mx.google.com>
Date: Mon, 11 Dec 2023 14:28:37 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7921568539580960411=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2,1/6] bap: Allow setup of multiple stream per endpoint
In-Reply-To: <20231208221219.54529-2-luiz.dentz@gmail.com>
References: <20231208221219.54529-2-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7921568539580960411==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=808404

---Test result---

Test Summary:
CheckPatch                    PASS      0.73 seconds
GitLint                       PASS      0.25 seconds
BuildEll                      PASS      23.79 seconds
BluezMake                     PASS      702.55 seconds
MakeCheck                     PASS      12.15 seconds
MakeDistcheck                 PASS      153.34 seconds
CheckValgrind                 PASS      215.00 seconds
CheckSmatch                   PASS      317.61 seconds
bluezmakeextell               PASS      100.18 seconds
IncrementalBuild              PASS      634.05 seconds
ScanBuild                     PASS      898.73 seconds



---
Regards,
Linux Bluetooth


--===============7921568539580960411==--
