Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Sat, 6 Aug 2011 12:40:51 +0200
Message-ID: <CAN_we7Mu76-iFWpphd+Hxnq314-xOURLomDRHGfXrsc2k5+qNA@mail.gmail.com>
Subject: Memory leak in obexd/plugins/opp.c
From: Daniele Forsi <dforsi@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

cppcheck shows this:
[./plugins/opp.c:146]: (error) Memory leak: folder

I'm not sending a patch because I can't test it and it seems that the
g_strdup()'s can be removed because the folder and name variables are
only used as arguments to g_build_filename()
-- 
Daniele Forsi
