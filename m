Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793690877;
	b=W9xLbe2wb6a5tx8S0G5zNKxYa1+ClF0/7QnMHj0mCSrycP/9e4ggYUuLs/7I2Qx515SD
	 G7lfqOkw/qBSDc4fJPma5Xc1p3jRdqBEyJSK6PqotceiK0knC++IBqOcoSiRcz90d2WlS
	 iwomCxOmnrG/0GQYpFnqrNAQj+EUVfLTlxFFKGQaZJbqYVjZ9TE/ZItVPWVZcyARjR+IN
	 sfvJLaqw+pDjJFG8I2B7XnZdUcNIXo21KwMxnXDMcQz7ZcPH4TrueA1A3Q9sBvrAe9u9d
	 CeUJzhBlIJ1hK7rCRYN1VxCJK9gi2ZAew3a6tudXthdiPoing/A6Im117AM7LVuyf+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793690877;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=BCRmxDZQNqIR+WtaN5FIifpkR+PeT7HFZUck4px6r7E=;
	b=CKUqEzyzVexOqwrHpwospW2DSWV+ceGqUR2h0sBX0sBuF1pziO/EPN33bgX+5vt1uXls
	 4MnZ6ffszoyKj93ohN8qf6Zq7QtbFwJSDBFQ9F35rMRQOLvCwu29n2KR8W4vGcV5/hx1u
	 8YK7412kzPQojXAHkFspF3dGF/yAPfc+xEunXOKsNvVPbn04XJU9dmAbIbJOqoyiy+pEU
	 VUHMtNg1Kb0CZHHGmgXDaoxjzwQSQEwDLFCUOKHGixg/iIWHV9bpV23BGgIzMaLKKPXke
	 4dNU9RLqcE3qZdyPMjTKP4+ljF0n1cMutJb1fud8RZYSAKZYh+AiEfhMrVx3ThJjpQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simpleble.org;
	spf=pass smtp.mailfrom=californiaopensource.com;
	dkim=pass header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=eu+kyKUz;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12BC606A32F
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Nov 2026 07:27:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D12BC606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=eu+kyKUz
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-170135e43c7so2037152c88.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Nov 2026 23:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1793690876; x=1794295676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BCRmxDZQNqIR+WtaN5FIifpkR+PeT7HFZUck4px6r7E=;
        b=eu+kyKUz9JqSHrzFnaRdO6zBwdb28eMokmrslHlHdX8WUR/qZFkQAsUIhruOJ6JIDi
         2bxbzTagniTq7QSBeesNJ2y1MpPLTQkvs/voio6aMlxEs47iUbMUldRiYBddlfACK+Cm
         oNXsji8BHjzRMMraX7sEc03eJL25i5WJGR4Iz/txf9zOXAwOvgERoIVR5++VqfWiea0y
         eHTTXCHrGpiIM7TDnLHYS7ZqyUWeBNi39J23lW/aSimfghiLBTepgG/DenSyFZhI3vS1
         cUCRpsN5NCLGAcGPvP+Cv7FjQY5bKyJmDZW1vg2FQY+hY3LGMbdR4FCKHg4XaGPhTgOv
         GfMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793690876; x=1794295676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BCRmxDZQNqIR+WtaN5FIifpkR+PeT7HFZUck4px6r7E=;
        b=clCbpyN/kO2L+VOsSdm2RZD2nuZiEdg6RlZ9v98Ly3yYEDnO2JbQW5vjB2EKwIDjgS
         jUp0SkpjLOfn1VL8Slu9Mj6RpcGdYv9MFuVi2xtgSp0aem4Zpjs+PMrGVXhyEEOaQMBa
         HYCXuwptDdbQmG33T+R9Wv0jFgIOP5Os73OGXYi/N9ZDZtSG4HhkznWqwGQCb5CO0B7A
         HSy5Rb3O1Xsr9hkceOrTQSTiUT9ZrgkvdSuV9JQpmN2LdfHR/U0ros7/PwBKGhDawbOF
         EX3dtCM1Kf/cXRBcLbOH9cXR6XrkWQKOnFDq2qOYTLnMhkWhQrb2kFGVImfKn5/eB/p4
         cJ1g==
X-Gm-Message-State: APuU4Z+cs1f/r60Kn2VKVVu7LrpOeLKOexirNxAe57SqIEEdF9XmMVcG
	m6hvOxyrteLvhfIEXPuQQ8tFw+3AU0CQ83ZRukttfQYGm2e5JQGQ/sG85X9eMaj6YcpzM1Rb5/f
	MvODnqkk=
X-Gm-Gg: AYBFou1ZAXH8sYzap8P3WOcpG4qEaVHwkvDyXQSjqDa/Q22BL5ReG5YNG//vr/nlUcW
	VdQg4f3/fiqAVmcKd1nbi4PsFBOpd88strJj38vtvvIbuHobHRqPk6HicLtYCxxnwmzDRjzYk5h
	ocJl+lluvCODwuIdrQ+cFHyCBW0AavH/SDXPIzzf07OpF9wYAAG2sqs6b2I2Y2Ww2Oveyt+uiQe
	hcMWS4JwPNn2MCVnmJedQnmVB1T3vsrmhK5FncITjrRAGfxpfcYfsxXccJmD7px9nEBbckyiNOh
	VDzfwB0KQsIO5LBawgEbz4PJ1jng0qcUDm0gBLsOoWV8qSkInjkADMJLyiy/6q74uz/OasXr2u+
	Im3pDKUaBLSWcbtXcmj4GyAywC4BaRQb/USO2UTAVnjzitq4I52H1TX21qI3sKXdG8JhpNzMg2S
	Z7fusfrxBNb7sDj1C/AJ0GjrLqf1PfIRAjenJkpm2y9uKqlg+7u2ytH0v5pvr7UHguZooyVl1MG
	5xF4D9/9JbYL85SIlrtFZdq4bvQi0xZL0A9TP0i4m5GPpFKdsne/0FhIGSaNSzp8IDSC1giZu+h
	XNfDOc3bb13P3mBqFWLR0/itAR5z816jmGh4tr4HBCahCpVWdNND8GD6/yesF4LvsNEkrULO8Km
	5aD6++jAe9GRXBWMfQZF8b3ujCp3LciXeRfziTdz9m+HmICFjgWNVXIrYb7TcJzFwz4yMbDk=
X-Received: by 2002:a05:701b:418d:10b0:192:e5a8:6bae with SMTP id a92af1059eb24-1ac5e6f5eaemr19022260c88.40.1793690875553;
        Mon, 02 Nov 2026 23:27:55 -0800 (PST)
Received: from localhost.localdomain ([147.185.47.151])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1aed79b3dfcsm42437988c88.12.2026.11.02.23.27.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 02 Nov 2026 23:27:55 -0800 (PST)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kevin Dewald <kevin@simpleble.org>
Subject: [PATCH BlueZ 1/5] doc/mgmt: Document Connection Subrate for LE connections and updates
Date: Mon,  2 Nov 2026 23:27:45 -0800
Message-ID: <20261103072749.50979-2-kevin@simpleble.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261103072749.50979-1-kevin@simpleble.org>
References: <20261103072749.50979-1-kevin@simpleble.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With "Bluetooth: MGMT: Send Connection Subrate on LE connection and
update", now in bluetooth-next, the kernel also sends the Connection
Subrate event when an LE connection is established and after each LE
Connection Update, so the connection parameters are known on
controllers without the Shorter Connection Interval feature, and a
failed connection rate change reports the current parameters. Document
this, and the Subrate and Continuation_Number values these events
carry.

Assisted-by: Claude:claude-opus-5.5
---
 doc/mgmt-protocol.rst | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/doc/mgmt-protocol.rst b/doc/mgmt-protocol.rst
index ed2bd3349..bf6a3b200 100644
--- a/doc/mgmt-protocol.rst
+++ b/doc/mgmt-protocol.rst
@@ -5520,6 +5520,11 @@ This event indicates that the connection rate has changed for a device. This
 can be a result of a successful LE Connection Rate Request or a change
 initiated by the remote device.
 
+It is also sent when an LE connection is established and after each LE
+Connection Update, which do not report subrating: the Subrate and
+Continuation_Number parameters then keep the values of the last connection
+rate change, or 1 and 0 if there was none.
+
 Possible values for the Address_Type parameter:
 
 .. csv-table::
@@ -5529,7 +5534,8 @@ Possible values for the Address_Type parameter:
 	0x01, LE Public
 	0x02, LE Random
 
-The Status indicates whether the connection rate change was successful.
+The Status indicates whether the connection rate change was successful. When it
+was not, the other parameters are the current ones of the connection.
 
 The Interval parameter specifies the new connection interval in units of
 0.125 ms.
-- 
2.54.0 (Apple Git-157)

