Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79871E25F2
	for <linux-bluetooth@vger.kernel.org>; Sat,  1 Mar 2025 15:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740844677; cv=pass; b=jGqmG+atk/kH1f9wS+FhMR3cFfg5pRnuTS6blnc071vCjItTTU70HdAPkq8g1s8KcTIxOMMmzJ/pKu3GrffyFuMTH+SlYzPGos22MRuSA8ThObHyr5g+R+YwQyRV5UBs8XITsOhlKaMPFG0FDeBbiAw0lH98dtF1BTyqSIe9424=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740844677; c=relaxed/simple;
	bh=Ux5LcfynxecuvLvkm4hsFeM7T4nlOoQFGkhWuHZuF3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dh2GljSfb9BO8pbtyn3dfIoArI1/pS+rEzGpR9QTBHTADplpRQg3hBFDe+9fhHKGWFPFKLbaEfWMi/0KmjS4ZNVQ0E4PVjt3rNHkOjeILovyql+uywjWqEGZlfpU6H0baN7T0Y4Z3TGFb+PFf+NOoayzjq83n3qiMgLDl5Bv0K8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=pJ4TX77m; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="pJ4TX77m"
Received: from monolith.lan (unknown [193.138.7.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4Z4qV24tSlz4BKHQ;
	Sat,  1 Mar 2025 17:57:46 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1740844667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UPjG68OlHxHej9ZzthsJkgqZ31PR1WkRYBKIgLhBFcQ=;
	b=pJ4TX77mOjVqwEhydduJs3DJ2tz65fFrGDgPys3Q1Ls6+rRXYMQuxKw+5awXoZ7HfwqT7Z
	UORD279hh0EVUciyIhJBaOvA2lLl7tCYoHLO4tazuPCw7zYZOCDuNmkgVsSic5G6sik1ub
	qFzaBHH8Q+yaGYF29Vlvq9irZUdnhi+GLJLHD2rZDoOBDSCaIzKK8oFwxmIXfbWi6Nyg92
	y+4N9UbwvBvmMUyosTRvm61RwQYxCdpKh8LZJlizrcWzDFh66Za7MkxOV3NrzD20DLP6NU
	OmuelsXTGHmi6bcA97NM9lW+NdUsjtyjqHK30o5ahiNoan/RdVSIFxl1Cizepg==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1740844667; a=rsa-sha256;
	cv=none;
	b=Q7Ql0BrZHXs1qXr3ir0F0DUiOAXLW73DMF5+Wy9tDKbSjZ1MlsvBITgLwe2RXvuhqjkw1N
	LFs2K5/J0LncgiqnwNDNfzDuG5G+Za2DDI/HHzW3TynYAiJkuZQ3xwjCTadb6QIeqeTB3H
	w4x0Mu/1AneXbQREl8gslhKX+guIlEyqX3UqV8n2AnVx6xdN4CTLoFNaBjCeWBXHFVO+4E
	PWISmqjpWNwueZdWVB7DMNyVegFcO1AbiflerXKBI28Vew0OcLxpXvXIDrgY5qA61TNca7
	NFy+kbpBjv2X2MRdPwjGEcygK1VEDiG1kPQKJu/GVhklKuYBwVJkuX63eNYpaw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1740844667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UPjG68OlHxHej9ZzthsJkgqZ31PR1WkRYBKIgLhBFcQ=;
	b=EHUxMI30CY+BlI3niGlzIZgfUZRmeEWHemVDay0Yr3y4j9vtK3/lsrDVSAdIH2XO90nGvq
	XuvAtf7yBVXux+Z2w8ta/U5rK/NIna2YH9RdF23ZCDurEvb00yuq8yKRTlKRUJU9+g4LxP
	YLqfLwcZxsdkbUThlHBkKadpK4P695jjYueYZbLM08dNa8Dt+I9s2rbjF03QyNoUHcCVy2
	DD2OQ2JeVWWJkwp4q/6k7NqMHDmi+NXpyDGq0wq0I8Qb8Ti9lZLvIUPVzPTraByYtyG+38
	Y8feIFLCrldG1EcEDc7zq6R2fZ/9FrhLGg7FR/89TpwF/VXVm1rUxgLA6nXH+g==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [RFC PATCH BlueZ 1/9] org.bluez.MediaEndpoint: removing BAP streams with ClearConfiguration
Date: Sat,  1 Mar 2025 17:57:32 +0200
Message-ID: <a0a8eb4d51a35f3181617303aa8f6ad8227b2bca.1740844616.git.pav@iki.fi>
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

Allow user to remove specific streams by calling
ClearConfiguration(transport_path) on the endpoint.  If the path is the
endpoint path instead, clear all streams associated with the endpoint.
---
 doc/org.bluez.MediaEndpoint.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/doc/org.bluez.MediaEndpoint.rst b/doc/org.bluez.MediaEndpoint.rst
index f2b830ab0..b81106f0b 100644
--- a/doc/org.bluez.MediaEndpoint.rst
+++ b/doc/org.bluez.MediaEndpoint.rst
@@ -109,6 +109,12 @@ void ClearConfiguration(object transport)
 
 	Clear transport configuration.
 
+	**Server role:** [ISO only]
+
+	Close the stream associated with the given transport. If the
+	path given is the path of this endpoint, all its streams are
+	closed.
+
 void Release()
 ``````````````
 
-- 
2.48.1

