Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF72B1B27D
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 Dec 2023 14:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VxnktnGe"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-425952708afso33886021cf.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Dec 2023 06:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702995027; x=1703599827; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vQHqw6xC9Pf6cezC4GZEahdxW/p4wixoUUBM74DGK84=;
        b=VxnktnGeevh6PuEXp/2VGO31bom9I62NfxtXoFL9dh5n6pzfOdITAdKfMx6GdKqYhd
         gw/4Jc1aOD1ph7G02sIrs7Z2OutgKE6O5OQmBDVFgy/PZWDQUHxr/CrEtAGPiBDpCtTr
         O2DFTPQhOSByBjxEAOBfEXbFjc/kbAbJRhwH9ZT3l9WW/xnOOuXGKhfxGeyqUHGbZwYK
         dXtcZ/yU7cREUusqVbcpQg86DMBHnia7m4ommTppJK3dqESJumDBTUpA1rv5OlIPAi+j
         Cb5wGUwn1G0iAJDf9Oep/goSx2gblzUuummJzG2Jn4GZyfge4vEE4zDWjAMFkdG2Y+Aa
         7A5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702995027; x=1703599827;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vQHqw6xC9Pf6cezC4GZEahdxW/p4wixoUUBM74DGK84=;
        b=wuI/HuDbFCQjxgk4T9dd/aNdtHW2Ui1YBX6Qx/GqoUZlyOYQL4Ejx0kFZSGroi/ON2
         yQCszsXFO20G+NE/jSq3qVDaY2QCvbNby5LBtiIW4DJ7jBVd7uHaphYBdvkO7p2Ybc9q
         gb2xALCslneXdwNwgIwNJHrtd85py/KXhlIuzfSGaSX/+6rGwb3uNhs7tyZMqEo2xqXt
         MKjXjrranvB+IHjKhziBCGRD+I5nmEv0RvdTbEFeW8FgI28ba5tGE4CLy/FRu8XL55m/
         MfBm/rOni8/sb8hhw6Xkk/S3GZDIZF/OLR+Io4tEgMFCnSW+eQ/3eqbyGXXnfLfi0Qoe
         Abeg==
X-Gm-Message-State: AOJu0YwwDZD2PUSIB2htu/tda5f0DG4rJ4VLZql21SU/nl7lu3nwJLlI
	nVX87lgucH4Vj3vFM856beurCpQA65o=
X-Google-Smtp-Source: AGHT+IFNDgrzQhUagmKe1GvmOJtUQ5IExTAauZQiJJ9EQcvllbMuyYMTc1aDu4vLJ3/onQ79pt7oYQ==
X-Received: by 2002:ac8:59c6:0:b0:425:928b:ff56 with SMTP id f6-20020ac859c6000000b00425928bff56mr1716777qtf.37.1702995027526;
        Tue, 19 Dec 2023 06:10:27 -0800 (PST)
Received: from [172.17.0.2] ([40.76.119.136])
        by smtp.gmail.com with ESMTPSA id hj1-20020a05622a620100b0042601b60861sm4786819qtb.26.2023.12.19.06.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 06:10:27 -0800 (PST)
Message-ID: <6581a453.050a0220.c4d98.8376@mx.google.com>
Date: Tue, 19 Dec 2023 06:10:27 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1953550986651505578=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, vlad.pruteanu@nxp.com
Subject: RE: transport: Check if transport is bcast before it's cast to bap_transport
In-Reply-To: <20231219124916.44173-2-vlad.pruteanu@nxp.com>
References: <20231219124916.44173-2-vlad.pruteanu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1953550986651505578==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=811394

---Test result---

Test Summary:
CheckPatch                    PASS      0.48 seconds
GitLint                       PASS      0.66 seconds
BuildEll                      PASS      24.09 seconds
BluezMake                     PASS      724.68 seconds
MakeCheck                     PASS      12.23 seconds
MakeDistcheck                 PASS      161.22 seconds
CheckValgrind                 PASS      221.22 seconds
CheckSmatch                   PASS      329.59 seconds
bluezmakeextell               PASS      107.36 seconds
IncrementalBuild              PASS      691.09 seconds
ScanBuild                     PASS      949.26 seconds



---
Regards,
Linux Bluetooth


--===============1953550986651505578==--
