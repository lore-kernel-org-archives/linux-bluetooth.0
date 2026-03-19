Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B387039DBD1
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 15:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773932572; cv=none; b=guyPnCniR4jB0jEKrSSWYKgCHNlE2kTm320fpvE9WDwcntU95y8pjWa7YRT81k9eZfRYxe+IFeuiaJDQbLE08/BnSZUU8g6JYiE93Vb//snw8vpQdMvfiuHxgTpet+0dtjNLUKs3c69rikrBGhXQD08mk/IS/yicGeg4PFDf/gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773932572; c=relaxed/simple;
	bh=FCoDEpPkxguvfbAHewT9lOX57pIyTamAOfDcZIhhjwU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ZhQRg4yuXOZLQmUGq1JsZHlY4T15FqJ4w7rAWnSE1U575ohZTYpSmRHaCm17f1PcVoKxHgV6V89JbOy/glJMs8Tv0C+FYSt4P7wNMSJFLO6ISz9g1//i5GQ+e7pSDOELBZG/rmmLFWLdTnj9XrRmep5ErrRGitPt2Qq2vHQOgew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W92S53ik; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W92S53ik"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-509134ab2d2so8471051cf.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 08:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773932569; x=1774537369; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xBxzQa/uSM4Hxf5ktNu3qerpNbskTAEfvP+YHQ68cqU=;
        b=W92S53ik3wmBch5jvzZw0c6tnj947KMeRcO+dXjDgGZJdoEOV4W8SoSWqfYqYvhknR
         ztNqzi7ZLdLRtX0JFSqP8LjSIv6J/+VhMuZvy4xCOzu9QHJPjBEQcuyRiUot4m2ikAFg
         02uv5iJC2+JHIOvgGHu/07HPAxTjN6mFk9P0QQ0izCv4I+IJwbPpkIV9nWBk4Us4XDUy
         VTrFFT7n5jO8eUX4YhoW2J2XNRuvUOb4oGmvy8GxnxKqbmQDd/qF6QgUwZKOhp620Ajf
         8Zf648kFfRDgOzDxC2eWU+6mn2/kXGbZ4M27e0T0HMRcGetSG4quA8M55c8tcjHnx5eh
         HXQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773932569; x=1774537369;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xBxzQa/uSM4Hxf5ktNu3qerpNbskTAEfvP+YHQ68cqU=;
        b=in7TKBnY8Z9pD5tmregFabKMcM+i/MWbvSzTv2aKmUYv3eoZ2cWOlegWBI6g1yUA+7
         LGLKfdhu6ohiKhwE30ro9t0bHQawe8W1hxcRbIFUfrTiIyDiP/NKbKs3m+dWtmu6KWLv
         YWC+qi5ZxxbKqGGHkdoTAsMlGuPWeP058ekXmd0WKiR5ZPMyHQCHbgxf4F99CY8S4f7L
         iTqKRZ0WTvRtVjJx7uauVEqoh7AS0oGee3eIjaodmN1rUT6e6qz7AD2+gRON4ruYdKGE
         ldz9P+D3y+GKkaGt+ZRtC37cqBkYnId+p/rAxd0TgsXwzXPVf0UiHDnvWL18Wtfhm7oK
         tNRg==
X-Gm-Message-State: AOJu0Yycw6T2FOHMHN7QAuZvB4HKGA5ULvubruW23RfV3FS9zfJqTx8v
	j51Cmwpo5gFcz4DLtHcw7knHIBDPC16zRXOvROZoVAx6odT45TQzjts5PpoZhw==
X-Gm-Gg: ATEYQzxdUbrTdkj+Ee7D2nOBrgeMi1+HM4SpXdRWbX9BLNa1B8gLp32RHxVT7FEa7i6
	Xp8t+D8RwHyBa1FdFuxvJpr+qmYzq55dNpj4jO1M+gWWgEKBAjkAj49oCLN5VCJa2rm0MzAWNb3
	ndNw0UFAXNtpE7wocVPXWFqqkx9Y+PV8KhztHNrggP92XGaB86KlLjq1EhjuWOLB4vA4o6ieK+8
	wDiQ5+933wOkJTCPG9/BtXZByUyTNcdfXyyCfzg/l6/+uCcfeX7hZnqpq9KaXWuuc+vF8+E7YVg
	AhztHR3MBsjoecmEuQIzI6Gcb2pz3jMX0QOA8hHZVXu7xb13UBi6FkGTT8hc8J/lO7pUflrFtp4
	xLuFmWNJN8xGssYgGll8iobn2ioh0ylu+XS79+QfBxALoFTWD5AEerGu9lqfvOm3nku2lo0GLQa
	aJtQeRRAjArZo73brICyEOSZMbZ5iE88w=
X-Received: by 2002:ac8:5709:0:b0:50b:33be:c1f3 with SMTP id d75a77b69052e-50b33becad3mr15955651cf.10.1773932567687;
        Thu, 19 Mar 2026 08:02:47 -0700 (PDT)
Received: from [172.17.0.2] ([135.232.177.161])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50b134ad813sm49071111cf.8.2026.03.19.08.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 08:02:46 -0700 (PDT)
Message-ID: <69bc1016.c80a0220.12d4e4.aec6@mx.google.com>
Date: Thu, 19 Mar 2026 08:02:46 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1884170234803529863=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: shared/shell: Fix crash on bluetoothctl command completion
In-Reply-To: <20260319132720.1517783-2-hadess@hadess.net>
References: <20260319132720.1517783-2-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1884170234803529863==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1069297

---Test result---

Test Summary:
CheckPatch                    PENDING   0.41 seconds
GitLint                       PENDING   0.41 seconds
BuildEll                      PASS      21.01 seconds
BluezMake                     PASS      651.40 seconds
MakeCheck                     PASS      19.20 seconds
MakeDistcheck                 PASS      249.49 seconds
CheckValgrind                 PASS      297.12 seconds
CheckSmatch                   WARNING   359.34 seconds
bluezmakeextell               PASS      185.96 seconds
IncrementalBuild              PENDING   0.42 seconds
ScanBuild                     PASS      1010.58 seconds

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
src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



https://github.com/bluez/bluez/pull/1974/checks

---
Regards,
Linux Bluetooth


--===============1884170234803529863==--
