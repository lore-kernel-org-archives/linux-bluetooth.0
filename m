Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753553783D1
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 12:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780921294; cv=none; b=jMne8JpkGwp/4I/SoesotxqVHwJJzt3lufQiiu38t7A0i/AUT9a5vZz1gipeWitNURB4IvNc4wR5UHuEC8QvVhR4YT8Dqbk4xxbJqmwnharCQK7jj4JfEzHKnBROpA1mvyxTdEwfAE18oO0DbZLJSzi8tXG/54bFTYtwUIeU67E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780921294; c=relaxed/simple;
	bh=qO0CF+C1pq3hygwZ7QVH2mj+nZMyNK2SeG++vgIGEPo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=PEPKnEXkM82bDjGqsvIeCWqTP5E2+uEN85PIUZ1S5HBNal69QrLQ3lb7X2v09tsPgHtllFNao7MFntvf9UjagiewRL21ySLOqV9lFCTXUsrE5tIabh8qX1MUCEiE1SS43ZUHPIJWGJqxhyXexC1VCHSXYzdQNQbyo9cB8vXxHis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X4teNBza; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X4teNBza"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-30759632453so5794309eec.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jun 2026 05:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780921292; x=1781526092; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fiYZSjcnbU8gyPT1swUpKbbAW+IjtSGXouf7C0Sg6/8=;
        b=X4teNBzaQNh+hJu2FkzjnUzbzEF9+46uCO7bzNZjAJ0goGYw8HxitRN6JP0nH5zr0g
         5hucP6fCcqMR6mXHnAuTrGGWeVqqMcRcSOIA5kBiFUuZRMe9MzhjW3JV6p6vfOi4Q0la
         2o+SUhLj8H9ySM6MQGTJPD6SL8oG0DOWdEXXpve3x+6hGDg/7X439SR3+waTCDk79IFS
         S0bHwpcbzsdrw6bon6rT0LGKyRm88blwmlh8Ufs+AjWwwguSCYjrZqYLAyNqH6PgXyPP
         moSR36ybH3AXs1QeTWMTtzF63D+mN/0N35D8MPsB2N3g83S/iTXSfFDCgrggoUdBwvAa
         oAnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780921292; x=1781526092;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fiYZSjcnbU8gyPT1swUpKbbAW+IjtSGXouf7C0Sg6/8=;
        b=jtwPgEsuXG5MVuIKfyChVS5ARTLoYMBwsAzodXq1eufcbDYRPMlA0HtNOGB2tKfkAu
         uLnyrQTAcZHKZuBQZ7oCMZX/VHAQLsllpJUnolkA5Y484c6SeZzfDmoaI3b9wfbQLcOH
         oi9BJcK0aT9Im74ah3jyBsSkRLfu53f+isaU8AUko3B9To43edEN02cFOMCiDpEA066V
         hwMw3i17EacBl/S2zvXH1HKAqHzwrEd3T74zfk6fhP5TbHw26k5355VPBZz/20LhxI16
         jOL2hJduPYdm9o7yjzpSCZD4foIwSoimWv693NSfex987vKT/kPq2l8D9kWAgQdHbSQS
         c+9Q==
X-Gm-Message-State: AOJu0YwlrpCbyo0j5rbtlGxN9AslvB9UPRTDmfboq3Zhg4U9fpRKGWLh
	zSMhaLfy2ovSlskTEHEeGWdFXeLDBq3qKzVt5jHzRDRM3Dvb3MTBGnYjiKQfSg==
X-Gm-Gg: Acq92OFUIx0F62R6rOXUvIfyJtz0EbZ0IF+3aIXrdYc2649rGZozIBNWChou8H9qbhQ
	J33q13/uHRMRIQU2VFa5NBLWcdrDCKO32R2+k/t3+nR8cGg47HL4Ombox2QGKQP0Pd1k5WUQrnJ
	j+SMeo50gmrfVb8rjUdXQqjFNbw2MySWOKTk96n8Twe4xKLnrNB4rQ3sT73j/eo5C15EH4QfYUt
	FscPOglJre1PX2XiKlL7TDqzPff5g+e7ueDD3yJxc60SuOyzUhtyp3VH2mwcrEEWcwVHSxAXCzW
	EOUK2kp0Ec8dQBLqIBMAmkZow/O/TyNrsGdrcH9484x8jDjQRJXLzQD3ksPqKMh+WH5mta5PwDn
	QwuWHGtceWkw5mgUbObodIQOll9sArjXe+JHQZEM9Xv1QxxJ/Pc5fyAY9qj21I8twFJML0BFoQ1
	Ddb4cVnHJgUX5dVBfsOCf+nfr6rnGTnKoEn57lsRJf7bo=
X-Received: by 2002:a05:7300:641b:b0:302:e560:afb5 with SMTP id 5a478bee46e88-3077b17e3d9mr7956709eec.18.1780921292447;
        Mon, 08 Jun 2026 05:21:32 -0700 (PDT)
Received: from [172.17.0.2] ([172.215.216.197])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074db85f60sm20652988eec.8.2026.06.08.05.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 05:21:32 -0700 (PDT)
Message-ID: <6a26b3cc.9fe3c139.3cb2aa.82a3@mx.google.com>
Date: Mon, 08 Jun 2026 05:21:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1268943718044634627=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, simon.mikuda@streamunlimited.com
Subject: RE: [BlueZ] adapter: Fix failed bonding attempt after LE link disconnection
In-Reply-To: <20260608111034.3684632-1-simon.mikuda@streamunlimited.com>
References: <20260608111034.3684632-1-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1268943718044634627==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1107775

---Test result---

Test Summary:
CheckPatch                    PASS      0.34 seconds
GitLint                       PASS      0.24 seconds
BuildEll                      PASS      20.11 seconds
BluezMake                     PASS      647.11 seconds
CheckSmatch                   PASS      349.98 seconds
bluezmakeextell               PASS      180.78 seconds
IncrementalBuild              PASS      652.24 seconds
ScanBuild                     PASS      1017.15 seconds



https://github.com/bluez/bluez/pull/2188

---
Regards,
Linux Bluetooth


--===============1268943718044634627==--
