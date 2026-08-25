Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F414A3955EB
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Aug 2026 11:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787657796; cv=pass; b=qOig5oYOWNgRkWPTaO2a1Bo7A8qOzB2lYKYh4/DESfylZjr8OM3rLFNqOAN1clfV9+LiTfx2ojlwVz06gYYZAB5NRpCmRwbuIzH11vwVBU+Rf3Eg/Vo1db0DKAJ9OAYBUR1mlcHOyFClNb4jo94kQCHORNR0y4ZVL7pLWDQooQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787657796; c=relaxed/simple;
	bh=Rbnp/EYWezZHg4nfC9+tYASr8uqSvHDmVzvCWGo8+NY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=oPictAjW1QInAe+UUM6zbhhZdF+Xq6GoN9sw5I6fxPHrSh3lSAE00Ruvj4nCD2RoDCV/qalju4UifTvQy+JyBCws9gclyBfviue7eojevheFz21XvXvNWQ2qMc1BXThkalldqKxNd/+t1QvO6jOhyNxPkLRPxYy+Ghbjom88Xm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gDNrjZtw; arc=pass smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gDNrjZtw"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5c30d9adfa7so1914090e0c.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Aug 2026 04:36:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787657794; cv=none;
        d=google.com; s=arc-20260327;
        b=eXM6KR/T2g5ih47OGYoRSVyMvoOtA3ZpYiOVWqEuWv9mizlmOhQ5m+sc/C/20K0p/a
         Qq7aH3UVzMExnRfZcffzKrncABCccjpptVfMFoR6eHko/Tw9aZVrbCijGAIT8WDr7eGA
         igoNvJgZW2f18tUBlp6Ov/c8Kk1AYIZF4AerzvX7RmGoRMmGXCc4H8KHOR2bsF5B3IJ2
         zjMNz6sGeQyFwkXFf4n8ZUzBDuY9vI8hygSInvWmRvPme7zX7pE0pBfNCnGg3V3C58AO
         dJN6N2NX2npVrH1vhTd7F4u+qo3NdahbpCF05K1Qe6LAlxfcJdVaL7O1g+hzHCFG22Ig
         uidw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=e7RTAYr6tEc0DOnQylpq8Om2ZkE3rHUzdyuDivUKqhI=;
        fh=9ttIwnCQFfOteE4frefQDlDgxEJxCpDm2t5HCB2pVhA=;
        b=QAFEIoR47Nq2rbE8mG0cDPzyLbcC1v5LaLSUyJUvjnkjrDWV8LoRJolqeXfQ3jcDGU
         +97EnR7FgsLwTFlVwoIMfYNen8Byv0AT/uNjxgUoobeZJFTKAgBOO6xu0Su6OV17bW46
         5b4oqQEi5qkrogWLrFuFysW2h3/WqlZqY6zzAYjx3QTPxq8a0ywB/fSIQbucR8wXBP/L
         CgOGRz/iO8TX3olCPOE35H0TykEvb2T1zj+teFzpB5+c4Un887cur/R8lsoddH3XpZr3
         kPNajPzHukhRuUEOuKNmb3YnLooWwiOCw4/pfqtWrF8AGSULJ/+FXOU8t+N81rGcoOjR
         JZnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787657794; x=1788262594; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=e7RTAYr6tEc0DOnQylpq8Om2ZkE3rHUzdyuDivUKqhI=;
        b=gDNrjZtwm65ccylnVazEmc2fgfmWU9W/dTD+Kz8vTwFqvdSBPLaC5+rJ5EodP+WeP2
         vcM7f0JWKUdksttqZNAXvpofBEc0oRFY5jTl0xburveNe1cIFe5S48CW/yKnDALWLJ+/
         uMfWPZ7+gP0TNQTj2OfANb7qib0K3fVsRXrk8XX2YW6bF9lrTsYecfz/gO5BTlzdOlNV
         tx7IKt+BhdZJW4PmjfkCKQE7xHNuQ//I0+wYUKJL6zyCJpCxmDmTgRiqz11Vdnyd1941
         /3OCrhk8tntu8SY+1v/XoS7kCo0h743hbZBxJz0GZ3Z4c6R0mKk/R0IlEVoWFjZWysgJ
         Jj0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787657794; x=1788262594;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=e7RTAYr6tEc0DOnQylpq8Om2ZkE3rHUzdyuDivUKqhI=;
        b=cNZr6ppdPZcJzRZ3yTRd2gYcwUoqANNcJVHqKiAhNmki8rE7y/januRHCOwf3+Pkrs
         Ubu+yaVUcjzcWzitYoEKKfxqb0TnQaTsWDFd2473IZ4nc/+sAviMfuA/H6L+o9ehN3MT
         KeaQ5U+DuyKqN7lGieNE0P3ao+rUffFdxKdPk6dhR6Rxah3NAw9+/rQnjMLk+aw0sfpK
         CiJXVPbLK80of0iXx/ej9VARLuhT0VXkihr3Ng0k8a/goVdNYpthwxiwhEWSTxGelOC4
         sdXq2wbzKJFVHCkKSc5IVVIkZU8rxDwM+SyWqBu5T32Fh4NKpFQpyifYJ0HPMGJAYWX5
         oB4g==
X-Gm-Message-State: AFuF++kU3umg69wPFv374wlCNd6x9sLHgr+pREVGN9p96TdL3bodiL7D
	N7Ow31xC9ha8xtYt1MpIu/OnxS9mUl2SlOeKr0PP0Y8Pr+oePMZy/Wyf4Q7/rxTow8TiJ/G4ZgA
	W2UlJFIVzla6e5KHydn2NqLEP5IwosjBxy+ts
X-Gm-Gg: AR+sD11e44HAqKz2s5B8iYB0WwpN5iC0Z+8NTtbQQJRB/o09jWBCFxNZ7KpRLZHPisN
	wP7GZbPS6pmdylWq6wFnR+qjbRgQLxKpfhNmy83BjPFbOoJNSq05HyyXfqIK0fHKmVZNlvXs08m
	QmLuS3E/fshxWGd/WWYX9IrIGL7CAL7+GERHCYjBcunvoodrulrVk0GWjdmCAk3cmhWyXsQJZKy
	yBDr3XVwEuLvN1pcf26XkYH5x36S6oWLzJ9y2PPU7pLd36TLtzVQj3MrE8xAs+RqUxl760374Ep
	OpMllGsPxChQbDrtaLtxWYPggFKW011c1DnZmdd1xuAXcJdz4OIySIkNx4chcwUZJ974Z2Z3DKb
	udFlJH7RmzVXa4b2Io6eObpWbUlenHRvH
X-Received: by 2002:a05:6102:83ca:b0:77b:fd92:57d8 with SMTP id
 ada2fe7eead31-77bfd92620cmr4712049137.14.1787657793689; Tue, 25 Aug 2026
 04:36:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: BUGPWN <vuln.bugpwn@gmail.com>
Date: Tue, 25 Aug 2026 12:36:22 +0100
X-Gm-Features: AcwNN1V-G46NUQizaThRMB0ChuDBTkK2R9ftThOQkDYBJ-rQAP8aJzHkwB5GvFA
Message-ID: <CAOZc4ksrOkoK8u3Mm5C5bGH_xNL1tn15Pq68oCtijoFpxSGBFA@mail.gmail.com>
Subject: Use-after-free in avdtp_connect_cb() (profiles/audio/avdtp.c) via
 unreferenced transport connect callback
To: security@bluez.org
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Summary
-------

profiles/audio/avdtp.c contains a use-after-free in
avdtp_connect_cb(), reachable when
an AVDTP session is torn down (e.g. the remote peer closes the
signaling channel) while
an asynchronous transport channel connect, started by l2cap_connect(),
is still in
flight. The transport connect's callback is registered without a
reference on the
session object and without a destroy notifier, so it can fire after
the session has
already been freed.

Also submitted via GitHub's private vulnerability reporting.

Confirmed against current git HEAD: commit
efd216fe280ba5dd38d1b6084f64784bf1328731
(2026-07-16).


Vulnerable code
---------------

profiles/audio/avdtp.c:2516-2534, l2cap_connect():

    io = bt_io_connect(avdtp_connect_cb, session, NULL, &err, ...);
    /*
     * no avdtp_ref(session) before this call, and no GDestroyNotify
     * (third argument) either */

bt_io_connect() (btio/btio.c) attaches its own glib watch on the
transport L2CAP socket,
entirely independent of avdtp's own reference counting. If session's
refcount drops to
zero while this watch is still armed (avdtp_unref(),
avdtp.c:1215-1245, frees the
session once ref reaches 0), the next time the watch fires, avdtp_connect_cb()
(avdtp.c:2402) dereferences the already-freed session.


Reachability
------------

1. bluetoothd sends AVDTP_OPEN, the peer accepts it: l2cap_connect() starts an
   asynchronous transport channel connect, with the callback above registered
   unprotected.
2. The peer immediately closes the AVDTP signaling channel.
3. session_cb() (avdtp.c:2258) sees G_IO_HUP, calls connection_lost()
(avdtp.c:1152),
   which can drop session's refcount to zero and free it via avdtp_free()
   (avdtp.c:1121).
4. The transport connect's glib watch is untouched by any of this (nothing ever
   referenced or cancelled it). When it later fires,
avdtp_connect_cb() runs on the
   dangling session pointer.

No pairing beyond an already-established AVDTP session is required
(i.e. this happens
after a normal A2DP connection); the remote peer fully controls the
timing of the
signaling channel closure relative to the transport connect.


Proof of concept
-----------------

Reproducing this over real L2CAP sockets and glib timing would require a virtual
controller (vhci) and a fake peer (bthost/btdev) with precise
two-channel timing.
Instead we noted that the bug does not actually
depend on network timing itself, only on the logical order of two
events on the same
session object (its being freed, and the transport callback firing
late), which we can
force directly and deterministically using the real code:

1. We built a real struct avdtp by hand (ref=1, state=CONNECTING,
matching a session
   with a transport connect in flight after AVDTP_OPEN). struct avdtp
is private to
   avdtp.c, so we reached it (and the static
avdtp_connect_cb()/connection_lost()) by
   #include-ing the real, unmodified file, the same technique used for
our bass.c PoC.

2. We called the real, public avdtp_unref() exactly once, the only
entry point a real
   caller uses. Because ref drops to 0 while state is CONNECTING, this
one call drives
   the entire real teardown chain inside unmodified code: avdtp_unref() ->
   connection_lost() -> avdtp_set_state(DISCONNECTED) -> avdtp_unref()
-> avdtp_free().
   We never called avdtp_free() or connection_lost() ourselves.

3. session is now genuinely freed heap memory. We then called the real
avdtp_connect_cb()
   directly on it, simulating the transport socket's glib watch firing
late, exactly
   what l2cap_connect()'s missing ref/destroy-notify fails to prevent
in the real code.

device.h/adapter.h/btio.h/sink.h/source.h/sdp_lib.h dependencies not
on this path were
provided by minimal stubs (none of them are exercised in this
scenario; they only need
to exist for linking).

Built with AddressSanitizer:

    gcc -I. -Ilib $(pkg-config --cflags glib-2.0 dbus-1) \
        -fsanitize=address -fno-omit-frame-pointer -g -O0 \
        -o poc_p1_uaf poc_p1_uaf.c stubs.c \
        src/shared/queue.c src/shared/util.c src/shared/timeout-glib.c \
        lib/bluetooth/bluetooth.c $(pkg-config --libs glib-2.0)

Result:

    ==7610==ERROR: AddressSanitizer: heap-use-after-free on address ...
    READ of size 8 at ...
        #0 in avdtp_connect_cb profiles/audio/avdtp.c:2414
        #1 in main poc_p1_uaf.c:98

    freed by thread T0 here:
        #0 in free ...
        #1 in avdtp_free profiles/audio/avdtp.c:1149
        #2 in avdtp_unref profiles/audio/avdtp.c:1242
        #3 in connection_lost profiles/audio/avdtp.c:1168
        #4 in avdtp_unref profiles/audio/avdtp.c:1238
        #5 in main poc_p1_uaf.c:84

    previously allocated by thread T0 here:
        #0 in calloc ...
        #1 in g_malloc0 ...

The "freed by" trace confirms, with the real lines from the
repository, exactly the
chain the audit predicted: a single avdtp_unref() call unwinds the whole real
avdtp_unref -> connection_lost -> avdtp_set_state -> avdtp_unref ->
avdtp_free path. The
crash itself confirms avdtp_connect_cb() dereferences session (the "if
(!session->io)"
check, avdtp.c:2414) after that.

We're happy to share the PoC in whatever format
is convenient.


Impact
------

A malicious or misbehaving AVDTP peer (a Bluetooth headset, speaker,
or any A2DP-capable
device bluetoothd connects to) that accepts a transport channel open
request and then
immediately closes the signaling channel can trigger a use-after-free
inside bluetoothd
(a root-owned daemon), with no user interaction beyond an
already-established A2DP
connection.



Reporter
--------

BUG|PWN & Sadoc ADONON
vuln.bugpwn@gmail.com



-- 
Vuln @ BUG|PWN Team
Email: vuln.bugpwn@gmail.com
Twitter
Linkedin
