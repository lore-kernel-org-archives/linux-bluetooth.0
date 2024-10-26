Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D538B1D63F9
	for <linux-bluetooth@vger.kernel.org>; Sat, 26 Oct 2024 19:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729970105; cv=none; b=Jv5/gtyubs6B1a5z5dmK177VHCIsSWV9XQ7Uo047foYkFalu+F8yVlk5/nlGkG+Zv5rhd1BEIEpujENbEx0wc/CYUrg2GmYJ76s1khcCZcasVfn9RvNV2e1ZknIVi9cyOewm7w7pxgc49Zb1zNxqg9t+x24A0pyOKoI6SqvMqPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729970105; c=relaxed/simple;
	bh=qnUcFCt+ByoWb0C5Gq3oNbefUEj999eNQk3NmKvVYGk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rT6GCHh1tkpvQsZ66/om8a7A4gc6TOK306zWgU8aRBJ01L2EDrRUa96COy36Gb/9qJ4eKIkvLdv9ISECgOwuNqp+vxDqL3PeAOp5qCOAyqADdzbx0G7isO863Mi6lHkv3e49jIc8qC/QB8twuGoZIbd96dJFCHhe7WxOdfA708k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q/nOyBbX; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/nOyBbX"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5cbb719839eso2192085a12.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Oct 2024 12:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729970101; x=1730574901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fWuD6wpX0QHTIzXevZ2FM4lqlk9rCaUh5FcHuKXkTLs=;
        b=Q/nOyBbXYYrpRjGR5P1voNRBtzmvH0LccQKaVP6e1xV13XcAad7MmespvZQybSp4jQ
         m6nv/4uBj+BpLI2vfuoBhApLieb0k4W4ZvvnQ4J2aVJt6zOBAGAlzmNzIoWtBQnEtHK4
         OgByCDU15DeCGCt+WfJiQd2JUrFfoeHdosiUI3C7MGSnXdqzaznATQgrFPNlmGsAVU8l
         Xlr+ZzIJHW+BONMzt8XDh1MbeQ4wgNGLS+tXh/mqLObcIlzBc3PAYLkeHB3kziP7IXda
         kWovefIJui9F/dg25TKbkUpsrRAt1Epr8fVd3VchSbOu+n03xHGVFIlO3nZ2O6y/FvZz
         5gdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729970101; x=1730574901;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fWuD6wpX0QHTIzXevZ2FM4lqlk9rCaUh5FcHuKXkTLs=;
        b=RIbx4gK3wm4rom8SMJBA1VxAZkx/3HxCq/AO7mMga54CBhLjJDI78B7jyLhvFF79++
         TeKcrbdVmwshep+sk8XbmTxLQWIEm2H1mGiP0KloXPdTEDtYKZIvmVaA/wAFLVwD+TuZ
         p6m4F8WnXOGb7D0Hg3uaOk2n4XS2gJ4PZUr6CRFVmDQGn9vcG4Rl3L6tcTkfc5Mb5rtP
         gKbQUyfXo+1XhtOlHXpHcvG/YhpWf2O1nqzwcMyTyNzxQeRLNrkD3996T+z31xinyTOj
         FyQDfIXRAiDhim5GfnOTQCbMEh80oXChnRtTuFyrfTSAjMxEf0Q13Ow4ou0v8K03RfWX
         9ITQ==
X-Gm-Message-State: AOJu0YxMz1LBccvn+4QtG0Ox+b/Aqv5BxNtyPP2VwgDNqbLJjjjSK3xf
	hHUGqtXXnIZrJm3czI8P0hrOY/xE+KNt4qFX8A06Pv0NFberOPTAFd3vPw==
X-Google-Smtp-Source: AGHT+IEtdCYajAFnSJJtslqUf9cHU9Bgmy60Ya495qWNLoheTQyObaHlO2LYIGdwPEKtoZEoDaMe2Q==
X-Received: by 2002:a05:6402:2711:b0:5c3:d2bc:2f64 with SMTP id 4fb4d7f45d1cf-5cbbfac3a40mr2665472a12.35.1729970099426;
        Sat, 26 Oct 2024 12:14:59 -0700 (PDT)
Received: from raspberrypi.home (46.205.194.156.nat.ftth.dynamic.t-mobile.pl. [46.205.194.156])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cbb629c250sm1776677a12.27.2024.10.26.12.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2024 12:14:58 -0700 (PDT)
From: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Subject: [PATCH BlueZ 1/2] transport: Expose DelayReporting on MediaTransport interface
Date: Sat, 26 Oct 2024 21:14:33 +0200
Message-Id: <20241026191434.556716-1-arkadiusz.bokowy@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Exposing DelayReporting property on the MediaTransport interface will
allow media application to get the information about the delay reporting
feature during the SetConfiguration call in a similar way the profile
UUID and transport codec are provided. Otherwise, the application would
need to check the associated endpoint which might not be convenient.
---
 doc/org.bluez.MediaTransport.rst | 10 ++++++++--
 profiles/audio/transport.c       | 30 ++++++++++++++++++++++++++++--
 2 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/doc/org.bluez.MediaTransport.rst b/doc/org.bluez.MediaTransport.rst
index 4838d69d0..5da13b3b5 100644
--- a/doc/org.bluez.MediaTransport.rst
+++ b/doc/org.bluez.MediaTransport.rst
@@ -115,11 +115,17 @@ string State [readonly]
 		created by a broadcast sink
 	:"active": streaming and acquired
 
+boolean DelayReporting [readonly]
+
+	Indicates if the endpoint associated with the transport supports Delay
+	Reporting.
+
 uint16 Delay [readwrite, optional]
 ``````````````````````````````````
 
-	Transport delay in 1/10 of millisecond, this property is only writeable
-	when the transport was acquired by the sender.
+	Transport delay in 1/10 of millisecond.
+	This property is available only if the DelayReporting is true and is
+	writeable only when the transport was acquired by the sender.
 
 uint16 Volume [readwrite, optional]
 ```````````````````````````````````
diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 0f7909a94..dd6878427 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -860,6 +860,22 @@ static gboolean get_state(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean get_delay_reporting(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct media_transport *transport = data;
+	struct avdtp_stream *stream;
+
+	stream = media_transport_get_stream(transport);
+	if (stream == NULL)
+		return FALSE;
+
+	gboolean value = avdtp_stream_has_delay_reporting(stream);
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &value);
+
+	return TRUE;
+}
+
 static gboolean delay_reporting_exists(const GDBusPropertyTable *property,
 							void *data)
 {
@@ -873,7 +889,7 @@ static gboolean delay_reporting_exists(const GDBusPropertyTable *property,
 	return avdtp_stream_has_delay_reporting(stream);
 }
 
-static gboolean get_delay_reporting(const GDBusPropertyTable *property,
+static gboolean get_delay_report(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
 	struct media_transport *transport = data;
@@ -1019,7 +1035,8 @@ static const GDBusPropertyTable transport_a2dp_properties[] = {
 	{ "Codec", "y", get_codec },
 	{ "Configuration", "ay", get_configuration },
 	{ "State", "s", get_state },
-	{ "Delay", "q", get_delay_reporting, NULL, delay_reporting_exists },
+	{ "DelayReporting", "b", get_delay_reporting },
+	{ "Delay", "q", get_delay_report, NULL, delay_reporting_exists },
 	{ "Volume", "q", get_volume, set_volume, volume_exists },
 	{ "Endpoint", "o", get_endpoint, NULL, endpoint_exists,
 				G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
@@ -1359,6 +1376,14 @@ static const GDBusPropertyTable transport_bap_bc_properties[] = {
 	{ }
 };
 
+static gboolean get_asha_delay_reporting(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	gboolean value = TRUE;
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &value);
+	return TRUE;
+}
+
 static gboolean get_asha_delay(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
@@ -1380,6 +1405,7 @@ static const GDBusPropertyTable transport_asha_properties[] = {
 	{ "UUID", "s", get_uuid },
 	{ "Codec", "y", get_codec },
 	{ "State", "s", get_state },
+	{ "DelayReporting", "b", get_asha_delay_reporting },
 	{ "Delay", "q", get_asha_delay },
 	{ "Volume", "q", get_volume, set_volume, volume_exists },
 	{ }
-- 
2.39.5

