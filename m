Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7287428DA1
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jan 2024 23:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705619875; cv=none; b=UX4DJgb5+BpnnxEqae+iVMdA24efusqN5+3BTVWTl8UGGzdeCFtI0Qr9ylmOhuFXi/vWLnJ9jQUd6/QFATBZsk9WlJ1r/L2pE25y8EV98odEitUJx6vR5Qpys3hOJoLyNhpvF/Ff7lg/JQmidRCLzfzhoy2jPnZB4e5FhjeXO0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705619875; c=relaxed/simple;
	bh=iZ6MfYQYg0ymhMYKD8rtZ+eNov7eJB+kUXQ4ZkLUXx4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ZyMDX/NLGK8pRrEuZceWe8zwiG0GRX4QCpafh72+zRCNct0buV77+Gc5mfMXWV0WqFAh3KigxB1iV9AfQOFUlexcj9/t6nTNeW8VLd7YB84iTu+QqeVXFViGWwsIz6q62N00tzJFcBqHgdfek/iOVgbbun1Af3fr7pgl0SvOIO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M8SadoQX; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M8SadoQX"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6817ecd5318so1630916d6.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jan 2024 15:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705619873; x=1706224673; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iHFi6hFIggISQveykfSKU5cE/YL0qUwgHaLKrbZFpaA=;
        b=M8SadoQXBFW/DgqpdCrhUzcaQBiSBfmfEGuSJDRi25zhgxiuelgvvdjnBg8zciI7oA
         6z8Zk/c3UAWwACpiInyNf4hCd8Ei7K56w+oe7le/A+UvyqpKn/GdzunhlKG1ikFi/g3z
         f5Pwxi73wwkIDJqU5NTvhrM1d9UmtmheAjjPzwr/DB/1F1ku4ZUblCj9U2jknXO7NVep
         ZhYv8z/Hc38LE5xqGrJQPtTVO9a7GAP3WcKt880l6TgdsDWdQv31FL3S3tU95+Tdnk8I
         OdPpyhkcW9WSOz0+OsbYe9wvYO8ygcxnup0ohuWpzFzoyXTyKhJQnvNvIcyI/lDIKy3M
         4Fnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705619873; x=1706224673;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iHFi6hFIggISQveykfSKU5cE/YL0qUwgHaLKrbZFpaA=;
        b=MfiQb1bpbWFx/3utzh8aogITNYScFEwpkcLKJw36dVmaccLj/oB2vmCvvZw9J6Wks9
         pF6ILmJ/7oGn8kLNj06XUg3gv4F8pMKOlXrlX+1EO7wapfvs1l/XHPLbejq3C+fHLWwV
         0uHiQBCxxJ2c0EPgBHVr3xhR+EhkrYq48rsAtggxKSrxK+k/hZsMmvrX6wa8br/xEuGP
         eN6xJUEGu/zwh8q2HZ7EykApfrncoYoVLEoyvD+mht0N1cIB8rZWnI186nJCeqVvLlwx
         FLiQttN0FHvU3dPVf7agV6XLT9/RHh7EMG9ywKxdNjaVBuELWakDppRTdiHKsQk3wGR/
         NDqA==
X-Gm-Message-State: AOJu0Yz3P7D/ryNiBiOx53CWxOuCC9wc1FMnHF0k0jzcDc0Y9e0qpNx7
	Z6hia/Exg3WtvutRBmTs/O1d07pzjbzps/QBPguGXCM6rj15ji3gtyvryf3q
X-Google-Smtp-Source: AGHT+IH1euX5vqhKJmTu7oChH7RgKl+E1eRd2/sT7Pg1CcSmCfVNOV3qYsu2EEtNj08e6B9pDeqKYA==
X-Received: by 2002:a05:6214:27e5:b0:681:80dc:a143 with SMTP id jt5-20020a05621427e500b0068180dca143mr1804520qvb.62.1705619873315;
        Thu, 18 Jan 2024 15:17:53 -0800 (PST)
Received: from [172.17.0.2] ([20.75.95.161])
        by smtp.gmail.com with ESMTPSA id od9-20020a0562142f0900b0068198012890sm556569qvb.66.2024.01.18.15.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 15:17:53 -0800 (PST)
Message-ID: <65a9b1a1.050a0220.72c2.4c30@mx.google.com>
Date: Thu, 18 Jan 2024 15:17:53 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2428010695410197861=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2,1/2] player: Fix endpoint.config for broadcast
In-Reply-To: <20240118213314.2066415-1-luiz.dentz@gmail.com>
References: <20240118213314.2066415-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2428010695410197861==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=817943

---Test result---

Test Summary:
CheckPatch                    PASS      0.97 seconds
GitLint                       PASS      0.61 seconds
BuildEll                      PASS      23.76 seconds
BluezMake                     PASS      714.53 seconds
MakeCheck                     PASS      11.76 seconds
MakeDistcheck                 PASS      160.17 seconds
CheckValgrind                 PASS      222.21 seconds
CheckSmatch                   PASS      337.08 seconds
bluezmakeextell               PASS      106.76 seconds
IncrementalBuild              PASS      1343.92 seconds
ScanBuild                     PASS      927.03 seconds



---
Regards,
Linux Bluetooth


--===============2428010695410197861==--
