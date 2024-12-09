Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0547F2165F6
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Dec 2024 10:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733741233; cv=none; b=kcKQZaiHvpaG70ws3yzY8M/KltROIJ0eSN4mljlf4McZAm8wcqnqO6VAi1J0EJToOrTcZQw81fc4nxMfLmZF6txAN+NPv9fbqg/CsB+HDYUJA2dYXJdg+zYzEELOjlMxjjkuA7I3WcM8xEu4RW8Svw7fte7mZEAOIXouE4ZdCY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733741233; c=relaxed/simple;
	bh=6bdmLpbEsgT4beZScW2vl5QE0ie8Y14H3DS8jeeiEF8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=j2R5PtukKIxFBnpifjYKIDaIqS8MsIdQKki85Cj9tzkF50tywg3BBg5wirmJ22+L1CFxRpVENhhYTYyD2kTYuSvj2DUPZ8gyptwYdNus9MexmCOchlQk5ScebitfWkI65Q+OTQCIk4qV940LjRCyVMCwijdEEmH2+DglDZlrFYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dTck+B+L; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dTck+B+L"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7b1601e853eso311866185a.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Dec 2024 02:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733741231; x=1734346031; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6bdmLpbEsgT4beZScW2vl5QE0ie8Y14H3DS8jeeiEF8=;
        b=dTck+B+LchzzZTN2/opsaO203TPeLOsD+bibbHuncNDhJAOAAu8yGosbSCcg517y3+
         rQ5kZh/n7aiGU8Uj1DrVdzSIqXUKCs7aQq7Hg1ZCjwTqjayfpd8e4tgLylZhk8IfIEAU
         y1IylZnjAJ69yyykJSMWjro+Kb5nOt/s29ZO2PW3JUZuwKkUYggvNVwUuVnu+XcjDbRn
         EHsMhFTEIMgZJf8gCn1SAYu91diEzWR+t3jqvK0nMAv7UB4qdproUO614ZBKbnaIn120
         806jjepYbKcDogDuC9FN1IlO435Ld9GFjeWYTX47sSUjWJ3NZrSW/RNE74VOTqPogvmz
         918g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733741231; x=1734346031;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6bdmLpbEsgT4beZScW2vl5QE0ie8Y14H3DS8jeeiEF8=;
        b=Ud0vW3kzAgFuscpHTpZuwmScUQhuMiqNqNstaVaBtZf1bjwyr5E4ODKAZVECxw30ju
         QXdWANcBCg0ec1K/JjEDkCm0MRxTpmbW9vpRqztG7+w/sCQT9cq8nf8sVctVC+nZ4NWl
         31rTOQkKTXM2v3E3pB1myZ3FuDLzBnR43RJ2Dp9DnPGXdgM5m1Api0OI+BNjfanHHtZU
         Q/QFpP/E2njg7fkyhH6Kv9IpoOmx+F/yYHMPL+BBhP4ANtIh7rpywrxqTaL4H0gKKote
         sMYq1Eq6pyteOicRqT6SDMm/An4hTlho8F2d+bBK0ZjtqVAq4RehGEUm1hc1DH41jOZ3
         SwSA==
X-Gm-Message-State: AOJu0YzHZcMSNwk5Qq35h57ZAjxEeeV1Wa+6axron2X8g9ve2AlG7qBn
	yMOvGR6Tyc9aKGBNnqPd2DGwLjXm9F6q17K5/zQwL5zQZJSV22D8dQS/jg==
X-Gm-Gg: ASbGncshQTMvDg/Psg2z1ZYcydzk9oedSYeeQA4KIbya5fwpBCdmKsGtvb1kzg1U7Ny
	p+nq/idnAq5p+KWh7B0Gnh1oC1NIF5wY7UD02VI5WLGfXE1rpyVV5TrD54suS2DpUhu8XUmXWUV
	LhZon5VqaRAwLrAlA5M/0JLE27gpE+VEU1Pmt0cOg3N6mf4j5i9T+kBC7W3N8sb1fLyuHpENadL
	rBZRN4GUI6tIbYjZel3+yAjUWU6Pm154YAOHYR69F914F52li3AF8v/Nqez
X-Google-Smtp-Source: AGHT+IF8uAaa/I+CksUwXYv5vX5nyFjn/HuKOZST/lEjhWxtwVpRA5VD8sJv7ZHirQKz/gtKajAItg==
X-Received: by 2002:a05:622a:254:b0:466:85eb:6123 with SMTP id d75a77b69052e-46734cf3020mr177658351cf.22.1733741230679;
        Mon, 09 Dec 2024 02:47:10 -0800 (PST)
Received: from [172.17.0.2] ([13.90.174.207])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46759b837aasm16650451cf.83.2024.12.09.02.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 02:47:10 -0800 (PST)
Message-ID: <6756caae.c80a0220.267135.41e9@mx.google.com>
Date: Mon, 09 Dec 2024 02:47:10 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2803864677137799137=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_janathot@quicinc.com
Subject: RE: Enable Bluetooth on qcs6490-rb3gen2 board
In-Reply-To: <20241209103455.9675-2-quic_janathot@quicinc.com>
References: <20241209103455.9675-2-quic_janathot@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2803864677137799137==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/power/sequencing/pwrseq-qcom-wcn.c:272
error: drivers/power/sequencing/pwrseq-qcom-wcn.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============2803864677137799137==--
