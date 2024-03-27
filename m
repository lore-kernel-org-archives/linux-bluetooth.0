Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FD5134AA
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 Mar 2024 15:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711554170; cv=none; b=oNXedp8KzhJW+GVOXeesriLPJZe1Dd882UUq6DHvcSNt94jAkYeTKHx2ES8BhFx+eoardsVJLkIxKapGk1xmdGrrqG4dFBTr33isMyuXRMGhyMWVtEj/rgQfCdSoei854U99l839xdjCI51t8A/DijAzYNS/fiFP08+vEEUsce4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711554170; c=relaxed/simple;
	bh=CT4BC3jkH0Aa9JN27Urgji2Kkku65FmynCRsArKswfI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=nZ3UiLu41O5H25CZcZw3Hi//fHAz28WP/ohPG9aQ+9zf1ofogO3qMIMyV0b7DzGDFiQE2Almlp/Khd9tF3bsOiK5TUYWh3TUZeRf58KQq7aoQZfXyTZxm7vNMjTZnLULbNGxKPulxCvc7i+eJquA5KxIpPukTVFpWt+1Ozc5r4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aRI1OA+h; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aRI1OA+h"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-78a01a3012aso468388585a.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Mar 2024 08:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711554168; x=1712158968; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bBzpai04vD7tLubATXDd6m+cAOcwBG3iuX9mr4pKSTc=;
        b=aRI1OA+hbReAF/Ke4xnvhZfEsWII6BwR72bMcVHWYS9JSkRoz9tZfjt9dHWNNNOYB9
         D0vP8iSm/1wfniMhwJownXlx2YYTQEy19EAYn7gObflJHx+oFzwCMI+/liEYZNTt2zI2
         lWojPwf6f4Yg0oBRq+lHpYg+D6u6OJRevEM3IClfeJDvgXF8L8YhI0nwDTFzzh7cwazw
         ZnhKA4viB9qgVLPQyv8myanPCk9ktZMJa9q9ISxngBXZ+WqdOEutlQBaeKbxmSS9iSWr
         SxQu592bZK/f3cR7uDzvrZNUZ9x+iIAZUP4HFqCveKaxipi424uTrk0CWSJ0laV2BlDa
         Skjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711554168; x=1712158968;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bBzpai04vD7tLubATXDd6m+cAOcwBG3iuX9mr4pKSTc=;
        b=b3EcAkDaQtP/34LKql4ldxtPTAjMrHS4UTh/MFagmunNqTyL4haNoTeaAdffteusaR
         X+Al0wjPeVDInHRH2s6xrweywOk9+ZwIgF7ydZ3zRXyIUMAVe4ozKneOQh5V0EqEoB35
         9QHySa/hpAd6HovWMm05bckMyhzIP6HIn0NeOXeMM8KEXzEKICy83QuiZLwRXPgdPucd
         yl1KB1lnFR9Wik8Actbk1KY4wGgwgjAYMqLW8gCnWZWe8lg2Cq0rLTQ3hB3CBl2qlIlJ
         WXQ49uV9pVc2XdCfAEbf1LZiJJyrfinDQeQAHxPOeRmj+IBENToWLwD4KU6z8z500Zm4
         JDMg==
X-Gm-Message-State: AOJu0Yy+FPjH+WGrvkv4KMY4MQy6Z4pxHgijGDv6JlTHFWB0iGcf/pIQ
	bXEMQvP+hgrz7sgvoffyfAT0+DKnmQXc8VdVWX0JnGfY7BAMImQwfwJ65P1f
X-Google-Smtp-Source: AGHT+IGOEwLT5nRviKzuJnI8RIkcMFLfKGM0XH30OQaGIxAWYDBCOGLfUiYEg16p8ZIrWOXvijRpIg==
X-Received: by 2002:a05:6214:2464:b0:696:72ba:100c with SMTP id im4-20020a056214246400b0069672ba100cmr5245251qvb.45.1711554167640;
        Wed, 27 Mar 2024 08:42:47 -0700 (PDT)
Received: from [172.17.0.2] ([20.81.159.110])
        by smtp.gmail.com with ESMTPSA id e2-20020a0cf742000000b006967565c827sm5314557qvo.141.2024.03.27.08.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 08:42:47 -0700 (PDT)
Message-ID: <66043e77.0c0a0220.4fe35.a990@mx.google.com>
Date: Wed, 27 Mar 2024 08:42:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2573556677706611779=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, silviu.barbulescu@nxp.com
Subject: RE: Fix MediaEndpoint prop codec for bcast src endpoint
In-Reply-To: <20240327134947.40229-2-silviu.barbulescu@nxp.com>
References: <20240327134947.40229-2-silviu.barbulescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2573556677706611779==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=838891

---Test result---

Test Summary:
CheckPatch                    PASS      0.44 seconds
GitLint                       PASS      0.31 seconds
BuildEll                      PASS      24.43 seconds
BluezMake                     PASS      1777.98 seconds
MakeCheck                     PASS      13.74 seconds
MakeDistcheck                 PASS      188.68 seconds
CheckValgrind                 PASS      257.92 seconds
CheckSmatch                   PASS      357.36 seconds
bluezmakeextell               PASS      122.02 seconds
IncrementalBuild              PASS      1572.43 seconds
ScanBuild                     PASS      1017.14 seconds



---
Regards,
Linux Bluetooth


--===============2573556677706611779==--
