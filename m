Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B21213BC3A
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jun 2024 10:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719485017; cv=none; b=Mo0w1QsDIefCFfTFh1giLQQOUn5cbLrhmvUUBYTUXLHumqIDVAWOY9SSrtfUVVN665S4VvjbQmTTKpHtIVbnL06UsR2/1SApV9K7lEt9+Q3PZgTClu+ASIo9zzzVVXKyCsw8CAqD8xl7IIYku/KvNKBzseNKEsciN1B5DTr+cqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719485017; c=relaxed/simple;
	bh=Dnu7rUg/zgjVdgcxJsdyPDzUxlGhAWfGnNhZ4nDAYEM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=bRsC63WhJa9NDwiDlth53vCf92bXtvGLqHMmlmdIDS9XwJJmAqj31ULBN1JvcibLtg6yF8E/JIZwybN1oE7+KS/jeyFOHz2NxaNpVxCFTgHRnJp6gVk4Ekaxni3XFi5DMmhDdtdaDsBbsDqEMos6vcKCDGL9FO+e7UQZHOsq19E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EgkQIEx/; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EgkQIEx/"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-44636bd6e22so7925361cf.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jun 2024 03:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719485015; x=1720089815; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=p47rlMAuTutA7q7z2fTu/JokukQ02el+CabZoN0z6RI=;
        b=EgkQIEx/k/eaEEugTyqUUpWycVP15G2u3TyH4632Gnz4rJdKx8tFJHa+5/8ujJ07Qh
         4fTd1706RcC9fvEZr85atTxl4iWzNQJ2Lc2CSXV8gxypt9DmvPzojoStpyh7LOy58GQS
         Y8Niyp34lubVOP9Zz3VaLQhtYKRHOFNN0gkWU/6DXzhO15QcCwgHTzj2GA7Cj31OUBAp
         b5UoBH2PH3nyyzkWJfO6bdZLFwC45jSzV2Nz/QFJSwlgymllxwyyZxQEHAWmxvRn4JF/
         bfK2WSujm6i+1JFYNRPf9tD6L9dNgyJsW8eZgYi3DsevxwwkyFAo0dVvTxug10YpCs+g
         bSjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719485015; x=1720089815;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p47rlMAuTutA7q7z2fTu/JokukQ02el+CabZoN0z6RI=;
        b=nfIzNMxv9ectOFdjxvZx3lFqZuWsXdJtqrfsFtZWQCqXfg8MkhTYSzbrCeS4alTDWJ
         zTfOZ5ogMCKxoWvFY6ooPVxyq2eVcR5Lpom6JWqFn//82ZHuPud2fd0PQEvOY4+0MrUG
         c3EBAM7W4kthIus3KmcWA2FzEgjvxODQcVQgtl37CTpBHUUfMp8Y8lbS+FtmihrWPnMi
         +s7KsFFN5RC7y4Yf7yWjvMBEA1K08kqqQGoqODJ3aRYtX+D74fg6DoEZzImWpbIBZrbI
         JjpJzvfq51mtbk/o6G30RSTk2kV1l0Et7JLCsFNFueVjjCSN8qWnOTfy+UmZfAotItd7
         N60g==
X-Gm-Message-State: AOJu0YxBS0Ri4SQHv4CtsUPqNxC4sho0+Z+9OAeEqujYj1HiYJTYc4pK
	FrAdOPp3dOsSVWySzmqUJbBy36/bqrU4T/aqplX8uySQxVgxhTzluUDXa3Ns
X-Google-Smtp-Source: AGHT+IGBXYOs4x2zO257C1N7KPCwFS3+7cEv/Edtjgf2TlS5E+WO2hjXSkO+/gHFKrX1nQKajLUneA==
X-Received: by 2002:ac8:5943:0:b0:440:25d4:805e with SMTP id d75a77b69052e-444d3c76a2dmr138536271cf.65.1719485014932;
        Thu, 27 Jun 2024 03:43:34 -0700 (PDT)
Received: from [172.17.0.2] ([52.177.182.234])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44641ea7b3bsm4693851cf.34.2024.06.27.03.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 03:43:34 -0700 (PDT)
Message-ID: <667d4256.050a0220.78ef7.1542@mx.google.com>
Date: Thu, 27 Jun 2024 03:43:34 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6388275470852531984=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, r.smirnov@omp.ru
Subject: RE: [BlueZ] bass: add NULL check to bass_handle_add_src_op()
In-Reply-To: <20240627085652.41303-1-r.smirnov@omp.ru>
References: <20240627085652.41303-1-r.smirnov@omp.ru>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6388275470852531984==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=866057

---Test result---

Test Summary:
CheckPatch                    PASS      0.44 seconds
GitLint                       PASS      0.31 seconds
BuildEll                      PASS      24.85 seconds
BluezMake                     PASS      1724.51 seconds
MakeCheck                     PASS      13.36 seconds
MakeDistcheck                 PASS      176.79 seconds
CheckValgrind                 PASS      257.68 seconds
CheckSmatch                   PASS      356.20 seconds
bluezmakeextell               PASS      119.07 seconds
IncrementalBuild              PASS      1575.96 seconds
ScanBuild                     PASS      1008.74 seconds



---
Regards,
Linux Bluetooth


--===============6388275470852531984==--
