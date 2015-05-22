Return-Path: <cyrus@holtmann.org>
From: Chan-yeol Park <chanyeol.park@samsung.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH RFC 0/6] how to share the code between android/avdtp.* and
 profile/audio/avdtp.*
Date: Fri, 22 May 2015 19:27:57 +0900
Message-id: <1432290483-2910-1-git-send-email-chanyeol.park@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

I would like to propose and discuss how to share the code between between
android/avdtp.[ch] and profile/audio/avdtp.[ch]. This mail is written based on
your proposal in IRC yesterday. I agree we need to consider AVRCP also.

As far as I understand they are very similar except profile/audio dependencies. 

So I consider the below steps.

1. Merge patches in android/avdtp.[ch] into profile/audio/avdtp.[ch]
*This step would merge the patches made during PTS verification.
 To discuss I raised some of patches. After discussion I would raise remain
 patches.

2. Move the same codes between android/ and profile/. to the common files.
 For example:
 src/shared/avdtp-common.c
 src/shared/avdtp-common.h
 src/shared/avdtp-internal.h
  -> this file would have local definition in avdtp.c[android, profile/audio]

3. Handle dependencies in profile/audio/avdtp.[ch]
Actually regarding this part I have no idea until now.
I guess this could be discussed easily once we complete 1,2 tasks because at
that time most of the same code are moved into src/shared so it would be easy
 to see the dependencies are remained.

Chan-yeol Park (6):
  audio/avdtp: Fix not calling callback if DISCOVER is rejected
  audio/avdtp: Fix not calling callback if GET_CAPABILITIES is rejected
  audio/avdtp: Fix not calling callback if GET_CONFIGURATION is rejected
  audio/avdtp:-Fix-not-removing-start_timer-source
  audio/a2dp: Move PSM definition to AVDTP header
  Move avdtp common  code into src/shared

 Makefile.am            |   1 +
 android/avdtp.c        | 240 +------------------------------------------
 profiles/audio/a2dp.c  |   2 -
 profiles/audio/avdtp.c | 272 +++++--------------------------------------------
 profiles/audio/avdtp.h |   2 +
 5 files changed, 28 insertions(+), 489 deletions(-)

-- 
2.1.4

