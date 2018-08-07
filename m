Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: David Carlos Manuelda <stormbyte@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: David Carlos Manuelda <stormbyte@gmail.com>
Subject: [PATCH BlueZ 0/1] Fix compilation with clang
Date: Tue,  7 Aug 2018 16:09:32 +0200
Message-Id: <20180807140933.11528-1-stormbyte@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

ISO C forbids nested functions, which gcc implemented as extension

David Carlos Manuelda (1):
  build: Clang fix - ISO C forbids nested functions

 profiles/midi/midi.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

-- 
2.18.0

