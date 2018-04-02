Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Inga Stotland <inga.stotland@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 0/1] Usage of bt_shell with ell
Date: Sun,  1 Apr 2018 19:34:34 -0700
Message-Id: <20180402023435.30430-1-inga.stotland@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For test code that relies on underlying ell-based implementation, I would
like to use the menues and navigation features provided by bt_shell
without starting glib's mainloop.
The attached patch allows to do just that. Perhaps, this is not most elegant
solution, but it seems to be less invasive.

Inga Stotland (1):
  shared/shell: Add commands to allow shell usage with external mainloop

 src/shared/shell.c | 42 ++++++++++++++++++++++++++++++++++++++++--
 src/shared/shell.h |  3 +++
 2 files changed, 43 insertions(+), 2 deletions(-)

-- 
2.14.3

