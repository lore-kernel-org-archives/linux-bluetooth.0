Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5261B1E9B31
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Feb 2025 17:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740159492; cv=none; b=GwCd3M38RDlgOgTvK3cGAvArU6qUfhe1C2PjLFbxIbD9jMeCLUJd5NO/KIn8R5koL5Tg+cVVVEFweZHrnIJ7p3SPQHVT2+3VcZPnX6sQP1+ESE25U5y1ZrJ0O5StG3bAhFZcXPzPxI3XMv9WZu+05nKCues+wYq2GACMloNDg1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740159492; c=relaxed/simple;
	bh=rQO+CWtwLBDEpdaSWR7P/czI+ajYV7/CN5tg4yLqTaM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=daureGCeI8N77VN5h8tkpmaOLK2Zl8VOoNuTq5aaF85HZfUckPm1VRsH8VNg15bfqHxgs3e0ReteL9gYgMK02ct01Tj70hX47B0+A0Vow2Il0zivCzckoxBlV1E5XtXEdcTgQytGR3kGT2h745x6Q0JjgaGn13qUJZgXvLZrdgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cgq/igju; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cgq/igju"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6e66a7e2754so19132786d6.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Feb 2025 09:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740159489; x=1740764289; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FjtP6ViGQW07XfYL8S0OSY3EfjKCzfypCZqorwoIzfc=;
        b=cgq/igjufygH1RzLw3hYuf3Mkog2Eb1dUKM1x2K8eOZgOOXWV006Mh+1RYgMPOahTo
         sbe5BkulZQy0TBTh2BnHIbrGPKZZ3gw3ZIgjVw7HX5xbe4Lpe55F6IK0an37MelWUjKL
         hEhnk8y72Tw+r1JKlzJ+rnOdG4lJXjo+Co0Ra0fhPcq1xiX4P1kvOgqUE2/Kzil2MtP5
         qIfUuSAoMBOQcTVJdFNpvyrmbba/8QvOlZkncwK6Cz3ZMFeODKxQBgaNjBiATGEwoVw7
         c5R+VM0zL8UVJbXCQCJYTP1EMkJ9OlWySCtRq9M1gP95IplcJ1TUDyQ6G79y1z369YSJ
         lCzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740159489; x=1740764289;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FjtP6ViGQW07XfYL8S0OSY3EfjKCzfypCZqorwoIzfc=;
        b=oJzSBZkuej9JXuuCyTORneInEdDSS98v4VHR96AnSBZNPcvH21bbC6VaAZjm00Dmrv
         ezavu1GvLHxrx/W/QnAIpmg8IwyHPPJvc8evUUGGJDXrROa2Z8z8qQ7ZMvDDzNA30BfP
         Gnppj4BH/152M5IuLh+MWb+myJTOnFUqPnJCjSiJ+wQELCwd9SKozzrwcz+xrNTyuVn7
         0GNKJGOxCpIvQA0bWgXc3XpCnNu/RPQ0S497imMwKNubd+ALEo+pxWHJxVf8ptQ0+n8n
         sEMazzoMSUytsIutjTqBhvrR7jz0TB6Vz0MmCkp8VAFaTIePnIU0d+j0AiDJuIfzWpjY
         v+FQ==
X-Gm-Message-State: AOJu0YyChPpt0rJGy8lGbOtVn1hyCb44hcuAlSZhvbJ5HqjwkoGjZq+j
	1xkNRg7DH1koYPBQSSUlCgxgN6lMiDJCuKVB33qbwvpsjbw67u5kvHgA5A==
X-Gm-Gg: ASbGncvaqDtG5CBP+2YQ0/YucN5HmgUBhzJ8hYLvwtjMKbfrLsrupMsqR3jAoCZH9oE
	5b8t1wWlhYYtCHtxOyZdHE9vSjhF1wPcHLxAhI6bmyZXtHU0Bh0ucJAUUOZGfIlgN6us2brUIvC
	Hpses0t/2t76xNHNKVTp8PIrVGHm8vSU0TxIIzVSEcbOPFwUCvDK55EKp7OyyR2wK2V9UKF5Je0
	6m2pkzF0NAIEJi0xw9PNYBrF27APhvIQv03Y+hiJPQ9E/YR7BMrulK408nLHPiYh+YjWomORPpX
	CVzdIPE88jIPUI57NWib9utJbyIT0+gB4CA=
X-Google-Smtp-Source: AGHT+IGrCz0jLYGkz0uExSvzS6mIXwDMg/WFFL26SeTWbvfdD9egq3bEFwo2BfsiE+FbnUznNH0fyA==
X-Received: by 2002:a05:6214:ca4:b0:6e4:3cf1:5628 with SMTP id 6a1803df08f44-6e6ae7c96c9mr54507726d6.3.1740159488917;
        Fri, 21 Feb 2025 09:38:08 -0800 (PST)
Received: from [172.17.0.2] ([172.183.174.153])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0ac2bc478sm489420285a.21.2025.02.21.09.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 09:38:08 -0800 (PST)
Message-ID: <67b8ba00.050a0220.61caf.8998@mx.google.com>
Date: Fri, 21 Feb 2025 09:38:08 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2504603923778200067=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, sarveshwar.bajaj@nxp.com
Subject: RE: shared/gatt-db: Fix incorrect attribute type
In-Reply-To: <20250221163139.1705-2-sarveshwar.bajaj@nxp.com>
References: <20250221163139.1705-2-sarveshwar.bajaj@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2504603923778200067==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=936519

---Test result---

Test Summary:
CheckPatch                    PENDING   0.22 seconds
GitLint                       PENDING   0.22 seconds
BuildEll                      PASS      20.67 seconds
BluezMake                     PASS      1602.50 seconds
MakeCheck                     PASS      13.61 seconds
MakeDistcheck                 PASS      158.11 seconds
CheckValgrind                 PASS      214.47 seconds
CheckSmatch                   PASS      284.87 seconds
bluezmakeextell               PASS      99.24 seconds
IncrementalBuild              PENDING   0.29 seconds
ScanBuild                     PASS      884.86 seconds

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


--===============2504603923778200067==--
