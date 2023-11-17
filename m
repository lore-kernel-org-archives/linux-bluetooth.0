Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0teMh6m"
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74825D75
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Nov 2023 15:00:41 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-77784edc2edso149616285a.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Nov 2023 15:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700262040; x=1700866840; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=F/3ctGbD4QaUQboJTu2Ikc+f5qcBJhmCKeH5It+YTVM=;
        b=h0teMh6mAjsVamk7kuD1GR0MaWTR/HAZ8EcMvwxS5AVXZUcLu/87SBBo6VQUxMfXjW
         1gCtShEUWs/lBLkzPEy+y1y7dS/+N3F2DyX2cvHgZvzS7b6kSOCHcGLIy0fVXwbUid2w
         bd6PtekT5E6nmER/lvCc91fdmettI5OhjHdifuzov7FysrqkZbklC/QZu43jYysb/vfU
         hgrHNxh0czcs2IgMHlb/cnO5p/VD9IQ92ZUtXc1JJQ2i3FalEr0Jp241Fmxovqpb5FLJ
         JKHokJT2zG/bkQ1WB7Y5IO7OgZqV/asfO9KnCEOehcpgx6dAgNCfTBhfEBYr414EZafO
         H/gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700262040; x=1700866840;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F/3ctGbD4QaUQboJTu2Ikc+f5qcBJhmCKeH5It+YTVM=;
        b=PhA9wJz82WOK1KaV8AHd+VkBQNeZdwRwZBUxP7tFvJ5WdOuft6ltFpxwwD2c5q8hQm
         dVK0XDFF7GwnmhY4AhYiSjRRMmkR5ZEx8nXLos/vogViWmoNKExpPTLqs3BxsLUtYo/U
         wvFtlFp6/dWpv09bBprLGwbtPenZ7NTPN1fj6dgz0h7BvkKRBhsGNxMB1cJs+fw6HUXe
         MY7UaCjDnUXsBperkmJnaus3WaOOQ9wrwQUSrxvlrpoUeF4MLFG9hLqo01064ky348+J
         ExdQ1ujxIKXebuIYIhY0C4578Ul/yGp+sbIod5SsU7gvBhCD39rExChie4/EnOpzq6He
         2ohA==
X-Gm-Message-State: AOJu0Ywetz8FcDSR0RbzyD2tUS+RCBfzw6m5oa+Kqm7hTW0dYbar654e
	skF/PEIWgg0dh/NnfexhmFaBZvsKcoDogQ==
X-Google-Smtp-Source: AGHT+IEojeLh5gm0aLRrOna8gBtWQr94VdjRMmk9Tgyq6jRf7VQyQ2Zo13KmZyY/lGZ6G/0dhGZbrA==
X-Received: by 2002:a05:620a:3c96:b0:77a:75f8:a69b with SMTP id tp22-20020a05620a3c9600b0077a75f8a69bmr814040qkn.38.1700262040437;
        Fri, 17 Nov 2023 15:00:40 -0800 (PST)
Received: from [172.17.0.2] ([172.183.154.176])
        by smtp.gmail.com with ESMTPSA id sn1-20020a05620a948100b00770f2a690a8sm942082qkn.53.2023.11.17.15.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 15:00:40 -0800 (PST)
Message-ID: <6557f098.050a0220.e0ded.5863@mx.google.com>
Date: Fri, 17 Nov 2023 15:00:40 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7147387366311441366=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2] shared/shell: Remove readline color escapes
In-Reply-To: <20231117220506.273238-1-luiz.dentz@gmail.com>
References: <20231117220506.273238-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7147387366311441366==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=802082

---Test result---

Test Summary:
CheckPatch                    PASS      0.43 seconds
GitLint                       PASS      0.30 seconds
BuildEll                      PASS      24.42 seconds
BluezMake                     PASS      560.91 seconds
MakeCheck                     PASS      10.27 seconds
MakeDistcheck                 PASS      152.66 seconds
CheckValgrind                 PASS      212.26 seconds
CheckSmatch                   WARNING   317.05 seconds
bluezmakeextell               PASS      97.32 seconds
IncrementalBuild              PASS      511.49 seconds
ScanBuild                     PASS      944.20 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):


---
Regards,
Linux Bluetooth


--===============7147387366311441366==--
