Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com [209.85.222.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710113009DE
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Feb 2026 18:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771440682; cv=none; b=LWsS75B2yLdUsbu3RJIyyHh5eDEkHG6ADRmrNMRT0x6IlUIE+JtZA6ROHN8Mz+1YdacVPfO4mgaxhqA6a7M4NIidIWDvZY/ilKxE3smFhNXOwztexYDuQvDPDGvKYIBlPTwezMFbaWV2F7D6cvvzGZ7VUnELOgtfCBOCSNhjobU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771440682; c=relaxed/simple;
	bh=mOD27/k7H/JWtyBcGiD82vKbS9G5OMJIvakYvstmp3w=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=cFZttVe/JNHlUYQsP+t7hQoccZDfWmJ6Y0DKMjBRhqyvCFjUqIEr/CyYK5BIMNr9XKil31O57rHvbWkydzzV+HY5W0BbuiJtarHuJxNt2UH+IO/c0B5y/3ieq7VCiFZozg5eqGjf154yYqG9RSflOv68gdPiIK2hu9DodzdxVQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MfX4ofKz; arc=none smtp.client-ip=209.85.222.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MfX4ofKz"
Received: by mail-qk1-f196.google.com with SMTP id af79cd13be357-8cb40277a8bso11467885a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Feb 2026 10:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771440680; x=1772045480; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DpqeQez2rOEN11feRDRZCBISSR/kpcXJKmRfxHmDN2o=;
        b=MfX4ofKzzZevivxwIBe4RojMbG+/kor9cb9rodBYrJ6CSkeE4OV3hDVMRTgKSoF+Ty
         6ok9w+pVuB1EDzbUftSegYi1MVYweuiwAEcrLsX4UA7lkufpmCziq603ga2RyHkl3D2+
         /ZeqGcvza8qgcGK7tSLG/6IvzyUtw4WbdOkPTzU2XnVwQbtz80pxaoe1Q7KciNpIuNry
         xeP8BhtW0JBm3NGGL9VOLIhExy1+aau2NXYAUlRdEMvJQ9NytfTq5cwZKz/XaaPg3Irw
         a0PmYkF57kVba85Xyiu9NF1QtSLDJxFiXyCwI+1e+5etFNfqydbhVFXoQF5PBI2o3UbJ
         v3FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771440680; x=1772045480;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DpqeQez2rOEN11feRDRZCBISSR/kpcXJKmRfxHmDN2o=;
        b=Y3hpeJIUMzgieEVqonKBptZFdMKu6r728zKpQjtNrAbX/EgF4CmjQ3EzD3MsptgIX/
         1CRj1b0VH7rpkUBSnMkd2XMxLsUZJQt2HP7mg1oJQSmhCDxPo3nOEu3Fs5LJcIa5eIUo
         uAZnQoTI+GMQf6m7zSrvheCjlSNwkjP2w11iGo2olMowzeTqqiOoh/+D51KVaQurIvgO
         2oxZiAvkzjM89o5yJt0qHAp+CdBaHHTIKh2EtO7EmC7yo2lGmA5V6cjlbaGwBDxAlc/Y
         nJeDWvTkx+ooVjYH36CV0Y5towWPuccD9VfjSh+CXVLM5bdDSBwZKKMiQ7O9sYhuMjhD
         U/kw==
X-Gm-Message-State: AOJu0YwZcU1JnOq8h+sgbZhCBbnXnJoLDaqK5VNQIU87WESefqmMZe3R
	c2SS9nQ2RoDnJZ365C9VsOLeXcYlyBYF+gUnZCZ0q6Ho05RqvUCuMDYvR2L3pLkC
X-Gm-Gg: AZuq6aKCBiTj8G2ynB7NGz+4L6u19qxS3NM+BE84YgM7enZFFsMXfm6+syMSZLAmpha
	xUD5ZaGpxSfO71qUlyyefoCu4Ur9O4X/8uOwd7VgxhHsfbE1c4PQWB4NDyAAyhEds5PQV84l6p2
	F26lvJfTER1e3GEG5zzgQXnm1oTVxx5WCPBiJXzWKILYWPhz5tqi/wBOVgySuGXyhVZP1N5n20C
	nEz9NU5tDTU1YIsj2KKctO1L2Ichf7bPhWOqeai3TO7fJezKtw/D6PdT2Yfh1q+cY3TbZAe66Gk
	Jt4pYCrLPKRK0WY261G6fwzxCtJO24n+gXtkVhVPPenQPoHgJjnPXs857j1sG4Pwnxa897NmU4w
	BHv/+bhABKHrK9mq305/sQoXuvFQ2SKUPrEd9I6ykMQRTe5FJTEJiI+517NO1BMp1UPthlH1xrB
	MhMqOvb6sjq6X3DzMl6dyfFDHhHyk=
X-Received: by 2002:a05:620a:28d6:b0:8c0:cec4:b6fa with SMTP id af79cd13be357-8cb740ea9c9mr321753185a.65.1771440680107;
        Wed, 18 Feb 2026 10:51:20 -0800 (PST)
Received: from [172.17.0.2] ([40.116.93.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb4a395cf2sm1285893585a.18.2026.02.18.10.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 10:51:19 -0800 (PST)
Message-ID: <69960a27.050a0220.7b7a9.8723@mx.google.com>
Date: Wed, 18 Feb 2026 10:51:19 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8809132475832207278=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ronan@rjp.ie
Subject: RE: [BlueZ,v2] zsh: amend completions
In-Reply-To: <20260218175439.15660-1-ronan@rjp.ie>
References: <20260218175439.15660-1-ronan@rjp.ie>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8809132475832207278==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1055282

---Test result---

Test Summary:
CheckPatch                    PENDING   0.32 seconds
GitLint                       PENDING   0.40 seconds
BuildEll                      PASS      21.44 seconds
BluezMake                     PASS      660.15 seconds
MakeCheck                     PASS      19.03 seconds
MakeDistcheck                 PASS      252.47 seconds
CheckValgrind                 PASS      303.68 seconds
CheckSmatch                   PASS      367.78 seconds
bluezmakeextell               PASS      185.58 seconds
IncrementalBuild              PENDING   0.43 seconds
ScanBuild                     PASS      1072.87 seconds

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


--===============8809132475832207278==--
