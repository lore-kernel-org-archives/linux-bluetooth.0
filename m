Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 26 Oct 2010 08:32:39 -0700
Message-ID: <AANLkTikksLAeocFsM5vO0rnvphgOo_CoF1ZA_wkABY=c@mail.gmail.com>
Subject: [PATCH] Fix a2dp play when sample rate changed
From: John Crosbie <john@excelfore.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I have found that playing a 48KHz wav file immediately after playing a
44.1K file (or vice-versa) with aplay will fail.  After this failure
no a2dp stream will play.  The problem is that after determining the
current avdtp stream doesn't match the new configuration the stream is
closed and a reconfiguration is attempted but fails because
setup->rsep is null.  The patch below fixes the reconfiguration.

John Crosbie
Excelfore Corporation


diff --git a/audio/a2dp.c b/audio/a2dp.c
index 7a36132..b9b5e4a 100644
--- a/audio/a2dp.c
+++ b/audio/a2dp.c
@@ -1028,6 +1028,12 @@ static gboolean a2dp_reconfigure(gpointer data)
        struct a2dp_sep *sep = setup->sep;
        int posix_err;

+       if(!setup->rsep)
+               setup->rsep = avdtp_find_remote_sep(setup->session, sep->lsep);
        posix_err = avdtp_set_configuration(setup->session, setup->rsep,
                                                sep->lsep,
                                                setup->client_caps,
