Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0231E47A9
	for <linux-bluetooth@vger.kernel.org>; Sat,  1 Mar 2025 15:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740844679; cv=pass; b=M7ZUA9XLxRPZIWKR3xSyE/lh0CBVuG7IFMBa9vUHtp9vt4hq8gZ1yycj1ZtLILR7dPrNqUdxkikgNJqBe9oD8TqwEXdP/VXAyzJ9MVysUU7qZNSexj9gMkbK+ZrIo7gNyS3IXEQ1NKikTK40dI63gFHDZqKdsH065l5ULgsshn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740844679; c=relaxed/simple;
	bh=lgA/kCl/2n0WRFX7hJDs0NBqYtojFP+no8BghNN6lmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=naEW2WIioZswtWKMKgU0BaqaIcHDWAyFd8zYW8ha1GJ4ltkPM6b5e2cVmVo7gZ81PQWCEmpHV7fTY7Pr/aRQ3huDwGG4MREsZIbXUc2xhze7AtRwP+vR/UxgsQn6K1XHmkiRlD7McXFphylzp+Q5m839Z1go0Qs9N6dDikVr4+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=iIzKvWfY; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="iIzKvWfY"
Received: from monolith.lan (unknown [193.138.7.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4Z4qV53qxCz4BKHw;
	Sat,  1 Mar 2025 17:57:49 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1740844670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OW7sJjRt/jXBHyUdu8Cj6QgyEgAKIyF9d2uJHVYZ7Xc=;
	b=iIzKvWfYkXKQ/5nOR6kZllV8/0pIakP2+mzrrglyXOmJpejqG7/Oo2PUDcp7xDMMvkvTel
	iQoHd7slt1Q9vzSSrQxt+tuX4cq04h/VI5GUN0+B3XlOTIBCaxQ8rPldyTeVhedvym5Kwz
	GKReVumTD/qlqbSFrNUCAAMH36BQfeRdTQ//IPc5PASx0VwTlkaLQdIgEtwIyt0J6MPcvy
	zucai1cyLsaraEmabcEIQQh+UZArwi8/miVGBdHEOTUcBq5Kk+GmkUhVmW0ax4+xtuhQ/6
	nWt3n+rYOnj5q8WJsp1j4S1vqNt+7YbzyTkx+XxW9VfGyQt2sPkrz3Ji7SFTkw==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1740844670; a=rsa-sha256;
	cv=none;
	b=bhIK3tJ+WIkRfQUNOcxeI/8PEqi+ZrxEPKIZ2uOt27/DhRSIKRVzUfmOerlAkUFrA43dLM
	wJrIRT0J82JfHMmLPNbwEVwmdZsOtmgmdSKApl/6m/dnFd6ARjs6ZtAbdkB9BSF3ECb7XJ
	zOaf/JpF9Y6VRDJMxjDM4xykOpAna+vFpRxrGRat0p6x72QuDSM/INFVwbgTUKj2zc1eIB
	mMwkulThjS8jqHstHrJhUQwWzJsxEWgVZ8M2sPBp9dwRw5+yS7L24lGeoAX8c24NM7EUVR
	8kAh0c3lC1uqtG3fmpCvvAc+I4gIWHQpNU2GCoaB3QC4HZ4facDoUwE7SBpgRQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1740844669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OW7sJjRt/jXBHyUdu8Cj6QgyEgAKIyF9d2uJHVYZ7Xc=;
	b=nqXnaEfH/lqvyjq5aC+2tku+UtTu+09+q/MZkwd3EDhe1LgY9dMDoalKxZskErMUPAbY8J
	fcV1bgAvvN69BdO41esTASKEx2BeC+Du/Q6x/hyRxwGCHMxh2lTIhLywaHkRSHpqmRlDjT
	otcdWhkVJqHjuvwojNJcZaRfqVA2GwYvKryu71esCMgaK18OYstnCElkrfzNSnpz/fuiE/
	CLpFfmTZ1kbkPZXGaMaI42RvzAHrjEtYtLU6NMfn/1RO8iMKZsbo39+KgvsD7Y1viNEJUm
	y9/Rxym30vL25jfLPFmSLrIPloj67Yt1fYjSuAj8Js2Vx4w4fhiSGXsLeeBBPA==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [RFC PATCH BlueZ 5/9] shared/bap: bap_abort_stream_req() should cancel also current req
Date: Sat,  1 Mar 2025 17:57:36 +0200
Message-ID: <d53746cb2070fd7d9c19ed81eb5548e584afa952.1740844616.git.pav@iki.fi>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1740844616.git.pav@iki.fi>
References: <cover.1740844616.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After bap_abort_stream_req() no req callbacks for stream shall be
called, so it has to fail also the currently in-flight request.
---
 src/shared/bap.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 208fc1bf2..54c6e8629 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -1229,6 +1229,13 @@ static void bap_abort_stream_req(struct bt_bap *bap,
 						struct bt_bap_stream *stream)
 {
 	queue_remove_all(bap->reqs, match_req_stream, stream, bap_req_abort);
+
+	if (bap->req && bap->req->stream == stream) {
+		struct bt_bap_req *req = bap->req;
+
+		bap->req = NULL;
+		bap_req_complete(req, NULL);
+	}
 }
 
 static void bt_bap_stream_unref(struct bt_bap_stream *stream)
-- 
2.48.1

