Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E2814831F
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jul 2024 09:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720172586; cv=none; b=QmqIDqgYOAiRu1lKk1WiFVHy8Zv5X2M6dn7XuhQewK7B2qWrv/IBu8yFJ8LvwJDc+P1Qj2QOnq26bXDzv5mGQbhGLKN1wm18x3yDjUCOiMV+p1hIWCTGv74WRDAvZdd9Z8pJMwNn7EDK17UMTxaIphihAz50RzOzFLG/2nlvV7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720172586; c=relaxed/simple;
	bh=Vv6Y+NLf4r7Vou9DczILKVx7oX4izF24o+Hadtz2njU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=px4Uf1tPKQYErYOrT29TRNnTSKk8CPThLU1xfmesxL08c3PDhs3oF8UCaGXoKA3Ir7Rim85erMAOxZ7tupUAZR7BNZ8lzsJhNS9Qf/J2bPYsFCzAytFvcyBDrDEX+/jfHMPtEPammW35hnbN0nnNPGjaRNQH11CoexVfctsauS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j3CJ69la; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3CJ69la"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e036105251eso1455525276.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Jul 2024 02:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720172584; x=1720777384; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OvALuKvqBVhRllYV8OCOy2awQSA4Bdv9zRDdUyL1isA=;
        b=j3CJ69laJqTqoxlUBD3IHx0u7U7IQClQu9E5edtQxm4V5/9yyIcMCVB2IyPrdjL+YX
         GOFoazcODnF7ngkKFO/wdw0Pa/agdZU8F+ziHVHTegpDGgW4ZyJ0knLcjRGF0qDFVMCM
         1VymTt1kUCPeQKp3645kfj3f8r4UJLywTdmzSAgfHYwsQKBUTdLgbMyFbcGK05tybnNI
         5rwWqCdROL7aW9Iu/NNitopqdWMbWff6o9jMY6uqnWF1yOC95zrf0NnJVn8kdnn58vaC
         G5KoqUDRIr8ZpBWXIOmYc2bmzDVHG+iPTOSThxMB2moWRb6sdAMbNQ1CRDpul4JbSCPy
         toKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720172584; x=1720777384;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OvALuKvqBVhRllYV8OCOy2awQSA4Bdv9zRDdUyL1isA=;
        b=LsoNDMarAFAbpe2p9BuQBcAYgWMeH7zWqoUltjqx9x54Lwo+BhRQPdgDCTS0aHbUe7
         0BM07vqrrGKjFxNet5Wg/Om7SyvlkmyClfSq+IDaDq9p2vBvmVb1/csDnvtIVs58wtoK
         2TSXk8Q1Y7bAm1pNJmXWSteq0g7eaE7FtGoFwged/bQoBo8JHvKnZdacIAgWv8kLO5Ts
         ZVngwq99MoW1MX/08mzhY+HUhOBmEj23nrbaKV6sCfHWfbTkQnu+pWGWNauunqTfGWbH
         EIjF+Tk0AxIQBpR5gB89KsF/W0GKbsiwMEcdohDmkO9M++RX1mBYF37KsHa0NiNQ0XMj
         IUTQ==
X-Gm-Message-State: AOJu0YxiMsKsyI0PUqL/WEFa3KAp3c6m7+eFQtG3YOINproiF23yPpNE
	deCkI30CrBu5V46vsM/5qlzWEEU7QVaB9RlinOUlhUeasildKaMJEFSUBA==
X-Google-Smtp-Source: AGHT+IHOVyPIgi0AcQ/ZkHQBed0MeJ6YzjAX6UrZaia/hF31WYN9x2eqvPFfyC9H/LTGRxnXeeBHQw==
X-Received: by 2002:a05:6902:100d:b0:e03:428d:9da2 with SMTP id 3f1490d57ef6-e03c18e31f7mr4740010276.13.1720172584139;
        Fri, 05 Jul 2024 02:43:04 -0700 (PDT)
Received: from [172.17.0.2] ([20.172.5.37])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c6b48e198sm9223733a12.51.2024.07.05.02.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 02:43:03 -0700 (PDT)
Message-ID: <6687c027.650a0220.a532d.f36c@mx.google.com>
Date: Fri, 05 Jul 2024 02:43:03 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2291368523329364998=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_prathm@quicinc.com
Subject: RE: [BlueZ] Set BREDR not supported bit in AD Flag when discoverable is off
In-Reply-To: <20240705073720.13504-1-quic_prathm@quicinc.com>
References: <20240705073720.13504-1-quic_prathm@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2291368523329364998==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=868660

---Test result---

Test Summary:
CheckPatch                    PASS      0.32 seconds
GitLint                       PASS      0.22 seconds
BuildEll                      PASS      24.57 seconds
BluezMake                     PASS      1659.26 seconds
MakeCheck                     PASS      13.14 seconds
MakeDistcheck                 PASS      176.97 seconds
CheckValgrind                 PASS      251.17 seconds
CheckSmatch                   PASS      353.55 seconds
bluezmakeextell               PASS      119.49 seconds
IncrementalBuild              PASS      1447.26 seconds
ScanBuild                     PASS      1008.32 seconds



---
Regards,
Linux Bluetooth


--===============2291368523329364998==--
