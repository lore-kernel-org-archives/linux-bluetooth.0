Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com [74.125.82.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33747335BCC
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Jan 2026 10:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767954405; cv=none; b=fXRbSamwmaWG3sG3bTZHZaVT1Yhj+JLf87KYWxppoOAUKzESTAso8hppFRtxJKqVrUgIjS9uYXN1950t/YrVPXfJN/de9c8UcrRZIAurlkTEYQbFIHbBM927WxiMVAd1BgHSAo210K4Ui1wDlvFCiUs6TmB8dpPw+9V2sWmN/gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767954405; c=relaxed/simple;
	bh=fc89Ytq9ozczO4+6Wak5cSwd23mW+vy9RXzzSdxMRrA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=lzESLtKqk0G7r1G7C6n/21CpnP6fdAsYBOBmXJ4m9KkYiHwmK875xfBDwjGDGYkR/1pHSJp8oqaTAZhNyApnFZwvlWTujSNymHynxwCmlpl4zKQdnV/OcLZ4DCvFDjKta9+TddIz6lzxpmnvApgHSRbcHYWiJe9waOZlB4yF6SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lvnTNWyp; arc=none smtp.client-ip=74.125.82.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lvnTNWyp"
Received: by mail-dy1-f195.google.com with SMTP id 5a478bee46e88-2ae61424095so3792917eec.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 09 Jan 2026 02:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767954403; x=1768559203; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lAjPuwSJym0i8L6NAsaCjakw8/cddZvtfrEcTew/HsA=;
        b=lvnTNWypGqg8/RZCc/AXkWfNhrx5ROvCfGLlE3pqygAAcORBw6qnHn6R58HfMhkDpw
         AJPl+wemjSgOy3dFL9UjT5RrGoWisYzhrjdE5WL+BjgEgg2uM+vLGP1O/3kPBTsc1/rB
         eVFrct9GI/8Mg4P/zq/nUV1HeD6HmHoicXfvAVrf8V0tQjns+U6CYYA9Iy9zklm49RwB
         g4gd3p5W6ViaORQTbRHblvvP0pdFzupdUeolY0fc1XiVJwxovTpSModgmBkRtOj/J/XL
         zGT+9hdc7zIWKfEBJrJKPfJjG9+avM7QcmfJsWeP/lrTg841GZqdyQ9OLqamkUcGXoJR
         cUMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767954403; x=1768559203;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lAjPuwSJym0i8L6NAsaCjakw8/cddZvtfrEcTew/HsA=;
        b=OOsifS/KVJdkIDSOHUqoPyqTTQdiSxlCBadKVKCSBek1BljHU6LbCfNwmlmv49BWoh
         EK7mW9BB1A82Ler1srsIGeZZiQefeZ6D31XUtMtKRzr6snv5wIvOmWkYC9OMBIAv9prp
         xLrsxtAjNz6REXUIpryjsJHzcnc1DgEWbb2Br0HeuH5xL8JjYMiB34zcAG5b3D5R2NNK
         dEmO4Awbltq8DbebquhiVkIExno1drMCL5Hnwuup8dADvzJJzMcHZLIAxRRWOPBl7vOX
         RDHJiTDjbKJy79+JIvvcbUyfoeuuQQTo9+5gGLRFniyszrmb0JECq/0oaB0aqKhvVb/m
         Nhjg==
X-Gm-Message-State: AOJu0YwJgc4PEYeZgmWk4+vT89Vx83tKkyN/bZ6mseQNigTnLKG0Z8eL
	Dg4q6THcAaXtD5Zpu/ziWn6b3WYsRnTSHQg2VTY3pD/YstNo4PxSzqUZcwxvhQcO
X-Gm-Gg: AY/fxX6IAgCylFGxBXBx8qf4Pnpvi8tH7Uw5lXKjbOsDBk1QLPH1s9ffBKhFHlRkvoF
	rtPGOibSdbIha/R7xLQoqj+97t2xtuaFEf6PS4dy35pmOUzO6lWjW02E/1UyBejVIivGz0lChvT
	n+xIl75C5PrXz+j2tLZLCRxG1lrxTeYwrDQvQ6DdpUGKO5tI5pzKllQnUDb+ur4Aw/rqlh3Z6St
	6QTXkwTPNUG7pNEWizr8fzE5nbyvrt4HeYQzBigr9zRyglUGrSnrbH/FnUp3LB8N6rowyn6eToy
	wSVAEVchfHSpRhqIb5Qo5jpQC3x6zChdrlD980TW27BkD2AQv2wFABp0mjfSqhUT5TLN3k9ruU/
	hEd1/CE4TYIFXVlj5WyaQIPm4meMRa25JL5d7vQ8H4tieUb6erTpnK86hIlSviq0LxwO8njqhEc
	d99vE1yd4tU5lP3Z8eYg==
X-Google-Smtp-Source: AGHT+IGwJqB0xTI1EQsNd7+c9cbQDeOZmcpVwAp2NV0dFY9mkd+Z3SNJ3O2mmX01mGU0qXQI2CKh7g==
X-Received: by 2002:a05:7300:ec09:b0:2ae:2bb8:a6fd with SMTP id 5a478bee46e88-2b17d29cd36mr8731744eec.24.1767954402767;
        Fri, 09 Jan 2026 02:26:42 -0800 (PST)
Received: from [172.17.0.2] ([20.168.106.247])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b1707b3c44sm12592354eec.28.2026.01.09.02.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 02:26:42 -0800 (PST)
Message-ID: <6960d7e2.050a0220.19a744.39ee@mx.google.com>
Date: Fri, 09 Jan 2026 02:26:42 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5245188210940769508=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: Unit tests speed-up
In-Reply-To: <20260109093602.1224918-2-hadess@hadess.net>
References: <20260109093602.1224918-2-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5245188210940769508==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1040361

---Test result---

Test Summary:
CheckPatch                    PENDING   0.37 seconds
GitLint                       PENDING   0.40 seconds
BuildEll                      PASS      18.70 seconds
BluezMake                     PASS      633.86 seconds
MakeCheck                     PASS      18.63 seconds
MakeDistcheck                 PASS      217.16 seconds
CheckValgrind                 PASS      276.15 seconds
CheckSmatch                   PASS      309.87 seconds
bluezmakeextell               PASS      167.47 seconds
IncrementalBuild              PENDING   0.41 seconds
ScanBuild                     PASS      913.96 seconds

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


--===============5245188210940769508==--
