Received: from relay15.mail.gandi.net (relay15.mail.gandi.net [217.70.178.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364F52BD016
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 08:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751963997; cv=none; b=S7MWt3e6tszX436+4XygFU3Zsfa2KvKCW8d+dwKaCDA5onRw9jDbPXWLpYT5aD/LOs7S/ebpAUfEnjqnIVJb1zkwj63Veg4dYLwJoahg8/ajlFidiozRV1fUxtAYDqseqFsfkacyHzPVe7G4mPp5/a4+UreVV1r/o+c7fvfe2mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751963997; c=relaxed/simple;
	bh=tjJJgDT4N+kwUzCmU3btsy0jJ1F6wI64DYN3hiAjiys=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LSFqlyA3sZUnOg+2TJMYt/PfXHJJO6UtBPxIGI1T8A9exxTLVxpBkr8wBOLMa/75Dx5LIVeWWAdk+Kv6j7gGRGch0a7+02pu627+0DbjHHUc5XnJFZ7uZnfT+gEGPdN7UUj9TWRwwwwa2mD1D78EAlMl2E8CIQaMa2oRlusAbOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7EB494313F
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 08:39:53 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] midi: Fix debug string
Date: Tue,  8 Jul 2025 10:39:37 +0200
Message-ID: <20250708083948.1822604-2-hadess@hadess.net>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708083948.1822604-1-hadess@hadess.net>
References: <20250708083948.1822604-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefgedvvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuegrshhtihgvnhcupfhotggvrhgruceohhgruggvshhssehhrgguvghsshdrnhgvtheqnecuggftrfgrthhtvghrnhepkeetteegtedtheeiudeitddtteffleelhedtjeekleeuvdfgffdvveetteduhfeknecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemjeduuggrmeefsggumedvtdgrleemudeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemjeduuggrmeefsggumedvtdgrleemudeffedphhgvlhhopeholhhimhhpihgtpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorhhg

---
 profiles/midi/midi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/profiles/midi/midi.c b/profiles/midi/midi.c
index 944887acbb42..2ca8fe87f2f0 100644
--- a/profiles/midi/midi.c
+++ b/profiles/midi/midi.c
@@ -322,8 +322,8 @@ static int midi_accept(struct btd_service *service)
 
 	err = snd_seq_client_id(midi->seq_handle);
 	if (err < 0) {
-		error("Could retrieve ALSA client: %s (%d)", snd_strerror(err),
-			err);
+		error("Could not retrieve ALSA client: %s (%d)",
+			snd_strerror(err), err);
 		goto _err_handle;
 	}
 	midi->seq_client_id = err;
-- 
2.50.0

