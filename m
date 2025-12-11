Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09C51C7012
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Dec 2025 19:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765481869; cv=none; b=JVv+1XI60XqRhY8J22+2xU0tEKIPDc4rdwsQxV1qS46luBpz/o24Hjwy1UipJWgMBp7S+jHS/pAoFeWcGlSG2tJsXzmxbUOI1R/5X0Qz/yoP03xxamFG3BmhiIKwgqHLWwoumiPrkVcPSMd6UvEpcxrfs0RXlL0ERDu4G8Jw37o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765481869; c=relaxed/simple;
	bh=3U9gZ/8hsiF0CUqsiB7u0Xzt3xH/yFeYGEwbxmK73G4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=jvNTiQLcGPy8mR2o7ynPDs3bOTenkKbmCQO5MAPSJkg7MLVC/rA5XT0dgVp4nWedy8z2FyJUBuei6GTLGbzcnQ7Vis9WtBr1gE082QtMedaW40LcUHwt3hrRNl2XKCrry5ylmAUXsSgTBRlKsv+Ik+MC2IZQEkYQBtWL5FeTH9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eyIaMeHY; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eyIaMeHY"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-bf1b402fa3cso425856a12.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Dec 2025 11:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765481867; x=1766086667; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5cSD4HIABNCPl9U/6sckt9B4hBKChuvzdazMwTOGe7M=;
        b=eyIaMeHYZM7F4KSU0vjSyELuEjga38vWeN8eJCCD5lup9rAFqbt7BgJMkUcrhl98J+
         cM35nUEGg7I9QZTqXp/q/bA/qIQ31h5Ti+VgI1NCq7FTFPkC+FWzA6wLM23quG9/qi03
         6lFBBs96B2oyc1smF0f6Hu7U6KA0edl6wpdaDwifDGhBUquROZ8XLcO5grSkn4VfmzKh
         yrjhgSaaftacyaOiWkOwv/Wv9qPgwJa8Jn+tLKqhtPH1FUcMhWP/25PyfsQfPGRP7jAh
         Z9vdYDWIt3Bnc/vBNhWkqw2fxWU6lJTK4k4N23PRm3QwRNH3o3xApQUgNQVmygZKiyJY
         XgCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765481867; x=1766086667;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5cSD4HIABNCPl9U/6sckt9B4hBKChuvzdazMwTOGe7M=;
        b=Dar8DcYeQGcP2cMWeygtu/PxrevUmxXeLRTvsHBEjDESxdNMBiZblGX4V0VbYMFZHJ
         crCrPTfSwkert1nxpoTjzJn1sVv2cREPp6lCnTcyMBdaWYjV67Vr0/qY6t5FlhMjabBe
         qBhxRnk5RcxoY0Gu0QibxGkj8y4MkIcZra2Axc0VS8DltnKcw+CUZqQF2YLkg4SWat+8
         1ckAHNdxAG1yXuHxISJfUemvhoJSaWhnbu+GcYHfEikIKz20Y63kwGDKXXtsRAx8HBjg
         5JI337x/8b4Z7trwri/EoSb9pDMHDXd5RWQKM2PmMgWSn5GGMSlVC0RiYL3TDssw/u6D
         hg8w==
X-Gm-Message-State: AOJu0Yw2dsbM1i+6odAP2Fmk63EvxIp9aKHP8M1sn2PsRjyhdbUg5OvU
	+ze52IgpiqWrBgcK7dlPXDBJw39Fh4j2ycVzqpx7L1DP0cbCnFAChmY74jr4j3yu
X-Gm-Gg: AY/fxX62y2Ga1/Trgtg5vQjMrQp6CK8fVyJd85Yt3LjIpzGtBCFuVTLtFERG4K7JDXp
	XirX3CKxupy5Q0gEhqkbvehduA6jLvF2xqYJ3UZNrsqLQhtJ3dACzjT5PO3hSgbOasYuC+s++sW
	TISs1S1DfaTVGteJV1e0T5zHou7BylN3ymRw8tKjTCd2A6fzvf+Xc8t2jR/kTaN0VtG88KB3sC8
	WiC/Kud/3ZP9QgfhVmYeeKxOKG8b7v6+H/CZlSIqk7/UHBFxYosXoxb76PNnY7VBuWk+rJVlPb5
	miL1QEQUdBJWc7XaBCRlWsR5dCXx09xJylj4viC2Cog2w0Q+fcBJj5Vyrnhh0ykLylnatxSQW3N
	lISLlQSRNyshltC+rF7DVVth+gAfsmfAfhAu5aIfeiZH9L8EXHgmgCcRBut3r5Uy+jGIS7y0eB+
	/N7tcQ+3dXxYro3ESb
X-Google-Smtp-Source: AGHT+IGKavMpFokHbBaLypVf7jy4BscFyF21O+UXQYyiqFR7gQ5J63eSyRE9+3ShoDvHByhDnZ3Epg==
X-Received: by 2002:a05:7300:1821:b0:2a7:127e:bff4 with SMTP id 5a478bee46e88-2ac055fde20mr5630623eec.24.1765481866546;
        Thu, 11 Dec 2025 11:37:46 -0800 (PST)
Received: from [172.17.0.2] ([52.225.73.167])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ac1920fceesm7455202eec.5.2025.12.11.11.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 11:37:45 -0800 (PST)
Message-ID: <693b1d89.050a0220.339858.499c@mx.google.com>
Date: Thu, 11 Dec 2025 11:37:45 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6279017967495971193=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ,v2,1/5] doc: Add new telephony related profiles interfaces
In-Reply-To: <20251211183429.419619-1-frederic.danis@collabora.com>
References: <20251211183429.419619-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6279017967495971193==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1032412

---Test result---

Test Summary:
CheckPatch                    PENDING   0.33 seconds
GitLint                       PENDING   0.36 seconds
BuildEll                      PASS      20.34 seconds
BluezMake                     PASS      654.40 seconds
MakeCheck                     PASS      22.25 seconds
MakeDistcheck                 PASS      245.83 seconds
CheckValgrind                 PASS      306.49 seconds
CheckSmatch                   PASS      356.69 seconds
bluezmakeextell               PASS      186.03 seconds
IncrementalBuild              PENDING   0.43 seconds
ScanBuild                     PASS      1055.47 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6279017967495971193==--
