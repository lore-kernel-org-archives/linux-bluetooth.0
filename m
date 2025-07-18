Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CEEA932;
	Fri, 18 Jul 2025 01:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752802393; cv=none; b=sVQ3shk/1TlGQIlZmENwI8jrnEbgWFWQ0sXBDk6F9LwVYRR/pgynXnt2lOmoykdHLWS5mx0BTPJLl3uRJezZ7tz3OV/1QCRBN4rj0cmeYGTaXKUA6JVZYgNNWixLxjkWcCvFnznC4tS8RMcsYM6aTVWP+OF7sqG55BYPGRIauSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752802393; c=relaxed/simple;
	bh=CbtKel0F8ajAZhNlxi7Qlpw05dN+QrxC41VPfGf0XOM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=shKIrn45pNY77BJDIzIEz1I0br9iatmTMNGDcp3mqLsied1Mx5X+tWL57NdfxW4zF0g5aGcUksGN52JxbhucS3sQPGN+uKizVU2Q51W3eEEQkV9F3UYRbHbfz8OvO14iGh17CDGzfM56rBIn8xWG576ABTpGrjJBfvb+sZAiYHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jps5h5gv; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jps5h5gv"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6fad4a1dc33so15618086d6.1;
        Thu, 17 Jul 2025 18:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752802390; x=1753407190; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CbtKel0F8ajAZhNlxi7Qlpw05dN+QrxC41VPfGf0XOM=;
        b=jps5h5gvOEqK7g+NG6DIKR3cFFlU1+W4YiJvwl3mVcXMT3mrfZHC9QHjes4EbmkW+9
         r2ylhSF3VTCqB4QKUBfyU0ydfAsYoeBH5QXE2AhTyelyzvRtoVfXiOgstyp0plegE327
         RFLIBKGy3DzOcONkqHNDbod8J2YDga7drOXc3yBUCVzBZkh6PghtSwzyAm89HakqNZpz
         D6gp7zbUmhF/E2NvJ3VO1ZIafRFdo2AQiqqexPU0h9Bs1V1X5WuY8K4aW2W78Nj36VpC
         Jt2zlTuZSVT4B4CzXIn8j3oGUPO8B0tWgNj+k2I5Z/kfIOwYBZ98YyCNTtVjn+bn0Pxa
         YohQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752802390; x=1753407190;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CbtKel0F8ajAZhNlxi7Qlpw05dN+QrxC41VPfGf0XOM=;
        b=FPQZrLE+ELd6KnGOSttoNuPGXkMYwOVAM21ckiy/usuGx93QciVp8VbtU80u5NfG0X
         griXU/EpjFTKjEUQ8w0jshQg5LVVHxKo5CCrsn4OKQRCBBTX0TmvIK/pOk3iHs+qRusX
         dZ0ZcAEVAyt2w1iwSJ/CQCfwN6Pxq5v/oZU/f88jBuOWNGDORsIRf8pAkcFVp1EjqTFw
         oNFcuY9A5bxlca4nuKqqhv7/214ngvA8EXfCp951eLl60YTyEGzX1OsP2C89OxyG/7hr
         VWsE24gasW7H6fs7xZEKLH8mEAdWFpzkN3iD8g90tAXtLkLBbYelk495AonhH6HlyKT/
         o0kQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcbbGcpu96y/0hAYWDTNyvfIEbZs1hE3/L7cjmoqX4uLnZwknGy8bzbvwWvH2jKspS4M+FK6k6TuvnUQFLgRg=@vger.kernel.org, AJvYcCW8uYnPoA7+mUG7p2wJWThFL/sZcPBGh1XFDeOGnTbzLoL61r6PcKWsZ2yTrKrPHELo0gaFU6ce5wJgiFjd@vger.kernel.org
X-Gm-Message-State: AOJu0Yye7v1k0XeF4eFZaFT4flMOXrlwvyUsgY5prp7V7i1Jnyxo/Jf4
	ppbazs7Jbx8es2hlOWgEQhSl3fFPh+YDqDq7a8i5UgDi17idORuqJbVRczM1kQ==
X-Gm-Gg: ASbGncuRatBybrrdDYUf8Gw/WDoXzr7J616jUq/HindVkFus21oz+9d3ZBe13hoMYDU
	RZtMHSk5VzTptl2XRNy/7J6BliSyDWgmuHGcQzz9tGu2ZO2FZVWWn7cvHPLeABTtXiXstyYmqxo
	bBckg2f6sZuUbEIvnF9ZnddiiUemg3QLZvcBRhdEe8UgCT1GHyBQAXS9Axw2yTwztpM/nQuUIE5
	r+TZEmW8sO5ItV1qkd3btiTDO8ldxP/PlFoznVpPbyoV1FyQNvNMNtJPoOeqTy0INmjKs7twjDE
	a0nV2EShWIYaq5AnaBHGvqVyabMQv0MGPbyDkLVqTX+/+w6Uvij2DLVTJkihN8EgRFfGnFz2EHw
	FQmJ7rMDVeh/xGt64DhC3MA==
X-Google-Smtp-Source: AGHT+IFW5rhe2ZbyNRvd/olJoYRdm/v8VboVlGjhcpo8byIkDL6un2sya1dkkADmSJzCAoiPWugxNg==
X-Received: by 2002:a05:6214:d8f:b0:704:a929:a4cd with SMTP id 6a1803df08f44-704f69eb073mr122604856d6.1.1752802390001;
        Thu, 17 Jul 2025 18:33:10 -0700 (PDT)
Received: from pc ([165.51.18.150])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4abb4aebcf8sm1772341cf.40.2025.07.17.18.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 18:33:09 -0700 (PDT)
Date: Fri, 18 Jul 2025 02:33:06 +0100
From: Salah Triki <salah.triki@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: btintel_pcie: Drop pci_set_drvdata(pdev, NULL)
Message-ID: <aHmkUowa2Lt7KIB2@pc>
References: <aHhtIL3jyVbCEMqh@pc>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHhtIL3jyVbCEMqh@pc>

Hi Marcel, Luiz, and linux-bluetooth community,

Thank you for the CI test results on my patch [PATCH] Bluetooth: btintel: Drop
pci_set_drvdata(pdev, NULL).

I've reviewed the automated test results and noted the failure of `TestRunner_mesh-tester`,
specifically the "Mesh - Send cancel - 1" and "Mesh - Send cancel - 2" cases which timed out.

I'm currently investigating why this seemingly unrelated change might be impacting the mesh
tester functionality. I will work to understand the root cause and will submit a revised
patch if necessary.

Could you send some information about the two test cases ?

Thank you for your time and review.

Best regards,
Salah Triki
