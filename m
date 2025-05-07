Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6258D28DB72
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 May 2025 17:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746640559; cv=none; b=I2EVQ4CK8lRVETYPAz702EBzmgg9fNky2/K0edGxiJFzIu5lVNI/BVggFyc3HPTnejbxC0l/NK07VWZmVv9PzzIasu064C4pz4qutFqlORRcqTDv8H500req/Ni+A+zgePd5GzCdRvk/1igy4VI/rd26OXcHi+9NqprHOhN4SAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746640559; c=relaxed/simple;
	bh=VagNpQcg0TvPM0j9ISuZ7x2XaRNICb2YZ/8Q3MHjQqA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=eAenZofg96yUIUoCAunhXDj6917zEgukbd7Xrn69xvNesNw+ob04yOuIixu6bTpOMDKhCKuo5UTDVvT67vxQwvdEeXluKgL4Tuqyw+3/G0HIPp6Npp4KEUKd97oTLa9Cw2nNiQXTvRNJ+9jvhaGF5pWfzlrGqlpu9pBO+3ucMZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TJPwlsg/; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJPwlsg/"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22e4d235811so2475515ad.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 May 2025 10:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746640557; x=1747245357; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hJhCX1z7mHLJYe6j5xpsLGny4MXu3kYAHBJnM9NnffQ=;
        b=TJPwlsg/7C/NFK1qei+gVlRAk2mqSCg3cAAoqgaE+prfjTUB/57/02WHTyyXRBJHip
         0akfdF++udVRWbdqe1c9NGdhdEi21/Sbop8iU7rBOHdoa4ZW/NkQDFSqVXNPi4vyvoEQ
         asY3ftzTG9klSpQdtSPXHODnEBeNmnl6HXAcKvYrC/3C+1mgcZcuD9/7x2enSlHQMhCD
         5i6k+sJk33bHFKotuWSj6tKAFNmqYohusyqKOrWlPMocGfgGyHHKb0+LsGBeEflP2TC1
         6F56JeSUtyjqC271PTR1vaXsZ89ATuXFEY70SlZ0/Zimls6Pufx1XMT9BlzE7QcK9lb4
         cd7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746640557; x=1747245357;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hJhCX1z7mHLJYe6j5xpsLGny4MXu3kYAHBJnM9NnffQ=;
        b=DO82Uw/SZJwKhqpuLxigkX8s7bDBlMIpp2s+x5zeprjeVFcZEk1ypsP/Ypf9RQEmay
         uorAxsIbcwa9vM3IkWMojdrZ02i+p2tXZGt6rqanKQw1/VPhgPbWcHi8pvCGnUXI1PD1
         LETrVvNSfFvMfyIM8UGqsYdQtBhc5Hsq1RgtYcwbcSGXBczbi/IiL7GciuN61JBUVVyf
         vNtS1ROVAQi91yyuCdFVGO5yRPppKwP/7G8mVF2ic+qrL6IfQy99VOodifLtaWLIeYLF
         5o5gMNkXCZWh2NcFN1CqtW4tiWhh4CuNjZd45cDjvJCuG2KzY+ap5kIfi5pl4fKbzdwl
         Fl7Q==
X-Gm-Message-State: AOJu0YyskQ6NHa/brx5eshHX5WUYY6QtNFj+ftFmiesk+n9EhxmZ/Dbe
	MW+EqGUPULUptZAl84hBKKd9uVbc5GWrpi5jNSdTsfSZcksa27rhWNNEKA==
X-Gm-Gg: ASbGncvYUuBNQHW0rlZ5pWybjPLGE+pOuS8nIPWH8mnnHPbIHQGy8P9XkNdyKp6EE39
	fl9HgPvU6WwYH9ub9Sbpeuqj09pE3/XP+8uEDF/cf0aCeJBQcyv78nX8n1KMuqKD/Kbmk2cBT6c
	z/hLFF1V9pk3r2L1KCGeTbO03XDlTyiHOMlUhgD/BI7lIRDw8foN1Vkhg7QWSFZNIZXQsQolYUa
	myh7P2gk5HyzyLhK6R1QM9lxrASi/FJ/C2S+LwNA2oIpITKonHX2Lq4NbpSNNkfwV40lKZp67vf
	l2qKxU7Txj6vMIjZuYvUTqBzud/CMU6naPSClGSnNrk=
X-Google-Smtp-Source: AGHT+IHAVfSQZsiI+KqYaZYICFkLsg8otaVfUWTgEl3dOin1bAQmAAAZruqpuZbN0Z5oagByZ3HIEA==
X-Received: by 2002:a17:902:f381:b0:224:376:7a21 with SMTP id d9443c01a7336-22e8dc8f2b8mr2272425ad.42.1746640557286;
        Wed, 07 May 2025 10:55:57 -0700 (PDT)
Received: from [172.17.0.2] ([20.172.4.1])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b1fd2f96ec2sm6095217a12.13.2025.05.07.10.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 10:55:56 -0700 (PDT)
Message-ID: <681b9eac.630a0220.7bfdd.a0f0@mx.google.com>
Date: Wed, 07 May 2025 10:55:56 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6384357006218485756=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] btio: Fix not being able to set security level 4
In-Reply-To: <20250507162923.226716-1-luiz.dentz@gmail.com>
References: <20250507162923.226716-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6384357006218485756==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=960563

---Test result---

Test Summary:
CheckPatch                    PENDING   0.28 seconds
GitLint                       PENDING   0.29 seconds
BuildEll                      PASS      20.35 seconds
BluezMake                     PASS      2742.55 seconds
MakeCheck                     PASS      20.11 seconds
MakeDistcheck                 PASS      198.54 seconds
CheckValgrind                 PASS      275.48 seconds
CheckSmatch                   PASS      302.18 seconds
bluezmakeextell               PASS      127.74 seconds
IncrementalBuild              PENDING   0.33 seconds
ScanBuild                     PASS      904.61 seconds

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


--===============6384357006218485756==--
