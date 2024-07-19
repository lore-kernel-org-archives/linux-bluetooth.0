Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE481362
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Jul 2024 22:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721426944; cv=none; b=C0GjYpoZR1BKj9ETPNQUbklbyafhp2ulGygyk2qOPzIAP6UTGGcP+mQqaThZg5Sdt3IzQzefrlV7j0HyUBQ7ih6lsx/d/upt2PfVGjyUY9Ps5hSUdGSkAlCpgvQHyYpeS/UdUZeTSVgnBlnWHiXsau7KV+xOgalOcmFxvqqng28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721426944; c=relaxed/simple;
	bh=3zaeGq7EqvIav8IAVhg/zZoPx573Uw3nWPERPDd+Th4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=e24doUZJJTTubehCS+Zr7a6LFNIN8DgQIiOFDdJRM0q/6q//uPNvYBl9Y4Im9EoYq9tLuqdhTNtYVc80wYBbtVQnJPRVvFXAcfMGwWkXS228emPGvEb3xaWKvKiTwaIDs9mo26zsksnL46rlloYW0njn49jQVx8HiC5aR63EnSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bOY2I/Od; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bOY2I/Od"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3d9bcb47182so1402943b6e.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Jul 2024 15:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721426942; x=1722031742; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jpX51fAXvT/CNq6kDNW3HJBjeRGgCuS/qg8MhcLE6Ig=;
        b=bOY2I/OdyKouU47X7E21ex5XswDFT+K2/+uqJjEmOcDhzG1ghZVqTa4sZY3t9P/dzo
         Q9ytaPdo4EuGkJaK2pZ7s/CvEZqSEBtfhazPIyqMukIzHp0yA0t3fAsWEo3cH1k54mUR
         0OyGwER93Amy3RMLU6mkSqKlJ306yN5KB72b32Brye+ZY5uL16YpMsj8CtcsBmf7v/jR
         Wyywr9cMWN6xa8QWAQz5iZ2X+R83gQ5HhGkAswxxAdt+dyBCWndQPwtpkYlYd9qsvJZi
         CXGCtQXcp5rREGFsu9toV2Ex4rboPAx5afGivlXp/JjWE3bZLVm3ZROZsdsQ/ip4+AWM
         gD+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721426942; x=1722031742;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jpX51fAXvT/CNq6kDNW3HJBjeRGgCuS/qg8MhcLE6Ig=;
        b=rISLw9UkiUfntXCNL3qXh6yPRq+pWN856HEsYJeEXyTc28M3vUe/L7QKBdSwkfFYVb
         Q6zAi/B2IUbag3U45/nP09yRpQcdYOGjUca70+k2w5FCFQ9oYelLGX+1DNevrb6WYb5q
         uwcoNPF27u1LG69gPu3Xw3fKCf8Tifcshs3DBfkNnzLDlzcwMcYz3nY5vjvpPRlZII7c
         otfkC+irPNy30ygl345xwswV/ieHnNqNlY6PWv8CcokLOhwRcparSxaIdZbrRuqulGqN
         Oind/Infdd+udl+uykZosuMA5+JNp4KzxPn2ZWIpLwJzjhS2pq20xXDmiyl39JAbuj74
         fM6g==
X-Gm-Message-State: AOJu0YwC1Un6cDwP/OASDD8ztDxm2lt2wtvpMc/IuWsTdDxx9ZB+k5vU
	zwy5LxOXZjG+BbfXcUJIsAsLvOcGNWbxmkrR/uk8G+7sGh5yy44ztpMXPw==
X-Google-Smtp-Source: AGHT+IEPie/LlE+3kVfSpv7nMU1cGbMohmcP43fKLs5EiO82vjn4R9KMZs6wtsX9mwcVGgt3+EJkcg==
X-Received: by 2002:a05:6808:3085:b0:3d6:2f50:5517 with SMTP id 5614622812f47-3dad1f1e62dmr11085395b6e.1.1721426942249;
        Fri, 19 Jul 2024 15:09:02 -0700 (PDT)
Received: from [172.17.0.2] ([74.249.13.177])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44f9cbf236esm11789851cf.13.2024.07.19.15.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 15:09:01 -0700 (PDT)
Message-ID: <669ae3fd.050a0220.97f3.3ede@mx.google.com>
Date: Fri, 19 Jul 2024 15:09:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4137111375022817465=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [RFC,BlueZ,v1,1/2] main.conf: Add LE.CentralAddressResolution option
In-Reply-To: <20240719200716.1557861-1-luiz.dentz@gmail.com>
References: <20240719200716.1557861-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4137111375022817465==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=872614

---Test result---

Test Summary:
CheckPatch                    PASS      1.00 seconds
GitLint                       PASS      0.71 seconds
BuildEll                      PASS      24.61 seconds
BluezMake                     PASS      1677.91 seconds
MakeCheck                     PASS      13.00 seconds
MakeDistcheck                 PASS      178.43 seconds
CheckValgrind                 PASS      252.76 seconds
CheckSmatch                   WARNING   354.08 seconds
bluezmakeextell               PASS      123.53 seconds
IncrementalBuild              PASS      3037.06 seconds
ScanBuild                     WARNING   1025.18 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/packet.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c:1867:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3606:52: warning: array of flexible structuresmonitor/bt.h:3594:40: warning: array of flexible structures
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
src/gatt-database.c:1165:10: warning: Value stored to 'bits' during its initialization is never read
        uint8_t bits[] = { BT_GATT_CHRC_CLI_FEAT_ROBUST_CACHING,
                ^~~~     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
1 warning generated.



---
Regards,
Linux Bluetooth


--===============4137111375022817465==--
