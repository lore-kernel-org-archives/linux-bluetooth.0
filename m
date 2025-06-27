Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBB82E7F08
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 14:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751035912; cv=none; b=FW/kYSWl13cwEu3zT1i3py6clXHkXCmzNDpBxpLTMNkONzaZ+xr+DatH6r3l8c7yKTzoYCI78+aviFhSdFAQ0QYLHZIwwfsvZ8GFzcW29j0bonHBWTD7StLDz+qJQwIdt7uvyFwr2RMilkEdBU7bI3WY+y2zFCK5c84VpSfNa3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751035912; c=relaxed/simple;
	bh=ATUcr1buoZztBoF+XDNxQwTzPkm3A3hjjWMk0KxLSno=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aR70QUwYappSj+ic1XqqXsK06rUAqDrK6vtRZrZooJ3zC7X2G6wBNXUYXQtfj8QOXuITyCFER/8FcudZXME2wrO6HacQjCrH6A/ilgMKHk7Ph+3S3cTV5UKfwWUrkYzOks9E1xrDmEwCLigjgej0vuRarMDw+CV8oT/6nfNhEIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=eMaJzDMW; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="eMaJzDMW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1751035902;
	bh=ATUcr1buoZztBoF+XDNxQwTzPkm3A3hjjWMk0KxLSno=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=eMaJzDMWnvpsiqlXSkbuvBBiSC6C9hEhOIiqBIwAuCK7gMBJvgKA49+T8D9KEilfG
	 VFBaHgi/vKVKgo1orGxlAE6sTi9vqM7Peb0cQ5itL6CYfQLQe4h+YQF2Ovd1pD01x6
	 lMeZ6gWAR1SMD8VIPWGu67mDpSUQvipW7Cj9ydt6WRgn0miB/PpJFkPsS5O6yrtWzJ
	 6wYbLujrxaGNdsNEg+5VyFY8F8nuZrrDxUAzd51x5hdevnTNlYjNaXqPWtxSB2XkIu
	 RJS/pE1ORlepN7YDUqezoRuCm37cKI8TpCfnr7902MbUzg/YB+N/eM9D/uI0yBKngY
	 nvdZjwH4ucZHA==
Received: from fdanis-ThinkPad-X1.. (2A02-8428-Af44-1001-81C9-67b7-a328-2001.rev.sfr.net [IPv6:2a02:8428:af44:1001:81c9:67b7:a328:2001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2050A17E0572
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 16:51:42 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ v2 01/27] doc: Add new telephony related profiles interfaces
Date: Fri, 27 Jun 2025 16:51:10 +0200
Message-ID: <20250627145136.421853-2-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250627145136.421853-1-frederic.danis@collabora.com>
References: <20250627145136.421853-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

These are interfaces are meant to be generic to the telephony related
"headset" profiles like HSP HS, HFP HF, and CCP.
---
v1->v2:
  - Rename org.bluez.TelephonyCall1 to org.bluez.Call1
  - Remove reference to profiles in org.bluez.TelephonyAg1 object path
  - Add profile UUID property to org.bluez.TelephonyAg1
  - Add OperatorName property to org.bluez.TelephonyAg1

 Makefile.am                   |   4 +
 doc/org.bluez.Call.rst        | 136 ++++++++++++++++++++++
 doc/org.bluez.TelephonyAg.rst | 207 ++++++++++++++++++++++++++++++++++
 3 files changed, 347 insertions(+)
 create mode 100644 doc/org.bluez.Call.rst
 create mode 100644 doc/org.bluez.TelephonyAg.rst

diff --git a/Makefile.am b/Makefile.am
index 02ad23cf2..12714ecf8 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -388,6 +388,7 @@ man_MANS += doc/org.bluez.obex.Client.5 doc/org.bluez.obex.Session.5 \
 		doc/org.bluez.obex.Message.5 \
 		doc/org.bluez.obex.AgentManager.5 doc/org.bluez.obex.Agent.5 \
 		doc/org.bluez.obex.Image.5
+man_MANS += doc/org.bluez.TelephonyAg.5 doc/org.bluez.Call.5
 endif
 manual_pages += src/bluetoothd.8
 manual_pages += doc/hci.7 doc/mgmt.7 doc/l2cap.7 doc/rfcomm.7 doc/sco.7
@@ -422,6 +423,7 @@ manual_pages += doc/org.bluez.obex.Client.5 doc/org.bluez.obex.Session.5 \
 		doc/org.bluez.obex.Message.5 \
 		doc/org.bluez.obex.AgentManager.5 doc/org.bluez.obex.Agent.5 \
 		doc/org.bluez.obex.Image.5
+manual_pages += doc/org.bluez.TelephonyAg.5 doc/org.bluez.Call.5
 
 EXTRA_DIST += src/genbuiltin src/bluetooth.conf \
 			src/main.conf profiles/network/network.conf \
@@ -505,6 +507,8 @@ EXTRA_DIST += doc/org.bluez.obex.Client.rst doc/org.bluez.obex.Session.rst \
 		doc/org.bluez.obex.AgentManager.rst doc/org.bluez.obex.Agent.rst \
 		doc/org.bluez.obex.Image.rst
 
+EXTRA_DIST += doc/org.bluez.TelephonyAg.rst doc/org.bluez.Call.rst
+
 EXTRA_DIST += doc/pics-opp.txt doc/pixit-opp.txt \
 		doc/pts-opp.txt
 
diff --git a/doc/org.bluez.Call.rst b/doc/org.bluez.Call.rst
new file mode 100644
index 000000000..3fcd6f6ea
--- /dev/null
+++ b/doc/org.bluez.Call.rst
@@ -0,0 +1,136 @@
+===============
+org.bluez.Call1
+===============
+
+--------------------------------------------
+BlueZ D-Bus Telephony Call API documentation
+--------------------------------------------
+
+:Version: BlueZ
+:Date: May 2025
+:Manual section: 5
+:Manual group: Linux System Administration
+
+Interface
+=========
+
+:Service:	org.bluez
+:Interface:	org.bluez.Call1 [experimental]
+:Object path:	[variable prefix]/{hci0,hci1,...}/dev_{BDADDR}/telephony_ag#/call#
+
+Methods
+-------
+
+void Answer()
+`````````````
+
+Answers an incoming call. Only valid if the state of the call is "incoming".
+
+Possible Errors:
+:org.bluez.Error.InvalidState
+:org.bluez.Error.Failed
+
+void Hangup()
+`````````````
+
+Hangs up the call.
+
+For an incoming call, the call is hung up using ATH or equivalent. For a
+waiting call, the remote party is notified by using the User Determined User
+Busy (UDUB) condition. This is generally implemented using CHLD=0.
+
+Please note that the GSM specification does not allow the release of a held
+call when a waiting call exists. This is because 27.007 allows CHLD=1X to
+operate only on active calls. Hence a held call cannot be hung up without
+affecting the state of the incoming call (e.g. using other CHLD alternatives).
+Most manufacturers provide vendor extensions that do allow the state of the
+held call to be modified using CHLD=1X or equivalent. It should be noted that
+Bluetooth HFP specifies the classic 27.007 behavior and does not allow CHLD=1X
+to modify the state of held calls.
+
+Based on the discussion above, it should also be noted that releasing a
+particular party of a held multiparty call might not be possible on some
+implementations. It is recommended for the applications to structure their UI
+accordingly.
+
+NOTE: Releasing active calls does not produce side-effects. That is the state
+of held or waiting calls is not affected. As an exception, in the case where a
+single active call and a waiting call are present, releasing the active call
+will result in the waiting call transitioning to the 'incoming' state.
+
+Possible Errors:
+:org.bluez.Error.InvalidState
+:org.bluez.Error.Failed
+
+Properties
+----------
+
+string LineIdentification [readonly]
+````````````````````````````````````
+
+Contains the Line Identification information returned by the network, if
+present. For incoming calls this is effectively the CLIP. For outgoing calls
+this attribute will hold the dialed number, or the COLP if received by the
+audio gateway.
+
+Please note that COLP may be different from the dialed number. A special
+"withheld" value means the remote party refused to provide caller ID and the
+"override category" option was not provisioned for the current subscriber.
+
+string IncomingLine [readonly, optional]
+````````````````````````````````````````
+
+Contains the Called Line Identification information returned by the network.
+This is only available for incoming calls and indicates the local subscriber
+number which was dialed by the remote party. This is useful for subscribers
+which have a multiple line service with their network provider and would like
+to know what line the call is coming in on.
+
+string Name [readonly]
+``````````````````````
+
+Contains the Name Identification information returned by the network, if
+present.
+
+boolean Multiparty [readonly]
+`````````````````````````````
+
+Contains the indication if the call is part of a multiparty call or not.
+
+Notifications if a call becomes part or leaves a multiparty call are sent.
+
+string State [readonly]
+```````````````````````
+
+Contains the state of the current call.
+
+Possible values:
+
+:"active":
+
+	The call is active
+
+:"held":
+
+	The call is on hold
+
+:"dialing":
+
+	The call is being dialed
+
+:"alerting":
+
+	The remote party is being alerted
+
+:"incoming":
+
+	Incoming call in progress
+
+:"waiting":
+
+	Call is waiting
+
+:"disconnected":
+
+	No further use of this object is allowed, it will be
+	destroyed shortly
diff --git a/doc/org.bluez.TelephonyAg.rst b/doc/org.bluez.TelephonyAg.rst
new file mode 100644
index 000000000..ddb5eec0f
--- /dev/null
+++ b/doc/org.bluez.TelephonyAg.rst
@@ -0,0 +1,207 @@
+======================
+org.bluez.TelephonyAg1
+======================
+
+-----------------------------------------------------
+BlueZ D-Bus Telephony Audio Gateway API documentation
+-----------------------------------------------------
+
+:Version: BlueZ
+:Date: May 2025
+:Manual section: 5
+:Manual group: Linux System Administration
+
+Interface
+=========
+
+:Service:	org.bluez
+:Interface:	org.bluez.TelephonyAg1 [experimental]
+:Object path:	[variable prefix]/{hci0,hci1,...}/dev_{BDADDR}/telephony_ag#
+
+Methods
+-------
+
+object Dial(string number)
+``````````````````````````
+
+Call number, if number is void try to call last dialed number.
+Initiates a new outgoing call. Returns the object path to the newly created
+call.
+
+The number must be a string containing the following characters:
+`[0-9+*#,ABCD]{1,80}` The character set can contain numbers, `+`, `*`, `#`,
+`,` and the letters `A` to `D`. Besides this sanity checking no further number
+validation is performed. It is assumed that the gateway and/or the network
+will perform further validation.
+
+If number is an empty string, it will try to call last dialed number.
+
+NOTE: If an active call (single or multiparty) exists, then it is
+automatically put on hold if the dial procedure is successful.
+
+Possible Errors:
+
+:org.bluez.Error.InvalidState:
+:org.bluez.Error.InvalidArguments:
+:org.bluez.Error.NotSupported:
+:org.bluez.Error.Failed:
+
+void SwapCalls()
+````````````````
+
+Swaps Active and Held calls. The effect of this is that all calls (0 or more
+including calls in a multi-party conversation) that were Active are now Held,
+and all calls (0 or more) that were Held are now Active.
+
+GSM specification does not allow calls to be swapped in the case where Held,
+Active and Waiting calls exist. Some modems implement this anyway, thus it is
+manufacturer specific whether this method will succeed in the case of Held,
+Active and Waiting calls.
+
+Possible Errors:
+:org.bluez.Error.InvalidState
+:org.bluez.Error.Failed
+
+void ReleaseAndAnswer()
+```````````````````````
+
+Releases currently active call (0 or more) and answers the currently waiting
+call. Please note that if the current call is a multiparty call, then all
+parties in the multi-party call will be released.
+
+Possible Errors:
+:org.bluez.Error.InvalidState
+:org.bluez.Error.Failed
+
+void ReleaseAndSwap()
+`````````````````````
+
+Releases currently active call (0 or more) and activates any currently held
+calls. Please note that if the current call is a multiparty call, then all
+parties in the multi-party call will be released.
+
+Possible Errors:
+:org.bluez.Error.InvalidState
+:org.bluez.Error.Failed
+
+void HoldAndAnswer()
+````````````````````
+
+Puts the current call (including multi-party calls) on hold and answers the
+currently waiting call. Calling this function when a user already has a both
+Active and Held calls is invalid, since in GSM a user can have only a single
+Held call at a time.
+
+Possible Errors:
+:org.bluez.Error.InvalidState
+:org.bluez.Error.Failed
+
+void HangupAll()
+````````````````
+
+Releases all calls except waiting calls. This includes multiparty calls.
+
+Possible Errors:
+:org.bluez.Error.InvalidState
+:org.bluez.Error.Failed
+
+void HangupActive()
+```````````````````
+
+Releases active calls. This includes multiparty active calls.
+
+Possible Errors:
+:org.bluez.Error.InvalidState
+:org.bluez.Error.Failed
+
+void HangupHeld()
+`````````````````
+
+Releases held calls except waiting calls. This includes multiparty held calls.
+
+Possible Errors:
+:org.bluez.Error.InvalidState
+:org.bluez.Error.Failed
+
+array{object} CreateMultiparty()
+````````````````````````````````
+
+Joins active and held calls together into a multi-party call. If one of the
+calls is already a multi-party call, then the other call is added to the
+multiparty conversation. Returns the new list of calls participating in the
+multiparty call.
+
+There can only be one subscriber controlled multi-party call according to the
+GSM specification.
+
+Possible Errors:
+:org.bluez.Error.InvalidState
+:org.bluez.Error.Failed
+
+void SendTones(string tones)
+````````````````````````````
+
+Sends the DTMF tones to the network. The tones have a fixed duration.
+Tones can be one of: '0' - '9', '*', '#', 'A', 'B', 'C', 'D'. The last four
+are typically not used in normal circumstances.
+
+Possible Errors:
+:org.bluez.Error.InvalidState
+:org.bluez.Error.InvalidArgs
+:org.bluez.Error.Failed
+
+Properties
+----------
+
+string UUID [readonly]
+``````````````````````
+
+UUID of the profile which the Telephony Audio Gateway is for.
+
+string State [readonly]
+```````````````````````
+
+Contains the state of the current connection.
+
+Possible values:
+
+:"connecting":
+
+	RFComm connection in progress
+
+:"slc_connecting":
+
+	Service Level Connection in progress
+
+:"connected":
+
+	RFComm and Service Level Connection are connected
+
+:"disconnecting":
+
+	No further use of this object is allowed, it will be destroyed shortly
+
+boolean Service [readonly]
+``````````````````````````
+
+Network service availability.
+
+byte Signal [readonly]
+``````````````````````
+
+Network level signal from 0 to 5.
+
+boolean Roaming [readonly]
+``````````````````````````
+
+Network roaming usage.
+
+byte BattChg [readonly]
+```````````````````````
+
+Battery level from 0 to 5.
+
+string OperatorName [readonly, optional]
+````````````````````````````````````````
+
+Operator name
-- 
2.43.0

