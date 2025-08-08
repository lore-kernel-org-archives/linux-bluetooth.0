Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB4D284B36
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Aug 2025 18:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754679061; cv=pass; b=QG8wtD3EUS3htZzZqFTfI5EunWBA0URiUoauEOgYkKaWHQOO9P3W0/e9dFXxlVN7ERqemDJc3Eeht5P6CM5XcvdklfuJxndHhaBTdIcyepnpIjZyAjyEurD8CDhSRIY4IPnzsJBorRMioBO0ILnYPg2580D3S9Roe/7mFtRgfwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754679061; c=relaxed/simple;
	bh=3G2QU/93WUe5aHPmAqCYkAc8ZUp388UMLVce/2x6dNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eqE/fIfyfSi/YDWEi3+aahKr63E48dpq2jwhB/UhCekt/Zz8zcU1E4w5QQw+j4lOr+db5eJ4BkhigwijDckItFmFnEcv+Rfs9rjaDEhg3uSnAHIQw2Gr+WueaXQKoooeSsvdLUb/bDdKTeYbic2/2jHvnQ4XkaPKpqsabQ7SPm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=j4tjb1zm; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="j4tjb1zm"
Received: from monolith.lan (unknown [193.138.7.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4bzClw2RwKz49Q3M;
	Fri,  8 Aug 2025 21:50:52 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1754679052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=maFIXOeh9h1NTYsQUI/CX+ZCiIiBqC37CrtTzXxTQGU=;
	b=j4tjb1zm5+WKAK6xg9rsq1hNXr3naaCkOCVaLTJoOCZkQpoIKRnVObd4WfqM/dRnroSYTV
	IxtF87ziTWxcdh29slxMTpbnE0YpUYqNhLNjVkFbZwfFQ8wQh72p1cPchONsgjcSZypTrZ
	D9HVht0hx03QvoqFwrQAb/cvDV1q8/v5Gbb6S7dzgDUJNb6gMLBR061CaVwBAo3ouT/ACF
	+dbu9RVXpBESELyQ0P4sUwQ64RogzNWyLFyi4qn/HJ0CSiVnkzu+CMxZoBKauargy6woLT
	1mchtAXqaxinRr+MAqcO1nZRhjDv4ZETjHShN1DfKyWUUSxs7HejUIQk4QsY4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1754679052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=maFIXOeh9h1NTYsQUI/CX+ZCiIiBqC37CrtTzXxTQGU=;
	b=kllDc6dk90I6JY00X9BBgQt8M8FaFealMxzLK/VX0bqvR5MLuIywfX7GgO95Rk6V4wowTq
	EpAkSuK8kZKhjkOv1bUYlO0NARugdXTIalWzVFvUPWJc+0d2np60W9rWZvq31iOcQajU7L
	KogYMthFtfd9WXdkYYOrQ17iUmKfJDK6b2jqlpDf6cBvGT9ZKnXj3UsK4lsAYP6s3sZVwH
	bad/oKUuHPQvDNb96fLPtMg4rPZ6odHllTSS1ofEIW3ck6AYoAf7pRZz4NmFpx8DJIs5ug
	McjDZHRcdITJzgzIMGXiYbsiQsirhb3OEGBfIlzome2rmYbdjBE0e6f6V8fkJw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1754679052; a=rsa-sha256;
	cv=none;
	b=nuyMYaed6wG4lz2342lPzM9rkXJP73xL9sOGbUUxE+QC7neAED8IziRnEnwv9JrFimEY4b
	kOhvUlK5i8G2Q/4IRUAHayShDOWDqt8V8nZdz4YISG4zpXAWsB2pG88+Gf7mFudOKk2PhD
	k+NVT1UYWHywonr0e0tZbVJAJHz9sMB0rScE6idOYZNn+WbazguVU8OtOMi+vLEOfTHajc
	No533x5qJTU29y4cfScFEuqDo0jC8YoNWK0dfdYfcVNCM/sdfRCwI1mJMS25bUmflGOyzl
	ep5dZpb5cjb7W7oM2ftegEuN+x+T/RanXYCrz4udfuDfgniombw6tv22FcI1Pw==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 2/7] bap: send correct framing value to kernel
Date: Fri,  8 Aug 2025 21:50:34 +0300
Message-ID: <977aecec9f592232fb5dd9e65ab6b72ab19777ed.1754678883.git.pav@iki.fi>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1754678883.git.pav@iki.fi>
References: <cover.1754678883.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Get framing value to use from the QoS of the appropriate stream, instead
of hardcoding unframed.
---
 profiles/audio/bap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 8413a5b38..a75919102 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -2750,6 +2750,8 @@ static void setup_create_ucast_io(struct bap_data *data,
 						qos[1]->ucast.cig_id;
 	iso_qos.ucast.cis = qos[0] ? qos[0]->ucast.cis_id :
 						qos[1]->ucast.cis_id;
+	iso_qos.ucast.framing = qos[0] ? qos[0]->ucast.framing :
+						qos[1]->ucast.framing;
 
 	bap_iso_qos(qos[0], &iso_qos.ucast.in);
 	bap_iso_qos(qos[1], &iso_qos.ucast.out);
-- 
2.50.1

