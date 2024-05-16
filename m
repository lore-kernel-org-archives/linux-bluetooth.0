Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FAE145FEB
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 15:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715874059; cv=none; b=E7Hv7tzxOPIKlemUH0JmTG9RD5c5EPFdxZ/FLCpHGTlvr68b/K9Z6i6QyCLMNYwXKxFGAie7JEeHSj1lHSmxgtCAm91WdsIQ59vJk7CyUcluTxH304mjVFfn+fqOdRF2F8SulwS1gA4xDKgOIx6Wo4yOPmWkuPKTbuMzA8kTqUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715874059; c=relaxed/simple;
	bh=5BRNop2q0Sac9cHe52AUxNXoBVcE/6x6zEu5QjISEhY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=X+tE/OcQWShzZgEsv2iFYZ4K81cfqixnlrVinoyqnJXl2ZcG+NKxSAeIxWl82h+TkqrUW2zoOwPK6ZfFopH5wknwsnq4nP5n5R3YIxUh+ktjlB/E5M0AcVypHLbx+MmUUnbu+msxGkUZbz7/UAdedDo3h5cb9L1iNinXPaZLPvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DVL7D1gO; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVL7D1gO"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dee9943a293so4599961276.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 08:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715874056; x=1716478856; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=I1nYyxmFTqvubwVIAsZtB6HnkNEkH+ZRM2f2XbRyygU=;
        b=DVL7D1gO46wfMLHw6iUwYMOrCrxG+mM1QibAT3tMhF0EVL91/icYPBkgZfxgeq1eAb
         Af4a+nZHyQJntI2NJZcfvyyZ5DFI9aiQpQxhj9g3Mu67y6GHZUj15h648Cg7mQcI5s47
         L71gHudyakcVSfKAyShvifR0iKo6Vd9I6//oaUxMPoWnTXNf395k5BJTLhlPogoEfP3H
         m34Jq4B8K/geHYpg0TDTEgNeJiOHJa3fPc+oW8Ip64wXn2lBvMTKjcIZZ1eyId7OWh5x
         o6qq8Cmw5hny9HLIPkwdOhGEzKwg7VVlUASxtQTiXDE9i5RimegxvvGwbKuQwM2r1GzH
         LL6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715874056; x=1716478856;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I1nYyxmFTqvubwVIAsZtB6HnkNEkH+ZRM2f2XbRyygU=;
        b=A/H7VNLhMiKxF2GmMJRDiNOAJTWI97oJqPXwcZdM55pZPt39Jo2OOMUeJ2fiQBZ+u5
         j9Hs8WPEJ1j1jP3a3T9AaeEePEJ9jVB1uqZnQpIkmOwrtwsKkL/k3Fwm2b9PDvIJN35p
         LtU28GgGCQ8CQwgMf/GfQZDV9JCyv34qEW/VGn/R7tNHuZ9s9G+RQZU1zPQv+JWmBLy3
         JURrR5HUofZrmUlO2HjWcAxYF5nM8SPx7toKc4/LTlKDrfEhvuRJfuX3oSDo/E0hW3tE
         9i0GcbEUWzdh8wKTp3HEh3WXzNpbHMElzXZh6CRlits/02ZwIc5/w/ya4IByv+BleDdI
         EhnA==
X-Gm-Message-State: AOJu0YywACqsY3GUbKRgj+zX5IcXU6jfNA5CddqvvFA7zY1fhUrWtdln
	X2Zo/vQO8dNBIzxAX+DUGx1p4YcSWf9bxe8+zUAplrFV3uT5prgjbAytuw==
X-Google-Smtp-Source: AGHT+IGXY6fa420PcxNlgQPf99YGsh7PH6TBxq05fw6EQ67ZvV1RSTqstgco2kTzHLJleer+cEMJ9g==
X-Received: by 2002:a25:33d4:0:b0:dee:600c:8b6c with SMTP id 3f1490d57ef6-dee600c8fdfmr15197102276.16.1715874056235;
        Thu, 16 May 2024 08:40:56 -0700 (PDT)
Received: from [172.17.0.2] ([20.102.46.176])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43df68acf20sm98817561cf.50.2024.05.16.08.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 08:40:55 -0700 (PDT)
Message-ID: <66462907.050a0220.d27c0.fd63@mx.google.com>
Date: Thu, 16 May 2024 08:40:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0322401750336211471=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: [BlueZ] obexd: Fix memory leak
In-Reply-To: <20240516134053.102475-1-hadess@hadess.net>
References: <20240516134053.102475-1-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0322401750336211471==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=853719

---Test result---

Test Summary:
CheckPatch                    PASS      0.46 seconds
GitLint                       FAIL      0.51 seconds
BuildEll                      PASS      24.81 seconds
BluezMake                     PASS      1701.13 seconds
MakeCheck                     PASS      13.71 seconds
MakeDistcheck                 PASS      179.04 seconds
CheckValgrind                 PASS      250.72 seconds
CheckSmatch                   PASS      356.39 seconds
bluezmakeextell               PASS      120.95 seconds
IncrementalBuild              PASS      1481.59 seconds
ScanBuild                     PASS      1015.99 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ] obexd: Fix memory leak

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
8: B1 Line exceeds max length (121>80): "bluez-5.75/obexd/plugins/filesystem.c:411:3: alloc_arg: "g_file_get_contents" allocates memory that is stored into "buf"."
9: B1 Line exceeds max length (115>80): "bluez-5.75/obexd/plugins/filesystem.c:418:3: noescape: Resource "buf" is not freed or pointed-to in "g_string_new"."
10: B1 Line exceeds max length (126>80): "bluez-5.75/obexd/plugins/filesystem.c:440:2: leaked_storage: Variable "buf" going out of scope leaks the storage it points to."
11: B3 Line contains hard tab characters (\t): "438|			*err = 0;"
13: B3 Line contains hard tab characters (\t): "440|->	return object;"


---
Regards,
Linux Bluetooth


--===============0322401750336211471==--
