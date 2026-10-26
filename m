Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793001457;
	b=IkCqnv1Xluh2ShdO03ZCo/19tv8QpbyczGF69vOhWri03RzZQkm8qTnuwFa+tQHEnNFq
	 sseCFp77S+KJRWxwg2iAc2ED0XwUfHk5Km2KYxqeDPunHWoQMC9J1NudEOa0DjXi6FIVC
	 UT7SxsneFeVXBK1F+UeZ0pvDiE2AOK+Vymn/+JrowWBEOzR4oazsh0+OB+PVPRMqFqqOG
	 n/TrtsL0tL6DwPtP6Bu5JJFkEZ8P+iEozRyicfj9YRR7JwhwVGZYX0LYDtm3VTHSJtCZe
	 NRTK4Nzbm7wlnlv/A8JSKEDfD9MQGZHJnmQBlUuC7fiESzvKQuCydeZQYMehmnGHA7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793001457;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=VLgZ0da92t8Hp04tXJ/lIWNZooNBZfGkUpF22oWHOjE=;
	b=n1QuOZxWeBge+hDEFCP6vkte+rBmNaIsQEZ6nSoJzP2y8YTiJN72TMQ3ED/KBcRWz9t8
	 ejsZMMGQTxBeWd87cD4IUy4Foqb3komFrOR0b87CodT8mG/0T/Q7PXjETQSaARkTOsbMN
	 t/fK2H2xTgYm8ObMd6QMsFkYJj8odxjR2StUnQHJkKc4m8IQnKSoKKtkXYgsb25gPqMXv
	 suj1orPh1TEU2otRgG4fanV1mxj9vxHQX8DGpicbF2ePy97VgOFIs8qqX8A0+Ri24ODq9
	 mFDXdMl0IdtYqkySnG/xxwym9FzC/KK4Kg7S26Uu8uBQq0L2DQcX7zWD7VscWJMjAWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=emkAoLq6;
	arc=none smtp.remote-ip=209.85.222.174
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C760606A31A
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Oct 2026 07:57:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C760606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=emkAoLq6
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-93f3c616c84so223202185a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Oct 2026 00:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793001456; x=1793606256; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VLgZ0da92t8Hp04tXJ/lIWNZooNBZfGkUpF22oWHOjE=;
        b=emkAoLq6MxYr6tEoF9WtlgsIEnGXYQsebZ+sQdS9/lUfhJzmmcrE1FaaEdA+M+aAPz
         8EhDFSF287iYQHr8OHy4+v3HrvnjuZhjOYz1QgYFRMnWYtsCzqB5nGbMmqMGuC9UD0wE
         NovXIOYwgyVW2aZJ/ZP/ZvBMPM+TCMmQpnRq0aMnrwxL1qKPFqBpLxehmujjmQYjXA8f
         qf3vgEto90t9oA5BQVl9AbkCehT+WwXTcQU5aTIZdN/ZXEWZ0QIHBipU0NSeYxw8eW5M
         GXBphclf0sm/kqs3QaWnCVke9xZtwJvz7x4CPoiY77eH3CpE5fUUdBzfO1hb83N6Gv0O
         YaGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793001456; x=1793606256;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VLgZ0da92t8Hp04tXJ/lIWNZooNBZfGkUpF22oWHOjE=;
        b=FCir4Nn9VoJSncRTx/aLFISvU7tKSmn+tkrx2413GOKYlCPBNZphyHAnUTgd09vDl4
         3AUtGPK0b3D38DeKC8/CdsrVz5cHMX4dAPFNJgGsbnj64ERzrtGH++cSL4S9oMKTEk4A
         dNwCRA5mHhrini+hsL51yxq7AKgpbXsbvXwq47GubyXrcFQ5J1871SHKEFIHSS3frIkp
         v2fS6SDav8g0HNVTff0B5jSFHm3/atb/jLWfOyigo0zhIosgr8Wamu/DWA3gjFFXHALI
         6OSQpbQZ2O2JILWIHReqtg/0WdVgzTMiAxm+fmokOyotOltW5hOzPntajJlMHu7CT1YS
         zXfA==
X-Gm-Message-State: AFq9FYJdwVmZ1fbizTAd1vHSvDnp9iddXMoFkvz5PR54VzaehsN4wmRe
	Irs47LlQpFcesKkNyFKe4adfSHNWdnbuo+7YnusKtDXSFpLvmTr5UWDd28ZDVQ==
X-Gm-Gg: AYBFou2jD1ofjqvP1jnXsDTAK+8hE35A5SoBx2ov6zNbh+3aEb7cDDKXt2VvfGOzS+c
	gsYrsaEEPFUDfAu7Wed+0mborPDPdpsERMhC5S8eK80pANmZiCHXzVSmN9dh7cuDEbnNNoHgHYw
	zKTzxF8bjZYrmItESlg6bqPCGn/thAEg+wsfERI29NK7aqIomj+8Qoy8AclrTbOqMRKwQlDq0mh
	0EcFHn3XElSPLDbQAkYgkbtUH0q/ZTaGj+XvVZe+taNpmUe7wYLn9wg4yE02MDDG2x7xNUKigLI
	lLS9Nxm8abERXI2E8U2IaIuFGpqGDo3BtpHf230058zC+qsQVGvuhjvjlgJEZtkeqfkmy97aQyQ
	86WkMrcYwdFo2k3ibEidS8uhBTctAhCjozA4r3wxxalJAU9E21zAXQT725PWZrjb1koZFQKIxF+
	ZkVd9w0cJh1jQi4lRwHmvpBAYyr8EkLwFJkvc713K96byn4R6xx+LGKs2d/pZpITrzP7SnOvh9z
	Q5M0vz4dqMf5oUPE/SU/0wKQ97Jbvdw+YotbIiCfmIXpVuBB1fAV8slhyS4cTIfOw==
X-Received: by 2002:a05:620a:6008:b0:93f:5677:9950 with SMTP id af79cd13be357-940ef981717mr871884785a.53.1793001456189;
        Mon, 26 Oct 2026 00:57:36 -0700 (PDT)
Received: from [172.17.0.2] ([172.208.127.244])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940f078a762sm620726085a.30.2026.10.26.00.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 00:57:35 -0700 (PDT)
Message-ID: <6adf07ef.e20a777d.8d4ed.bc9e@mx.google.com>
Date: Mon, 26 Oct 2026 00:57:35 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4894290256007582378=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, jared@kotfu.net
Subject: RE: [BlueZ,RESEND] gatt-database: Fix freeing wrong client notify IO
In-Reply-To: <20261026032544.49563-1-jared@kotfu.net>
References: <20261026032544.49563-1-jared@kotfu.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4894290256007582378==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1193317/

---Test result---

Test Summary:
CheckPatch                    PASS      0.51 seconds
GitLint                       PASS      0.35 seconds
BuildEll                      PASS      20.33 seconds
BluezMake                     PASS      309.98 seconds
CheckSmatch                   PASS      301.98 seconds
bluezmakeextell               PASS      96.63 seconds
TestFunctional                PASS      1134.88 seconds
IncrementalBuild              PASS      306.94 seconds
ScanBuild                     PASS      1175.94 seconds



https://github.com/bluez/bluez/pull/2712

---
Regards,
Linux Bluetooth


--===============4894290256007582378==--
