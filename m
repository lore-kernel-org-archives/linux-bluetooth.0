Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WKOthtoW"
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF9410F8
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Dec 2023 12:04:53 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-5c239897895so970701a12.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 Dec 2023 12:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701979493; x=1702584293; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NpSyLXGavri3vu+DFc44YpE/jMZr16JZmDPW0pcXcQs=;
        b=WKOthtoWZURAgE4dtU5RDmRUYcvOwzTFkyomNjLeCMFVO01eviUlgpo2tkmpXRu0ZI
         oZ+H42xHrUb7fRsOfAohfK/lD/0vFSvXUdLbchZYfLvxld3qww094fMcHXn50zdTNd45
         KODA474Zhz8XG8fx8zfj3gRUhmUAUPT1qTIo8q0epixACg4pwkK+Unjk6wcsII3w9lQS
         gfZWlvF6dforDgjNHKE9fUTherSLI+sdQH/4t9Pb8/blk4EPulY6QWBax4mJW/fUnl/i
         rpgKaLHia+cKhOAG3kL285I4kz1FT6YEPnpOeT65hiV/ccXb8mwWnUG2dhLPlp3d1TJT
         +LrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701979493; x=1702584293;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NpSyLXGavri3vu+DFc44YpE/jMZr16JZmDPW0pcXcQs=;
        b=rfvNCKp0UjDTUhwy55nK4pgtA/EW1iXplCpRgnFefCSFqVJtGuH12KkNpJBS4v9wIQ
         uko3XdOF/8acvs5XTVqF+bgFx/LYROSMcza8xynidS+wQTbv12OkwX/c12+HyskdenAO
         zOHhO7h+UZNgq9FJh86tGWfGhpRevQStqE4LQG8uKLaDr4lt7UiW+7D9q9Fc3OC64TG+
         Mryz/lO05O9tVNrEVavxSqtsARfiyB4fy5YBdlF5LWHW8eZyl2VqNCxUpqxynyFdMWGO
         HisWwXWDaZbkSbMT5kzGh7PEt5fSEB3IT5sK14mgtnpILGiKMAZkFlJiMkD4GDhoc7wt
         0flg==
X-Gm-Message-State: AOJu0YzwT/hR46r1AErw1q3bvHrZA3FuQCWagzaK0qSAEZHyuvrMhsSL
	dLvApB0RT+qy5Tf5ok8QIDh7mH8JsZM=
X-Google-Smtp-Source: AGHT+IHxDZXzOadx3QtCWNqEMNeBUCXwNaVE9i0KZ/MUnKI53nswk4SYTGrCGI9PV8dFejrzr6GT2g==
X-Received: by 2002:a05:6a20:a11a:b0:18f:d784:e20e with SMTP id q26-20020a056a20a11a00b0018fd784e20emr3152790pzk.119.1701979492869;
        Thu, 07 Dec 2023 12:04:52 -0800 (PST)
Received: from [172.17.0.2] ([52.238.27.64])
        by smtp.gmail.com with ESMTPSA id b16-20020aa78710000000b006cea1db00cbsm79474pfo.204.2023.12.07.12.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 12:04:52 -0800 (PST)
Message-ID: <65722564.a70a0220.14c55.0748@mx.google.com>
Date: Thu, 07 Dec 2023 12:04:52 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5157441392628034250=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] client/player: Fix not prompting all parameter on endpoint.register
In-Reply-To: <20231207184723.3862261-1-luiz.dentz@gmail.com>
References: <20231207184723.3862261-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5157441392628034250==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=807969

---Test result---

Test Summary:
CheckPatch                    PASS      2.00 seconds
GitLint                       PASS      0.51 seconds
BuildEll                      PASS      24.16 seconds
BluezMake                     PASS      732.65 seconds
MakeCheck                     PASS      11.85 seconds
MakeDistcheck                 PASS      159.63 seconds
CheckValgrind                 PASS      217.54 seconds
CheckSmatch                   PASS      321.99 seconds
bluezmakeextell               PASS      103.06 seconds
IncrementalBuild              PASS      681.09 seconds
ScanBuild                     PASS      906.20 seconds



---
Regards,
Linux Bluetooth


--===============5157441392628034250==--
