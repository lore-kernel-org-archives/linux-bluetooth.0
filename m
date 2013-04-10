Return-Path: <cyrus@holtmann.org>
From: Alex Deymo <deymo@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, Alex Deymo <deymo@chromium.org>
Subject: [PATCH 0/6] Autopair plugin revisited
Date: Wed, 10 Apr 2013 14:19:07 -0700
Message-Id: <1365628753-16774-1-git-send-email-deymo@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi
I went through this patch set again to fix some details. I may work in
some improvements for it in the future but think this is already a good
start.

As I tested, remote initiated bondings don't have a bonding_req and don't
go through these plugins anyway... but correct me if I'm missing something.

Repeated attempts errors are handled failing the pairing with an
AuthenticationCanceled error.

Please take a look, thanks!
Alex.

Alex Deymo (6):
  core: Convert the pincode callback to an interable list.
  plugins: Extend the pin code callback with the call number
  core: Add support for retrying a bonding
  core: retry bonding attempt until the iterator reachs the end.
  core: Add device_get_class to the public interface.
  autopair: Add the autopair plugin.

 Makefile.plugins   |   3 ++
 plugins/autopair.c | 145 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 plugins/wiimote.c  |   7 ++-
 src/adapter.c      | 143 ++++++++++++++++++++++++++++++++++++++++++++--------
 src/adapter.h      |  10 +++-
 src/device.c       |  79 ++++++++++++++++++++++++++++-
 src/device.h       |   5 ++
 7 files changed, 366 insertions(+), 26 deletions(-)
 create mode 100644 plugins/autopair.c

-- 
1.8.1.3

