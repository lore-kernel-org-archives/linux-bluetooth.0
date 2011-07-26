Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<ulrik.lauren@stericsson.com>, Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC 0/3] Fix debug messages logging from non-built-in plugins
Date: Tue, 26 Jul 2011 15:57:09 +0200
Message-ID: <1311688632-19334-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,

As requested by Marcel I'm sending this as RFC and with some more comments
from my side how this was done. Also patch is splitted to make review easier.

Currently we are not able to see any debug messages from external plugins.
This regression was introduced with dynamic debug support and mostly (probably)
hits android platform which does build some plugins as external .so files.

This is due to debug message enabling flags are stored in debug section. Main
binary and external plugins have separated debug sections and current debug
enabling code make use only of main binary debug section, and flags in
external plugins are always not set.

The idea to fix that is to make it possible for external plugin to 'register'
its debug section so logging code can make use of it. This is to be done via
__btd_log_add() function after external plugin is loaded (but before it is
initialized). Logging code keep list and make use of them to enable
debugging. When external plugin is unloaded its debug section is 
deregistered with __btd_log_remove().

Access to external plugin debug section is done via btd_debug_section added
to bluetooth_plugin_desc structure. External plugins store pointers
__start___debug and __stop___debug there. For builin plugins these field are
not used and NULLed.

This does not affect plugins loading order as built-in plugins get their
debug intialized in main() function via __btd_log_init() and external plugins
gets their debug section initialized in __btd_log_add() called
from plugin_init(). __btd_toggle_debug() iterates over all built-in and
registered external debug sections to enable all debugs.

two more things:
 * should SIGUSR2 be blocked when __btd_log_add/remove are executed?
 * log code can be more generic if built-in debug section was also
   registered via __btd_log_add() from main.c and not kept in log.c

What do you think about that?
Comments are welcome.


Szymon Janc (3):
  Include log.h before plugin.h
  Enhance dynamic debug with support for external debug sections
  Enhance plugin interface with external debug section

 audio/main.c           |    2 +-
 health/hdp_main.c      |    1 +
 input/main.c           |    2 +-
 network/main.c         |    1 +
 plugins/adaptername.c  |    2 +-
 plugins/formfactor.c   |    2 +-
 plugins/gatt-example.c |    2 +-
 plugins/hciops.c       |    2 +-
 plugins/mgmtops.c      |    2 +-
 plugins/service.c      |    2 +-
 plugins/storage.c      |    2 +-
 sap/main.c             |    1 +
 serial/main.c          |    1 +
 src/log.c              |   25 +++++++++++++++++++++++++
 src/log.h              |    8 ++++++++
 src/plugin.c           |   10 +++++++---
 src/plugin.h           |    8 ++++++--
 17 files changed, 59 insertions(+), 14 deletions(-)

-- 
on behalf of ST-Ericsson

