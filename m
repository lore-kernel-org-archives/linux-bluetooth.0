Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH v2 BlueZ 00/13] Fix SDP DE Type Descriptor validation issues
Date: Fri, 15 Feb 2013 10:56:14 -0400
Message-Id: <1360940187-5202-1-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1360531597-3506-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1360531597-3506-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Changes since v1:
* Fix license header to match BlueZ license (GPL v2 or later)
* Rename test source file and SDP tests to account for future addition of other
  libbluetooth tests

This series adds various missing DTD validations, specially for SEQ* types. The
lack of these validations allows for a remote device to crash BlueZ due to
invalid memory access.

I also added unit tests for all affected functions. They are in a separate C
file (unit/test-lib.c), which will in future contain tests for other
libbluetooth API functions.

The only pending related fixes from my part are some missing NULL pointer
checks when accessing empty sequences. These will take some time to fix as they
affect profile code as well.

Best Regards,

Anderson Lizardo (13):
  unit: Add initial SDP library unit tests
  lib: Add SDP_IS_ALT() macro
  lib: Reuse identical code in sdp_get_{add,}_access_protos()
  lib: Cleanup coding style in sdp_get_proto_descs()
  lib: Fix missing DTD validation while accessing SDP data elements
  unit: Add tests for sdp_get_lang_attr()
  lib: Add missing DTD validation in sdp_record_print()
  lib: Validate DTDs when parsing LanguageBaseAttributeIDList
  lib: Validate DTDs when parsing BluetoothProfileDescriptorList
  lib: Add comment to BluetoothProfileDescriptorList parsing workaround
  lib: Validate DTDs when parsing VersionNumberList
  unit: Add tests for sdp_get_profile_descs()
  unit: Add tests for sdp_get_server_ver()

 .gitignore      |    1 +
 Makefile.am     |    5 +
 lib/sdp.c       |  164 +++++++++++++------
 lib/sdp.h       |    1 +
 unit/test-lib.c |  471 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 596 insertions(+), 46 deletions(-)
 create mode 100644 unit/test-lib.c

-- 
1.7.9.5

