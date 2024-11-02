Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD28782890
	for <linux-bluetooth@vger.kernel.org>; Sat,  2 Nov 2024 20:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730579414; cv=pass; b=dJF6Jkg/tCOYCY/iojaUlU0wM0G5QnbSsFuRyaG6P5pIiKdk5hm7HkQr9i+enTa1oIwledyw0lrUeHCGFhSucyQmsfPJU7p8enDFupIIBpfOv58qH5ARm9VbLDwSll2XHu25mZVE77g1rJPniCcThsGbLTV0trblLDY0luIN2po=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730579414; c=relaxed/simple;
	bh=l/UYpSf1bwVoPlNbtUofWU2n94XgFuSupE5zUwJ4xLA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EBvXxK7riTEtBgDeMnuFkdYzugpB0lToRW6dTuCnmsa3xSwDK0dYODuDTlHKPSUwSTutOxJ/ElX0BBrmAR+bwsKWFZ2L/sHl0cwjBtZ9ZkAxoU6fOMmZB5uTA7YMCpi3v8bw8gaTCENlBe+5zVcxIedRPAid4I0vN16TMXdQzWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=P3CXvRMB; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=iMuvjCY7; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="P3CXvRMB";
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="iMuvjCY7"
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lahtoruutu.iki.fi (Postfix) with ESMTPS id 4Xgq954wRmz49Ptk
	for <linux-bluetooth@vger.kernel.org>; Sat,  2 Nov 2024 22:30:01 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1730579401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=t6eDCXHbm6rqTKgu98kxVn8x4qE2csLkR8IXmp73IoY=;
	b=P3CXvRMBqN8vzzlPAiEhqMUe2LGwN3nNNqKAh6A96faEFx1nzzPGc8FGALk2SoqBJmdqw7
	LS7ii7x5RJ+8dWClgBnNusoPcAYWGEFB8lRzrERPzXm8HXLujnO/OeAoGl+oEOWJL0E7mU
	M22e6Tr8e+Ihey6/qqRELP3ioiPAmjK7XLTB9uUAdFJ5U1WrYCOntSUtlRLOhMsnGrO09j
	X6l1iuIWigLEaKvRqkmP/uIn3XNVqxWj+mwuZi/cjz8SmxPxBvpgaa99EPoKFhlmaN7cnN
	+jgtEEpOT/0JxmbCt9oSLNablIscSuYbYET5hDqXNb88DHd0IY5OGHHcXvSMzQ==
Received: from monolith.lan (unknown [193.138.7.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4Xgq8w6K1tzyRw;
	Sat,  2 Nov 2024 22:29:51 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1730579393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=t6eDCXHbm6rqTKgu98kxVn8x4qE2csLkR8IXmp73IoY=;
	b=iMuvjCY7pAQCVzOmtmhcNY00KgLMH5tb4+BAgFvCF9ePJ/c/5WNQjdMiVQkvPSI6nvb3lA
	OKLXnkUGdXNL+gcx4DtyX1ywrfjDJaCAKanCiRMymvU2qY7ugjh4lRWsmyaNTh5VASh7tD
	TiN9sdMgaAHOMWMdJsqqUFS4DSauA+k=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1730579393; a=rsa-sha256; cv=none;
	b=ZpoIyTqkAX4i3KBlxmbFkcnP03H0T+WfCphkvFd1adAmQFxUYBfPA8IYopsq9cVaLwSqFA
	Ki190eO5VmxoQkfZJqE4mIYegD0NrdfH5a8Bj14Yj/K7VHiPzu9TN3bR4pcmXVPpiGlhiQ
	tflBoK2pG/n2Pmp4pBJTUhDQMqdXEko=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1730579393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=t6eDCXHbm6rqTKgu98kxVn8x4qE2csLkR8IXmp73IoY=;
	b=XIgXhNBTOD2K6dcfuRzJs27rD2we5WlFbyK9zOsEUJqul7iYbWgYwbMgA7QOMlG3Gk3Ikn
	t6slaWmKShZEZe6VINYSEnIuNVpyXbUyzqaaroCG1jYa8kaNDJO9cZHTf/a48t8ZB58uTL
	U1sMyAdy5aBAGMHnvAZHfRGTEzlXwtI=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 0/2] transport: don't disconnect A2DP if canceling Acquire() with Release()
Date: Sat,  2 Nov 2024 22:29:44 +0200
Message-ID: <cover.1730579026.git.pav@iki.fi>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

User can cancel transport acquire by calling Release() while Acquire()
is in progress. This calls a2dp_cancel() which sends AVDTP_ABORT_CMD,
forcing AVDTP state transition to IDLE, and A2DP profile disconnects.

However, Release()/Acquire() should only result to transitions between
STREAMING/OPEN.  The expected behavior is that either these calls return
error, or they block until the target state is reached.

This corner case probably was untested previously.

Fix by: Release() during pending Acquire() first sends error reply to
the Acquire. Then it waits for START to complete, then sends SUSPEND,
and after that completes, then it replies.

v2:
- handle possible suspend failures after START completes
- fix busy return from transport_a2dp_resume
- fix a2dp_resume/suspend messing reconfiguration state

***

In the end I did not make Acquire() to be able to cancel pending
Release(), since that's more of an enhancement request than bug, as
Acquire() has always just returned error immediately if there is another
pending operation.

SetConfiguration() also works sensibly here, it will queue CLOSE, and
wait for pending START/SUSPEND to complete.  This is how it also worked
previously when there were pending requests --- the difference is just
that now it doesn't fail any more if the Acquire() was canceled by a
Release().

This also runs into a bug where a2dp_resume/suspend mess up the
reconfiguration, if they get called while we are waiting for CLOSE_RSP.
It looks like this was possible to trigger also before, if Release() or
Acquire() is called just after SetConfiguration() without waiting it to
complete. The second patch fixes this.

It's possible to make SetConfiguration() to send ABORT immediately,
change FALSE to TRUE in avdtp_close in a2dp_reconfig, but that probably
would be for a different patch.

Some logs can be found below, showing the behavior in different cases.

Log: Acquire() -> canceled by Release()
----------------------------------------------------------
22:12:25.019782: [:1.712:method_call] > org.bluez.MediaTransport1.Acquire [#37]
22:12:25.019822: profiles/audio/transport.c:media_owner_create() Owner created: sender=:1.712
22:12:25.019844: profiles/audio/transport.c:media_transport_resume() Transport /org/bluez/hci1/dev_B8_7B_D4_07_04_65/fd0 Owner :1.712
22:12:25.019867: profiles/audio/avdtp.c:avdtp_ref() 0x51d00001e080: ref=2
22:12:25.019887: profiles/audio/a2dp.c:a2dp_sep_lock() SEP 0x506000047f60 locked
22:12:25.019913: profiles/audio/avdtp.c:avdtp_ref() 0x51d00001e080: ref=3
22:12:25.019931: profiles/audio/a2dp.c:setup_ref() 0x50b00000c4e0: ref=1
22:12:25.019963: profiles/audio/transport.c:transport_set_state() State changed /org/bluez/hci1/dev_B8_7B_D4_07_04_65/fd0: TRANSPORT_STATE_IDLE -> TRANSPORT_STATE_REQUESTING
22:12:25.019989: profiles/audio/transport.c:media_request_create() Request created: method=Acquire id=1
22:12:25.020006: profiles/audio/transport.c:media_owner_add() Owner :1.712 Request Acquire
22:12:25.020019: profiles/audio/transport.c:media_transport_set_owner() Transport /org/bluez/hci1/dev_B8_7B_D4_07_04_65/fd0 Owner :1.712
22:12:25.119349: [:1.712:method_call] > org.bluez.BatteryProviderManager1.RegisterBatteryProvider [#38]
22:12:25.119384: src/battery.c:register_battery_provider() register battery provider path = /org/freedesktop/pipewire/battery
22:12:25.119889: [org.freedesktop.DBus:method_call] < org.freedesktop.DBus.AddMatch
22:12:25.119922: [:1.712:method_return] < [#38]
22:12:25.119993: [:1.712:method_call] < org.freedesktop.DBus.ObjectManager.GetManagedObjects
22:12:25.134083: src/battery.c:btd_battery_register() path = /org/bluez/hci1/dev_B8_7B_D4_07_04_65
22:12:25.134144: src/battery.c:btd_battery_register() registered Battery object: /org/bluez/hci1/dev_B8_7B_D4_07_04_65
22:12:25.134161: src/battery.c:provided_battery_added_cb() provided battery added /org/freedesktop/pipewire/battery/org/bluez/hci1/dev_B8_7B_D4_07_04_65
22:12:25.134177: src/battery.c:btd_battery_update() path = /org/bluez/hci1/dev_B8_7B_D4_07_04_65
22:12:25.134341: [signal] org.freedesktop.DBus.ObjectManager.InterfacesAdded
22:12:25.135316: [:1.25:method_call] > org.freedesktop.DBus.Properties.GetAll [#556]
22:12:25.135391: [:1.25:method_return] < [#556]
22:12:25.136316: [:1.25:method_call] > org.freedesktop.DBus.Properties.GetAll [#563]
22:12:25.136348: [:1.25:method_return] < [#563]
22:12:25.345298: [:1.712:method_call] > org.bluez.MediaTransport1.Release [#41]
22:12:25.345341: profiles/audio/transport.c:release() Owner :1.712
22:12:25.345369: profiles/audio/transport.c:media_request_reply() Request Acquire Reply Operation canceled
22:12:25.345429: [:1.712:error] < org.bluez.Error.Failed [#37]
22:12:25.345472: profiles/audio/transport.c:media_owner_remove() Owner :1.712 Request Acquire
22:12:25.345511: profiles/audio/transport.c:transport_set_state() State changed /org/bluez/hci1/dev_B8_7B_D4_07_04_65/fd0: TRANSPORT_STATE_REQUESTING -> TRANSPORT_STATE_SUSPENDING
22:12:25.345562: profiles/audio/transport.c:media_transport_suspend() Transport /org/bluez/hci1/dev_B8_7B_D4_07_04_65/fd0 Owner :1.712
22:12:25.345582: profiles/audio/transport.c:media_request_create() Request created: method=Release id=1
22:12:25.345617: profiles/audio/transport.c:media_owner_add() Owner :1.712 Request Release
22:12:25.345875: [signal] org.freedesktop.DBus.Properties.PropertiesChanged
22:12:26.921547: profiles/audio/avdtp.c:session_cb()
22:12:26.921609: profiles/audio/avdtp.c:avdtp_parse_resp() START request succeeded
22:12:26.921631: profiles/audio/a2dp.c:start_cfm() Source 0x506000047f60: Start_Cfm
22:12:26.921650: profiles/audio/transport.c:a2dp_resume_complete() cancel resume
22:12:26.921687: profiles/audio/a2dp.c:setup_unref() 0x50b00000c4e0: ref=0
22:12:26.921703: profiles/audio/a2dp.c:setup_free() 0x50b00000c4e0
22:12:26.921721: profiles/audio/avdtp.c:avdtp_unref() 0x51d00001e080: ref=2
22:12:26.921745: profiles/audio/avdtp.c:avdtp_sep_set_state() stream state changed: OPEN -> STREAMING
22:12:26.921768: profiles/audio/sink.c:sink_set_state() State changed /org/bluez/hci1/dev_B8_7B_D4_07_04_65: SINK_STATE_CONNECTED -> SINK_STATE_PLAYING
22:12:26.921787: profiles/audio/transport.c:transport_update_playing() /org/bluez/hci1/dev_B8_7B_D4_07_04_65/fd0 State=TRANSPORT_STATE_SUSPENDING Playing=1
22:12:26.921856: profiles/audio/avdtp.c:avdtp_ref() 0x51d00001e080: ref=3
22:12:26.921876: profiles/audio/a2dp.c:setup_ref() 0x50b000041280: ref=1
22:12:27.005487: profiles/audio/avdtp.c:session_cb()
22:12:27.005555: profiles/audio/avdtp.c:avdtp_parse_resp() SUSPEND request succeeded
22:12:27.005592: profiles/audio/avdtp.c:avdtp_sep_set_state() stream state changed: STREAMING -> OPEN
22:12:27.005643: profiles/audio/sink.c:sink_set_state() State changed /org/bluez/hci1/dev_B8_7B_D4_07_04_65: SINK_STATE_PLAYING -> SINK_STATE_CONNECTED
22:12:27.005678: profiles/audio/transport.c:transport_update_playing() /org/bluez/hci1/dev_B8_7B_D4_07_04_65/fd0 State=TRANSPORT_STATE_SUSPENDING Playing=0
22:12:27.005717: profiles/audio/a2dp.c:suspend_cfm() Source 0x506000047f60: Suspend_Cfm
22:12:27.005760: profiles/audio/transport.c:media_request_reply() Request Release Reply Success
22:12:27.005836: [:1.712:method_return] < [#41]
22:12:27.005903: profiles/audio/transport.c:media_owner_remove() Owner :1.712 Request Release
22:12:27.005950: profiles/audio/a2dp.c:a2dp_sep_unlock() SEP 0x506000047f60 unlocked
22:12:27.005987: profiles/audio/transport.c:transport_set_state() State changed /org/bluez/hci1/dev_B8_7B_D4_07_04_65/fd0: TRANSPORT_STATE_SUSPENDING -> TRANSPORT_STATE_IDLE
22:12:27.006079: profiles/audio/transport.c:media_transport_remove_owner() Transport /org/bluez/hci1/dev_B8_7B_D4_07_04_65/fd0 Owner :1.712
22:12:27.006142: profiles/audio/transport.c:media_owner_free() Owner :1.712
22:12:27.006184: profiles/audio/a2dp.c:setup_unref() 0x50b000041280: ref=0
22:12:27.006215: profiles/audio/a2dp.c:setup_free() 0x50b000041280
22:12:27.006271: profiles/audio/avdtp.c:avdtp_unref() 0x51d00001e080: ref=2
----------------------------------------------------------

Log: Acquire() -> canceled by Release() -> Acquire()
----------------------------------------------------------
The second Acquire is rejected, and transport is suspended.
The behavior of rejecting Acquire() while there is another ongoing
operation is same as before this patch.

21:35:25.437755: [:1.635:method_call] > org.bluez.MediaTransport1.Acquire [#49]
21:35:25.437786: profiles/audio/transport.c:media_owner_create() Owner created: sender=:1.635
21:35:25.437804: profiles/audio/transport.c:media_transport_resume() Transport /org/bluez/hci1/dev_B8_7B_D4_07_04_65/sep1/fd0 Owner :1.635
21:35:25.437820: profiles/audio/a2dp.c:a2dp_sep_lock() SEP 0x506000048020 locked
21:35:25.437838: profiles/audio/avdtp.c:avdtp_ref() 0x51d00001ea80: ref=3
21:35:25.437855: profiles/audio/a2dp.c:setup_ref() 0x50b000040af0: ref=1
21:35:30.438045: profiles/audio/transport.c:transport_set_state() State changed /org/bluez/hci1/dev_B8_7B_D4_07_04_65/sep1/fd0: TRANSPORT_STATE_IDLE -> TRANSPORT_STATE_REQUESTING
21:35:30.438114: profiles/audio/transport.c:media_request_create() Request created: method=Acquire id=13
21:35:30.438150: profiles/audio/transport.c:media_owner_add() Owner :1.635 Request Acquire
21:35:30.438182: profiles/audio/transport.c:media_transport_set_owner() Transport /org/bluez/hci1/dev_B8_7B_D4_07_04_65/sep1/fd0 Owner :1.635
21:35:30.438622: [:1.635:method_call] > org.bluez.MediaTransport1.Release [#50]
21:35:30.438667: profiles/audio/transport.c:release() Owner :1.635
21:35:30.438703: profiles/audio/transport.c:media_request_reply() Request Acquire Reply Operation canceled
21:35:30.438823: [:1.635:error] < org.bluez.Error.Failed [#49]
21:35:30.438885: profiles/audio/transport.c:media_owner_remove() Owner :1.635 Request Acquire
21:35:30.438929: profiles/audio/transport.c:transport_set_state() State changed /org/bluez/hci1/dev_B8_7B_D4_07_04_65/sep1/fd0: TRANSPORT_STATE_REQUESTING -> TRANSPORT_STATE_SUSPENDING
21:35:30.439042: profiles/audio/transport.c:media_transport_suspend() Transport /org/bluez/hci1/dev_B8_7B_D4_07_04_65/sep1/fd0 Owner :1.635
21:35:30.439082: profiles/audio/transport.c:media_request_create() Request created: method=Release id=13
21:35:30.439115: profiles/audio/transport.c:media_owner_add() Owner :1.635 Request Release
21:35:30.439178: [:1.635:method_call] > org.bluez.MediaTransport1.Acquire [#51]
21:35:30.439436: [signal] org.freedesktop.DBus.Properties.PropertiesChanged
21:35:30.439509: [:1.635:error] < org.bluez.Error.NotAuthorized [#51]
21:35:30.580542: profiles/audio/avdtp.c:session_cb()
21:35:30.580637: profiles/audio/avdtp.c:avdtp_parse_resp() START request succeeded
21:35:30.580691: profiles/audio/a2dp.c:start_cfm() Source 0x506000048020: Start_Cfm
21:35:30.580723: profiles/audio/transport.c:a2dp_resume_complete() cancel resume
21:35:30.580772: profiles/audio/a2dp.c:setup_unref() 0x50b000040af0: ref=0
21:35:30.580801: profiles/audio/a2dp.c:setup_free() 0x50b000040af0
21:35:30.580832: profiles/audio/avdtp.c:avdtp_unref() 0x51d00001ea80: ref=2
21:35:30.580866: profiles/audio/avdtp.c:avdtp_sep_set_state() stream state changed: OPEN -> STREAMING
21:35:30.580902: profiles/audio/sink.c:sink_set_state() State changed /org/bluez/hci1/dev_B8_7B_D4_07_04_65: SINK_STATE_CONNECTED -> SINK_STATE_PLAYING
21:35:30.580935: profiles/audio/transport.c:transport_update_playing() /org/bluez/hci1/dev_B8_7B_D4_07_04_65/sep1/fd0 State=TRANSPORT_STATE_SUSPENDING Playing=1
21:35:30.581091: profiles/audio/avdtp.c:avdtp_ref() 0x51d00001ea80: ref=3
21:35:30.581142: profiles/audio/a2dp.c:setup_ref() 0x50b0000413e0: ref=1
21:35:30.656521: profiles/audio/avdtp.c:session_cb()
21:35:30.656583: profiles/audio/avdtp.c:avdtp_parse_resp() SUSPEND request succeeded
21:35:30.656617: profiles/audio/avdtp.c:avdtp_sep_set_state() stream state changed: STREAMING -> OPEN
21:35:30.656652: profiles/audio/sink.c:sink_set_state() State changed /org/bluez/hci1/dev_B8_7B_D4_07_04_65: SINK_STATE_PLAYING -> SINK_STATE_CONNECTED
21:35:30.656684: profiles/audio/transport.c:transport_update_playing() /org/bluez/hci1/dev_B8_7B_D4_07_04_65/sep1/fd0 State=TRANSPORT_STATE_SUSPENDING Playing=0
21:35:30.656717: profiles/audio/a2dp.c:suspend_cfm() Source 0x506000048020: Suspend_Cfm
21:35:30.656756: profiles/audio/transport.c:media_request_reply() Request Release Reply Success
21:35:30.656819: [:1.635:method_return] < [#50]
21:35:30.656878: profiles/audio/transport.c:media_owner_remove() Owner :1.635 Request Release
21:35:30.656915: profiles/audio/a2dp.c:a2dp_sep_unlock() SEP 0x506000048020 unlocked
21:35:30.656949: profiles/audio/transport.c:transport_set_state() State changed /org/bluez/hci1/dev_B8_7B_D4_07_04_65/sep1/fd0: TRANSPORT_STATE_SUSPENDING -> TRANSPORT_STATE_IDLE
21:35:30.657024: profiles/audio/transport.c:media_transport_remove_owner() Transport /org/bluez/hci1/dev_B8_7B_D4_07_04_65/sep1/fd0 Owner :1.635
21:35:30.657076: profiles/audio/transport.c:media_owner_free() Owner :1.635
21:35:30.657110: profiles/audio/a2dp.c:setup_unref() 0x50b0000413e0: ref=0
21:35:30.657139: profiles/audio/a2dp.c:setup_free() 0x50b0000413e0
21:35:30.657169: profiles/audio/avdtp.c:avdtp_unref() 0x51d00001ea80: ref=2
----------------------------------------------------------

Log: Acquire() -> canceled by Release() -> canceled by SetConfiguration()
----------------------------------------------------------
This works, and results to transport being configured successfully.

In this log, the timing to hit the races was achieved by adding sleep(5)
in avdtp_start() + making Pipewire not wait for Release().

21:07:38.716895: [:1.607:method_call] > org.bluez.MediaTransport1.Acquire [#36]
21:07:38.716930: profiles/audio/transport.c:media_owner_create() Owner created: sender=:1.607
21:07:38.716947: profiles/audio/transport.c:media_transport_resume() Transport /org/bluez/hci1/dev_B8_7B_D4_07_04_65/sep2/fd2 Owner :1.607
21:07:38.716974: profiles/audio/avdtp.c:avdtp_ref() 0x51d000020880: ref=2
21:07:38.716990: profiles/audio/a2dp.c:a2dp_sep_lock() SEP 0x506000040580 locked
21:07:38.717005: profiles/audio/avdtp.c:avdtp_ref() 0x51d000020880: ref=3
21:07:38.717033: profiles/audio/a2dp.c:setup_ref() 0x50b000041f90: ref=1
21:07:43.717234: profiles/audio/transport.c:transport_set_state() State changed /org/bluez/hci1/dev_B8_7B_D4_07_04_65/sep2/fd2: TRANSPORT_STATE_IDLE -> TRANSPORT_STATE_REQUESTING
21:07:43.717301: profiles/audio/transport.c:media_request_create() Request created: method=Acquire id=5
21:07:43.717333: profiles/audio/transport.c:media_owner_add() Owner :1.607 Request Acquire
21:07:43.717369: profiles/audio/transport.c:media_transport_set_owner() Transport /org/bluez/hci1/dev_B8_7B_D4_07_04_65/sep2/fd2 Owner :1.607
21:07:43.717770: [:1.607:method_call] > org.bluez.MediaTransport1.Release [#37]
21:07:43.717800: profiles/audio/transport.c:release() Owner :1.607
21:07:43.717825: profiles/audio/transport.c:media_request_reply() Request Acquire Reply Operation canceled
21:07:43.717898: [:1.607:error] < org.bluez.Error.Failed [#36]
21:07:43.717937: profiles/audio/transport.c:media_owner_remove() Owner :1.607 Request Acquire
21:07:43.717977: profiles/audio/transport.c:transport_set_state() State changed /org/bluez/hci1/dev_B8_7B_D4_07_04_65/sep2/fd2: TRANSPORT_STATE_REQUESTING -> TRANSPORT_STATE_SUSPENDING
21:07:43.718012: profiles/audio/transport.c:media_transport_suspend() Transport /org/bluez/hci1/dev_B8_7B_D4_07_04_65/sep2/fd2 Owner :1.607
21:07:43.718027: profiles/audio/transport.c:media_request_create() Request created: method=Release id=5
21:07:43.718038: profiles/audio/transport.c:media_owner_add() Owner :1.607 Request Release
21:07:43.718076: [:1.607:method_call] > org.bluez.MediaEndpoint1.SetConfiguration [#38]
21:07:43.718118: profiles/audio/a2dp.c:setup_ref() 0x50b000041f90: ref=2
21:07:43.718316: [signal] org.freedesktop.DBus.Properties.PropertiesChanged
21:07:44.184499: profiles/audio/avdtp.c:session_cb()
21:07:44.184565: profiles/audio/avdtp.c:avdtp_parse_resp() START request succeeded
21:07:44.184603: profiles/audio/a2dp.c:start_cfm() Source 0x506000040580: Start_Cfm
21:07:44.184624: profiles/audio/transport.c:a2dp_resume_complete() cancel resume
21:07:44.184659: profiles/audio/a2dp.c:setup_unref() 0x50b000041f90: ref=1
21:07:44.184681: profiles/audio/avdtp.c:avdtp_sep_set_state() stream state changed: OPEN -> STREAMING
21:07:44.184705: profiles/audio/sink.c:sink_set_state() State changed /org/bluez/hci1/dev_B8_7B_D4_07_04_65: SINK_STATE_CONNECTED -> SINK_STATE_PLAYING
21:07:44.184725: profiles/audio/transport.c:transport_update_playing() /org/bluez/hci1/dev_B8_7B_D4_07_04_65/sep2/fd2 State=TRANSPORT_STATE_SUSPENDING Playing=1
21:07:44.184854: profiles/audio/a2dp.c:setup_ref() 0x50b000041f90: ref=2
21:07:44.184909: profiles/audio/a2dp.c:setup_unref() 0x50b000041f90: ref=1
21:07:44.184930: profiles/audio/transport.c:media_transport_remove_owner() Transport /org/bluez/hci1/dev_B8_7B_D4_07_04_65/sep2/fd2 Owner :1.607
21:07:44.184956: profiles/audio/transport.c:media_request_reply() Request Release Reply Input/output error
21:07:44.185019: [:1.607:error] < org.bluez.Error.Failed [#37]
21:07:44.185088: profiles/audio/transport.c:media_owner_free() Owner :1.607
21:07:44.185106: profiles/audio/transport.c:media_owner_remove() Owner :1.607 Request Release
21:07:44.185134: profiles/audio/transport.c:media_transport_suspend() Transport /org/bluez/hci1/dev_B8_7B_D4_07_04_65/sep2/fd2 Owner
21:07:44.185152: profiles/audio/transport.c:transport_set_state() State changed /org/bluez/hci1/dev_B8_7B_D4_07_04_65/sep2/fd2: TRANSPORT_STATE_SUSPENDING -> TRANSPORT_STATE_IDLE
21:07:44.185213: profiles/audio/a2dp.c:a2dp_sep_unlock() SEP 0x506000040580 unlocked
21:07:44.185409: [signal] org.freedesktop.DBus.Properties.PropertiesChanged
21:07:44.228552: profiles/audio/avdtp.c:session_cb()
21:07:44.228612: profiles/audio/avdtp.c:avdtp_parse_resp() CLOSE request succeeded
21:07:44.228631: profiles/audio/avdtp.c:avdtp_sep_set_state() stream state changed: STREAMING -> CLOSING
21:07:44.228737: profiles/audio/a2dp.c:close_cfm() Source 0x506000040580: Close_Cfm
21:07:44.228758: profiles/audio/a2dp.c:setup_reconfigure() 0x50b000041f90
21:07:44.228780: profiles/audio/avdtp.c:avdtp_sep_set_state() stream state changed: CLOSING -> IDLE
21:07:44.228848: [:1.607:method_call] < org.bluez.MediaEndpoint1.ClearConfiguration
21:07:44.228944: profiles/audio/avdtp.c:avdtp_unref() 0x51d000020880: ref=2
21:07:44.229227: [signal] org.freedesktop.DBus.ObjectManager.InterfacesRemoved
21:07:44.229318: src/service.c:change_state() 0x504000036550: device B8:7B:D4:07:04:65 profile a2dp-sink state changed: connected -> disconnected (0)
21:07:44.229349: plugins/policy.c:policy_disconnect() /org/bluez/hci1/dev_B8_7B_D4_07_04_65 profile avrcp-controller
21:07:44.229370: src/service.c:change_state() 0x504000036590: device B8:7B:D4:07:04:65 profile avrcp-controller state changed: connected -> disconnecting (0)
21:07:44.229390: profiles/audio/avrcp.c:avrcp_disconnect() path /org/bluez/hci1/dev_B8_7B_D4_07_04_65
21:07:44.229433: src/service.c:change_state() 0x504000036690: device B8:7B:D4:07:04:65 profile audio-avrcp-target state changed: connected -> disconnected (0)
21:07:44.229472: src/service.c:change_state() 0x504000036590: device B8:7B:D4:07:04:65 profile avrcp-controller state changed: disconnecting -> disconnected (0)
21:07:44.229504: profiles/audio/avrcp.c:controller_destroy() 0x503000096220
21:07:44.229532: profiles/audio/avrcp.c:target_destroy() 0x5030000963a0
21:07:44.229623: profiles/audio/avctp.c:avctp_set_state() AVCTP Disconnected
21:07:44.229711: profiles/audio/avctp.c:avctp_disconnected() AVCTP: closing uinput for B8:7B:D4:07:04:65
21:07:44.253516: profiles/audio/avdtp.c:avdtp_unref() 0x51d000020880: ref=1
21:07:44.253781: [signal] org.freedesktop.DBus.Properties.PropertiesChanged
21:07:44.729455: profiles/audio/avdtp.c:avdtp_set_configuration() 0x51d000020880: int_seid=13, acp_seid=1
21:07:44.855438: profiles/audio/avdtp.c:session_cb()
21:07:44.855495: profiles/audio/avdtp.c:avdtp_parse_resp() SET_CONFIGURATION request succeeded
21:07:44.855516: profiles/audio/a2dp.c:setconf_cfm() Source 0x506000041300: Set_Configuration_Cfm
21:07:44.855544: profiles/audio/avdtp.c:avdtp_ref() 0x51d000020880: ref=2
21:07:44.855566: profiles/audio/a2dp.c:setup_ref() 0x50b000041f90: ref=2
21:07:44.855921: [signal] org.freedesktop.DBus.ObjectManager.InterfacesAdded
21:07:44.856004: [:1.607:method_call] < org.bluez.MediaEndpoint1.SetConfiguration
21:07:44.856045: profiles/audio/media.c:media_endpoint_async_call() Calling SetConfiguration: name = :1.607 path = /MediaEndpoint/A2DPSource/sbc
21:07:44.856067: profiles/audio/avdtp.c:avdtp_sep_set_state() stream state changed: IDLE -> CONFIGURED
21:07:44.857056: profiles/audio/a2dp.c:setup_unref() 0x50b000041f90: ref=1
21:07:44.860524: profiles/audio/avdtp.c:session_cb()
21:07:44.860643: profiles/audio/avdtp.c:avdtp_parse_cmd() Received DELAY_REPORT_CMD
21:07:44.860730: profiles/audio/a2dp.c:endpoint_delayreport_ind() Source 0x506000041300: DelayReport_Ind
21:07:44.861171: [signal] org.freedesktop.DBus.Properties.PropertiesChanged
21:07:44.950548: profiles/audio/avdtp.c:session_cb()
21:07:44.950612: profiles/audio/avdtp.c:avdtp_parse_resp() OPEN request succeeded
21:07:45.175581: profiles/audio/avdtp.c:avdtp_connect_cb() AVDTP: connected transport channel to B8:7B:D4:07:04:65
21:07:45.175639: profiles/audio/avdtp.c:handle_transport_connect() Flushable packets enabled
21:07:45.175661: profiles/audio/avdtp.c:handle_transport_connect() sk 60, omtu 679, send buffer size 106496
21:07:45.175681: profiles/audio/a2dp.c:open_cfm() Source 0x506000041300: Open_Cfm
21:07:45.183071: [:1.607:method_return] < [#38]
21:07:45.183123: profiles/audio/a2dp.c:setup_unref() 0x50b000041f90: ref=0
21:07:45.183143: profiles/audio/a2dp.c:setup_free() 0x50b000041f90
21:07:45.183162: profiles/audio/avdtp.c:avdtp_unref() 0x51d000020880: ref=1
21:07:45.183184: profiles/audio/avdtp.c:avdtp_sep_set_state() stream state changed: CONFIGURED -> OPEN
21:07:45.183212: src/service.c:change_state() 0x504000036550: device B8:7B:D4:07:04:65 profile a2dp-sink state changed: disconnected -> connected (0)
21:07:45.183251: plugins/policy.c:service_cb() Added a2dp-sink reconnect 1
21:07:45.183271: profiles/audio/sink.c:sink_set_state() State changed /org/bluez/hci1/dev_B8_7B_D4_07_04_65: SINK_STATE_PLAYING -> SINK_STATE_CONNECTED
21:07:45.183301: profiles/audio/transport.c:transport_update_playing() /org/bluez/hci1/dev_B8_7B_D4_07_04_65/sep1/fd3 State=TRANSPORT_STATE_IDLE Playing=0
----------------------------------------------------------

Pauli Virtanen (2):
  transport: don't disconnect A2DP if canceling Acquire() with Release()
  a2dp: don't change setup sep when it is reconfiguring

 profiles/audio/a2dp.c      |   6 ++
 profiles/audio/transport.c | 179 ++++++++++++++++++++++++++++---------
 2 files changed, 143 insertions(+), 42 deletions(-)

-- 
2.47.0

