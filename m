Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [RFC BlueZ 00/22] Using clang for compiling BlueZ
Date: Fri, 10 Feb 2012 18:39:45 -0300
Message-Id: <1328910007-25604-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

After hearing so much about LLVM/Clang[1][2], I decided to give it a
try on a project that I care about and see how would it go. The first
step was cleaning all the warnings that it could find. This is the
result.

One thing that I really liked was that the warnings are useful, making
it very easy to make these changes. In my opinion, Clang is worth
trying for this feature alone.

As a bonus point, we can now use Clang static analyzer on our code
base, if someone wants to take a look at what it looks like, here's an
example[3]. The analyzer still doesn't catch everything that paid
alternatives do but it is improving.

--
[1] http://llvm.org/

[2] http://clang.llvm.org/

[3] http://littlechina.org/~vcgomes/bluez-static-analysis/2012-02-10-1/


Vinicius Costa Gomes (22):
  lib: Add functions to deal with unaligned access without conversion
  lib: Add functions to storing values in unaligned places
  lib: Fix the unaligned memory "getters" not receiving a const pointer
  tools: Fix using old-style initializers
  sap: Fix clang compiler warnings related to unaligned memory access
  lib: Fix using old-style initializers
  sdp: Fix clang compiler warnings related to unaligned memory access
  l2test: Fix clang compiler warning related to unaligned memory access
  rctest: Fix clang compiler warnings related to unaligned memory
    access
  dun: Fix using old-style initializers
  scotest: Fix clang compiler warnings related to unaligned memory
    access
  ipctest: Fix using the format specifier "as"
  audio: Fix clang compiler warnings related to unaligned memory access
  audio: Fix clang compiler warnings regarding implicit enum conversion
  sap: Fix compiler warnings related to unaligned memory access
  network: Fix clang compiler warnings related to unaligned memory
    access
  mgmtops: Fix doing a useless memset()
  adaptername: Fix clang warning related to unaligned memory access
  sdp: Fix clang compiler warnings related to unaligned memory access
  hciconfig: Fix using old-style initializers
  hciconfig: Fix compiler warnings related to unaligned memory access
  hciemu: Fix clang compiler warnings related to unaligned memory
    access

 audio/avrcp.c         |    8 ++--
 audio/sink.c          |    4 +-
 audio/sink.h          |    2 +-
 audio/source.c        |    4 +-
 audio/source.h        |    2 +-
 compat/dun.c          |    4 +-
 lib/bluetooth.h       |  124 ++++++++++++++++++++++++++++++++++++++++++++-----
 lib/hci.c             |    4 +-
 lib/sdp.c             |   66 +++++++++++++-------------
 network/server.c      |    8 ++--
 plugins/adaptername.c |    2 +-
 plugins/mgmtops.c     |    4 --
 sap/sap-u8500.c       |   10 ++--
 sap/server.c          |   10 +---
 src/sdpd-request.c    |   42 ++++++++--------
 src/sdpd-service.c    |   21 ++++----
 test/hciemu.c         |    9 ++-
 test/ipctest.c        |   12 ++--
 test/l2test.c         |    8 ++--
 test/rctest.c         |    4 +-
 test/scotest.c        |    4 +-
 tools/hciconfig.c     |    6 +-
 tools/hcitool.c       |    2 +-
 tools/rfcomm.c        |    2 +-
 24 files changed, 229 insertions(+), 133 deletions(-)

--
1.7.8.1

