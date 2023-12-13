Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ihapb98y"
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0754101
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 Dec 2023 02:06:58 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6ce76f0748fso4232689b3a.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Dec 2023 02:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702462018; x=1703066818; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DuFNyliRN+lK5ZnsyqzfwR+2pmWT+lBPoWxsjCCyxMo=;
        b=Ihapb98yTywDXrjAj9W9eXP9FFi9mVZX74y7utRy1PrvUGWu9pmG+CYJxsJ14zAo37
         LHgNW847ktSz8jSu788Dr9NjqMVtE1dS2gQOsMLTuPjwa15cooIq/6+d4MMABWIulQ4K
         QJtIIaP28ZmKa/D5C5epmjUWSziC07yNEXn0eoJWwPjMYIASqXlK5XqlfnB1lMKrGAiJ
         I11gopr+bGFNwz/z8RPnQaEMeKxBC0CHW0pJLkG5Q2c9vqB7iArXK3VOhwfM+uHF1IeE
         2I5ZjMZ2pxwx4eiXH4RICM677pk5vpINkSZYJatkrZs4OYK2Vf9ygmeyonjS4wqvMOjN
         UFIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702462018; x=1703066818;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DuFNyliRN+lK5ZnsyqzfwR+2pmWT+lBPoWxsjCCyxMo=;
        b=jzkF0trhZqwh7aIyzF56EMtn88Jp4MtCG/j9HRRNJygxXVP17M5UsiQkUfcvp2nyPh
         1ypuZpbmCIdRTK2kXZLck3k6JKIHM28W3ME1bYsbEjk4byjeHAYgP0hDBx+jRr7olKPu
         1+wmLwyecjZyv/2+9HVoMUuAzD99PGoSxew4vZE/vE77NhHLGt2qZhLWIxAG6QGtrxe7
         d0eLK0yPfUvllQd2BrTt2xzDc7SAyk5548RSbEqAx/rSO5OQqg6j0vKAPX1JO1EB1R+K
         rq7ZZHiPXIY2u80xgfug5prbIH2p+tLkTU7QMVKb8rnq0HGoNh17Ydhsxu1xAoBnldr/
         IwDA==
X-Gm-Message-State: AOJu0YzdQnwesEvoKhoIBmyv1elzq5E6LTtkgP2SFdx2kEwd0Ffkyybe
	uyHfS6+Q7GseWHrJm9SKSmA8oZNA1lnSbA==
X-Google-Smtp-Source: AGHT+IHR/rpBWcWyBf7fFq/FbUVvH99kF8p7MkrU2Y5Fk9VdAGfXuk9GhysGKeRScFnLppIquztuow==
X-Received: by 2002:a05:6a20:639e:b0:18f:97c:4f58 with SMTP id m30-20020a056a20639e00b0018f097c4f58mr2803871pzg.100.1702462018155;
        Wed, 13 Dec 2023 02:06:58 -0800 (PST)
Received: from [172.17.0.2] ([13.88.170.224])
        by smtp.gmail.com with ESMTPSA id jf18-20020a170903269200b001d087d2c42fsm10134735plb.24.2023.12.13.02.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 02:06:57 -0800 (PST)
Message-ID: <65798241.170a0220.ab45d.ec32@mx.google.com>
Date: Wed, 13 Dec 2023 02:06:57 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0227394149691383794=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ] hog-lib: Fix HoG discovering characteristics order
In-Reply-To: <20231213085011.1152912-1-frederic.danis@collabora.com>
References: <20231213085011.1152912-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0227394149691383794==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=809574

---Test result---

Test Summary:
CheckPatch                    PASS      0.28 seconds
GitLint                       PASS      0.21 seconds
BuildEll                      PASS      24.29 seconds
BluezMake                     PASS      717.00 seconds
MakeCheck                     PASS      11.80 seconds
MakeDistcheck                 PASS      157.76 seconds
CheckValgrind                 PASS      215.39 seconds
CheckSmatch                   PASS      324.50 seconds
bluezmakeextell               PASS      102.73 seconds
IncrementalBuild              PASS      672.22 seconds
ScanBuild                     PASS      912.77 seconds



---
Regards,
Linux Bluetooth


--===============0227394149691383794==--
