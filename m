Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH 2/3] profiles/midi: Fix compilation with GCC 8
Date: Wed,  9 May 2018 14:11:12 +0200
Message-Id: <20180509121113.4110-2-szymon.janc@codecoup.pl>
In-Reply-To: <20180509121113.4110-1-szymon.janc@codecoup.pl>
References: <20180509121113.4110-1-szymon.janc@codecoup.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We can use strcpy here since addr is smaller.

  CC       profiles/midi/bluetoothd-midi.o
profiles/midi/midi.c: In function ‘midi_accept’:
profiles/midi/midi.c:307:36: error: argument to ‘sizeof’
       in ‘strncpy’ call is the same expression as the source;
       did you mean to use the size of the destination?
       [-Werror=sizeof-pointer-memaccess]
   strncpy(device_name, addr, sizeof(addr));
                                    ^
cc1: all warnings being treated as errors
---
 profiles/midi/midi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/midi/midi.c b/profiles/midi/midi.c
index fdc1c007d..9e04d19e3 100644
--- a/profiles/midi/midi.c
+++ b/profiles/midi/midi.c
@@ -304,7 +304,7 @@ static int midi_accept(struct btd_service *service)
 	if (device_name_known(device))
 		device_get_name(device, device_name, sizeof(device_name));
 	else
-		strncpy(device_name, addr, sizeof(addr));
+		strcpy(device_name, addr);
 
 	/* ALSA Sequencer Client and Port Setup */
 	err = snd_seq_open(&midi->seq_handle, "default", SND_SEQ_OPEN_DUPLEX, 0);
-- 
2.17.0

