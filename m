Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795769739;
	b=YJbhG1h9nNMOEHKHLxF1NnL57TJWomc/NEJ48nMrBLm93mNZJ2R/EWQOmW+nZUqkXA2q
	 s9eruhKW1cccg3AbhtaPz3jE3x134E7JW4TMgGn5ZOwp2E8mBnTTViLF/XoKVPZyKX3VH
	 OwaYnmS6CXiVR9c++ys8weAE15dh1TnvXYWRidNNTJZ1GY2I30/ldbipfaQktunyUhrGF
	 VMm21I32Y6EneRlgBpvOIiocdDtJ9sVEAK2cFPGgSOCmeHj93KGaocT150VljLL6l+kIj
	 GelX5GOnXBJQFLfa925v2UDl8didpuQ7S7OizphxCaW4eUlf/NcUhZVBa6ZkSQQlvmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795769739;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=JAqdVbCJBi6EcXY5EwsC83sJDEzFW9PhvwgxwHT7kk0=;
	b=p/ARWy3DZ4RxSzp57bFLDjx7IPe2SZQGK/RDmCYXp1QE3Fy1d1ZMFKS6xaatai8JdZTG
	 oWYOrxYtJViGmB7H4QBYmKnz3GI/2mIqHFzoPIXXvi1jvL3kWR32/P1GXjeK3l/zX0/8a
	 s8wgqQbdz1A17Zk93P39veqlRO2mGqnHol28/XYt+VQL63Uh1WvLnTJqqIJffSfuDVVvD
	 JAxAcd3RmY9YLmWvOp16i0GGiUiNYCNacK2PcLWRxmhAJvAwyHTIvQWfb2v+xOM9mc0O7
	 oEXFlkicIMjK7nWfe+J24GetjtlWhRvtQIz7vjU9HF5o+DOnkpy5BSjaVs+/NQMgHhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c7uz0x2a;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEABE606A326
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 08:55:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AEABE606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c7uz0x2a
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4bb6756bb1cso5043615e9.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 00:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795769737; x=1796374537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JAqdVbCJBi6EcXY5EwsC83sJDEzFW9PhvwgxwHT7kk0=;
        b=c7uz0x2aD0SgdnQ8WFroCk1QlOOCnm8eqnHcSj0c1FpzRqbCtGvq10vnoE9bVK5hGI
         ekkoIboom+xDF9iUbYtf0nOO8Tee5Ez8z/h43Y3ErcFrx23qy0isNiWZovPqH/PipqE8
         ORwDuxTnfC4+jRP2satETfO6XJJyz7vwC+QtYOh3Au/66yWzAdVh4inRDIul1g0kzgbq
         YKzsggpRcvytXoEzW3/etCGuWZM76++Hn+JwzdDBP8laQzA8pNts/qnUc+81AdaTxUif
         n0Zm9AU+qQugcOuzdiplr25c/XINvmmC9Tl/F8zLqxKbTnUJJmddzKTKO3zyKfev/aG+
         UoDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795769737; x=1796374537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JAqdVbCJBi6EcXY5EwsC83sJDEzFW9PhvwgxwHT7kk0=;
        b=EbzDVk3GXmJAaq1y6qS5AajuuPfv56uowe1NOGugX9MGPQy2DCdhN5zHc+vUveKD6s
         RcXWAQQmpcOJ2Pmgf+KhfgLieA/kR97awZVNwCtaI7CfMuUTpo4HS6hsNLANZKq1Leiz
         QuxISG+7rrFpIuMXACti9ctNRp/o3eSICZEuh+EqQhU6hctV+lKXUu9jKaPMiqfcjOEl
         /qCPdtnx26roxvo3sbbevLoZtXvIgwGtEjpnUnITusWvNGNsxdoplwnPC0pF0YDK8kaG
         YDllM3xeLb07QhEu4zqkzva4nPb+JMg5K/OPTic7lM8PhBWHhXV7iLPNCedJHMlSGWeX
         yX+w==
X-Gm-Message-State: APuU4Z9ucoFowd9GurK/ohfrlmTDsszpuqRmClmM+VzSygPS5Ml9I+Yq
	OlIX3CKijuSMYnxni/k9d3ANSGR8JFouujiHgx+/BE65m9AGoo6B1C9eNqH8ikZt
X-Gm-Gg: AZFdTZdpmkgy8LMDnAoUBIAg2bBUWZpOJ6sC5m3qdNkPYnZBKaP6vXkSRyAsi/1Tkqv
	0Q3OmOVT67sELqC7yHvETfxvL4tOYuAofHxolefDGHQogupVWkQqNmEUiTI41GBiWhTOCkyzLWg
	9zXWwSU3lx53/P4lm7P5YRPWOdts7Wf47LHc0r3fiU+7p22MRnxOIhJp3E7tHeVIO8J0DHlq+bS
	ZNP3cwkmS9eIRYNrBEBXaqCuvetdSkXoEMwYnx9Xl9sxZBaknVsf1yiqMmryrN3UfLtCxCzs4j7
	NwZMjMZ31TjOgb7RnSo8In+Gw7uiIDx++9AncVnw7FUqWftzQe0wWjjfCr0MWGNvsmYPlvaeqww
	0bA1YWvyn29LSdAQkOA79gA0DGCwso+FdW8/Ggw674SlEfj0bljX70sKNLcDvmOigQhx/0XpEf6
	YoZyC9sqMoU7VPpYcm/Kn2WOnc3daCV5bzCJEB+ZcmH3wt1cQ1A8Gcjig9AlfDsR1SFmyGXAnw3
	hZ6gQZtrXpfOHM9rf/DScsUMcS1UxGgv/j7S+IAWVUCBIBNepJvhq8VP3aLjmLsMd/sf6fDqSLq
	moRkUM4k7IxizOAyoS/iXr7UY4NBVuoIXPY=
X-Received: by 2002:a05:600c:21ca:b0:4bb:68ed:a356 with SMTP id 5b1f17b1804b1-4bb887ec919mr330106175e9.1.1795769736998;
        Fri, 27 Nov 2026 00:55:36 -0800 (PST)
Received: from schinder.corp.hoffmann-group.com ([2003:8:2:4::5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853c9170sm739587505e9.14.2026.11.27.00.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 00:55:36 -0800 (PST)
From: Roland Schober <rolandschober1968@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	Roland Schober <rolandschober1968@gmail.com>
Subject: [RFC PATCH BlueZ 1/9] doc/mgmt: Add periodic advertising and PAwR commands and events
Date: Fri, 27 Nov 2026 09:55:17 +0100
Message-ID: <20261127085525.264299-2-rolandschober1968@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261127085525.264299-1-rolandschober1968@gmail.com>
References: <20261127085525.264299-1-rolandschober1968@gmail.com>
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

Add Periodic Advertising Parameters makes an advertising instance
periodic and, with subevents, Periodic Advertising with Responses.
Add Periodic Advertising Data sets the data of a periodic advertising
train. Set Periodic Advertising Subevent Data and the events Periodic
Advertising Subevent Data Request and Periodic Advertising Response
Report carry the data of the subevents and the responses to them.

Assisted-by: Claude:claude-fable-5-2
---
 doc/mgmt-protocol.rst | 208 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 208 insertions(+)

diff --git a/doc/mgmt-protocol.rst b/doc/mgmt-protocol.rst
index c4e1421e3..899b5c6f5 100644
--- a/doc/mgmt-protocol.rst
+++ b/doc/mgmt-protocol.rst
@@ -4278,6 +4278,153 @@ Possible errors:
 :Invalid Index:
 :Not Supported:
 
+Add Periodic Advertising Parameters
+```````````````````````````````````
+
+:Command Code:		0x005D
+:Controller Index:	<controller id>
+:Command Parameters:	Instance (1 Octet)
+:...:			Min_Interval (2 Octets)
+:...:			Max_Interval (2 Octets)
+:...:			Num_Subevents (1 Octet)
+:...:			Subevent_Interval (1 Octet)
+:...:			Response_Slot_Delay (1 Octet)
+:...:			Response_Slot_Spacing (1 Octet)
+:...:			Num_Response_Slots (1 Octet)
+:Return Parameters:	Instance (1 Octet)
+
+This command is used to make an advertising instance a periodic advertising
+instance. The instance has to exist: the command is sent between Add Extended
+Advertising Parameters, which creates the instance, and Add Extended
+Advertising Data, which enables it:
+
+.. csv-table::
+	:header: "Step", "Command"
+	:widths: auto
+
+	1, Add Extended Advertising Parameters
+	2, Add Periodic Advertising Parameters
+	3, Add Periodic Advertising Data (optional)
+	4, Add Extended Advertising Data
+
+The instance must use one of the secondary channel flags (Secondary Channel
+with LE 1M, LE 2M or LE Coded) and must not be connectable.
+
+The Min_Interval and Max_Interval parameters specify the range of the periodic
+advertising interval in units of 1.25 ms (range: 0x0006 to 0xFFFF).
+
+A Num_Subevents of 0 makes the instance plain periodic advertising, and the
+remaining parameters are ignored. Any other value (range: 0x01 to 0x80) makes
+it Periodic Advertising with Responses, which requires the controller to
+support the Periodic Advertising with Responses - Advertiser feature. The
+remaining parameters are then those of the HCI command LE Set Periodic
+Advertising Parameters [v2]:
+
+.. csv-table::
+	:header: "Parameter", "Unit", "Description"
+	:widths: auto
+
+	Subevent_Interval, 1.25 ms, Time between the subevents of one periodic advertising event
+	Response_Slot_Delay, 1.25 ms, Time from the start of a subevent to its first response slot
+	Response_Slot_Spacing, 0.125 ms, Time between the starts of two response slots
+	Num_Response_Slots, , Number of response slots of a subevent
+
+The controller checks these values against each other and against the
+interval. The data of the subevents is requested with the Periodic Advertising
+Subevent Data Request event.
+
+Remove Advertising stops the periodic advertising and removes the instance.
+
+This command can only be used when the controller is powered.
+
+This command generates a Command Complete event on success or a Command Status
+event on failure.
+
+Possible errors:
+
+:Failed:
+:Busy:
+:Rejected:
+:Not Supported:
+:Invalid Parameters:
+:Invalid Index:
+
+Add Periodic Advertising Data
+`````````````````````````````
+
+:Command Code:		0x005E
+:Controller Index:	<controller id>
+:Command Parameters:	Instance (1 Octet)
+:...:			Data_Length (1 Octet)
+:...:			Data (0-252 Octets)
+:Return Parameters:	Instance (1 Octet)
+
+This command is used to set the data of the periodic advertising train of an
+instance which was made periodic with Add Periodic Advertising Parameters. It
+may be sent again to change the data while the train is running.
+
+The Data parameter holds advertising data structures, each with its length
+and type. The kernel does not add anything to it.
+
+An instance with Periodic Advertising with Responses has no such data: the
+data of its subevents is set with Set Periodic Advertising Subevent Data.
+
+This command can only be used when the controller is powered.
+
+This command generates a Command Complete event on success or a Command Status
+event on failure.
+
+Possible errors:
+
+:Failed:
+:Rejected:
+:Invalid Parameters:
+:Invalid Index:
+
+Set Periodic Advertising Subevent Data
+``````````````````````````````````````
+
+:Command Code:		0x005F
+:Controller Index:	<controller id>
+:Command Parameters:	Instance (1 Octet)
+:...:			Num_Subevents (1 Octet)
+:...:			Subevent[] (1 Octet)
+:...:			Response_Slot_Start[] (1 Octet)
+:...:			Response_Slot_Count[] (1 Octet)
+:...:			Data_Length[] (1 Octet)
+:...:			Data[] (variable)
+:...:			...[]
+:Return Parameters:	Instance (1 Octet)
+
+This command is used to set the data of subevents of an instance with
+Periodic Advertising with Responses. It is the answer to the Periodic
+Advertising Subevent Data Request event and may hold the data of any number of
+the requested subevents.
+
+The Response_Slot_Start and Response_Slot_Count parameters specify the
+response slots of the subevent the controller listens to. A count of 0 means
+that no response is expected.
+
+All entries of one command are sent to the controller in a single HCI command:
+the entries, each with its four octets of header, are limited to 253 octets
+in total.
+
+The controller accepts the data of a subevent only for a limited time before
+the subevent. Data which arrives too late, or for a subevent which was not
+requested, fails the command, and nothing is transmitted in that subevent.
+
+This command can only be used when the controller is powered.
+
+This command generates a Command Complete event on success or a Command Status
+event on failure.
+
+Possible errors:
+
+:Failed:
+:Rejected:
+:Invalid Parameters:
+:Invalid Index:
+
 Events
 ------
 
@@ -5599,3 +5746,64 @@ Possible values for the Encryption type:
 	0x02, AES-CCM encryption
 
 This event will be sent to all management sockets.
+
+Periodic Advertising Subevent Data Request
+``````````````````````````````````````````
+
+:Event Code:		0x0035
+:Controller Index:	<controller id>
+:Event Parameters:	Instance (1 Octet)
+:...:			Subevent_Start (1 Octet)
+:...:			Subevent_Data_Count (1 Octet)
+
+This event indicates that the controller is ready to accept the data of
+Subevent_Data_Count subevents of an instance with Periodic Advertising with
+Responses, starting with the subevent Subevent_Start and wrapping to subevent
+0 after the last one. The data is set with the Set
+Periodic Advertising Subevent Data command.
+
+This event will be sent to all management sockets.
+
+Periodic Advertising Response Report
+````````````````````````````````````
+
+:Event Code:		0x0036
+:Controller Index:	<controller id>
+:Event Parameters:	Instance (1 Octet)
+:...:			Subevent (1 Octet)
+:...:			TX_Status (1 Octet)
+:...:			Num_Responses (1 Octet)
+:...:			TX_Power[] (1 Octet)
+:...:			RSSI[] (1 Octet)
+:...:			CTE_Type[] (1 Octet)
+:...:			Response_Slot[] (1 Octet)
+:...:			Data_Status[] (1 Octet)
+:...:			Data_Length[] (1 Octet)
+:...:			Data[] (variable)
+:...:			...[]
+
+This event reports the responses received in the response slots of a subevent
+of an instance with Periodic Advertising with Responses.
+
+Possible values for the TX_Status parameter:
+
+.. csv-table::
+	:header: "Value", "Description"
+	:widths: auto
+
+	0x00, The subevent was transmitted
+	0x01, The subevent was not transmitted
+
+The parameters of a response are those of the HCI event LE Periodic
+Advertising Response Report. TX_Power and RSSI are in dBm, with 0x7F for a
+value which is not available. Possible values for the Data_Status parameter:
+
+.. csv-table::
+	:header: "Value", "Description"
+	:widths: auto
+
+	0x00, Data complete
+	0x01, "Data incomplete, more data to come"
+	0xFF, Failed to receive the response
+
+This event will be sent to all management sockets.
-- 
2.47.3

