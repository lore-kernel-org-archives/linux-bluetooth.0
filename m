Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FE41F4C87
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Feb 2025 17:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740762844; cv=none; b=PJGYCkl2OdYVsA7ujv+VI3rtUkokFnknOeAHhf2XnWsd53OE04gAoPx/Z5ZmZ0GCmw6fbbsJ42TXZ0zkyBS9D/bsmRt1cU1BDtP625Sf63TZfvA1z2fJSzSmZz3FqtOMWug9S/dR9Ef1wFsnJSGI6jJyxFBMpNN2Q1kQu0TEe7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740762844; c=relaxed/simple;
	bh=cxKGRckI/OGc0rJD8/HkVs5QYhqy5smaNfTk8aBWH4o=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=FSECaIBHBYwAbgIgTYZAtUzS/V1Yts/4aiC0JMAZpU/3z04hActYHl6xKQOHJpvFVvbM3O5RqHhiD0bcr39KCz1IJMeQVl1kBl7PTNir42xtmibz+ZVc/MEGMvDucaseGLs1fd3vmGyZvL8x94sOMn9GU8IfTyHYOQgQXfdZ+6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P8Z7ZVrC; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8Z7ZVrC"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4720a115d15so29828951cf.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Feb 2025 09:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740762842; x=1741367642; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=v/TOZo7eN2O21HLcQTIzRY1nXmq2fy1mx8RbAaVZMwQ=;
        b=P8Z7ZVrCNJ/NPXV5HFm6PAmUGHNvjObdueOujXx18XAecmf1kT9pfixGz7uWq9uQdu
         4gwKxmcLftvbyfPqiFFSsc9ds7xfCpTQHqMNlxI2fxJxtgXyo6Ouqi9gwXb/2QJpewTP
         wT32l8tutN3Ritg7ggHh80nMgOwOgZjkuKnfAXGORJRclTqvoiFpL6yaWpzZDbMgzscH
         ShK68eQOOXi9t9Nfilaw97JWlSzUVHJLS+JEJrLQWVaXR9XTMzoNuDjbZ5WZ7b4gFxir
         KDn6Qf0swRj9AQGSBMsx3xA65LfkVPfeOvpZQFdOZcSBc2F0qqoO1n7qYCDcIsmj7pay
         neeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740762842; x=1741367642;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v/TOZo7eN2O21HLcQTIzRY1nXmq2fy1mx8RbAaVZMwQ=;
        b=HiGIlMzK0DKCX0ihX9VTMC/nbHRtiijO/jPAS/kOCFRJmG/Ww6dhmt7LUWJ7eujp7t
         3yYC9FSFKIO+WalW7Scc7XMiOCaB74kvkh1EMd6UZEL8I/Y7kmKKxp4WTjvF3mQi+ist
         +R5kf9T+qFkuDLFXgATh931roDD/olaPZQTam5m9uLnCkB2s7T7I9OQ3wXUkwD8N7AQq
         hZ1u5B0FlAGpUzcJTD/8eZ7ExL57t6A4h9AnxEfBFTTSs0nhGjmFNGDS+6g3+7gUEB9c
         Hx3iYsPbuelyx3fGKqKoAbsLvohizSNPDEx4ADWC+3hMrCk6fO2duCwH+4FYzAu9wWmU
         JDFQ==
X-Gm-Message-State: AOJu0YwE32Mb1TWGjIJzCVAkjWJ1zm41bvILOO6UFmkR1LjIyPw9JsVW
	YiOp0miPEjOwwfSayyiKm0o+qpgobmNYnvfOdo0BTmtowVTmWVkaloIfNg==
X-Gm-Gg: ASbGncvCmbphnSaFFEWiTGgnf1r3pzWYZqYKomDM31gDcN1LVP88sezoFJLANvGq25u
	ris79j/mRlrDoYVnIVj4EiChxlg1eALV656D4TSQMyb2yUqNShnJyT8Mb3UrVs6sV/JQPX9C7/F
	l7DKaQxrTJR9eK0WCc6mYHRbr33DVMGR5Nh/TaDomi/0835l/i+82rezDdSFzK6AwKl173Tlk9j
	idx5tWTyuGQufxlvpsD2WVvCCKUwQsd4pFHHL6PRGcaBjVRIU8PHvGn2LIRV6GCiQmh8zxYAsbk
	teYAVV/TRAGhiWYxKufJTXcY4ykB8Q==
X-Google-Smtp-Source: AGHT+IFkvo4RFYTYyHgqlWhjmDjYk/d4F1sIQ+JVSHjX/4rLFSypmMQyAYmK6kLA25vzkdl/d/KQOQ==
X-Received: by 2002:ac8:58c2:0:b0:472:2bc:8763 with SMTP id d75a77b69052e-474bb61bbaamr69965161cf.17.1740762841744;
        Fri, 28 Feb 2025 09:14:01 -0800 (PST)
Received: from [172.17.0.2] ([20.49.62.91])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47472430d89sm26691491cf.68.2025.02.28.09.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 09:14:00 -0800 (PST)
Message-ID: <67c1eed8.c80a0220.d5ddf.a8e3@mx.google.com>
Date: Fri, 28 Feb 2025 09:14:00 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4075174244285329482=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: bass: Register broadcast code request callback
In-Reply-To: <20250228155634.57979-2-iulia.tanasescu@nxp.com>
References: <20250228155634.57979-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4075174244285329482==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=939060

---Test result---

Test Summary:
CheckPatch                    PENDING   0.21 seconds
GitLint                       PENDING   0.20 seconds
BuildEll                      PASS      20.29 seconds
BluezMake                     PASS      1492.29 seconds
MakeCheck                     PASS      20.78 seconds
MakeDistcheck                 PASS      156.58 seconds
CheckValgrind                 PASS      213.97 seconds
CheckSmatch                   WARNING   284.04 seconds
bluezmakeextell               PASS      97.48 seconds
IncrementalBuild              PENDING   0.22 seconds
ScanBuild                     PASS      856.19 seconds

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
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/bap.c:313:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:313:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:313:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4075174244285329482==--
