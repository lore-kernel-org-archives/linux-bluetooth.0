Return-Path: <cyrus@holtmann.org>
Date: Thu, 4 Apr 2013 12:46:08 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Bluetooth: Add HCI init setup stage
Message-ID: <20130404094608.GA4710@x220>
References: <1364923287-25935-1-git-send-email-johan.hedberg@gmail.com>
 <20130404082436.GA2340@x220>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3V7upXqbjpZ4EhLz"
In-Reply-To: <20130404082436.GA2340@x220>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Marcel,

On Thu, Apr 04, 2013, Johan Hedberg wrote:
> On Tue, Apr 02, 2013, Johan Hedberg wrote:
> > This is a resend of Marcel's patches that were sent in November, rebased
> > and fixed-up for bluetooth-next. They are a pre-requsite of some
> > follow-up work I'm doing to have a simple way of doing synchronous
> > single-command requests that will be needed by some HCI driver setup
> > routines.
> > 
> > Johan
> > 
> > ----------------------------------------------------------------
> > Marcel Holtmann (3):
> >       Bluetooth: Add driver setup stage for early init
> >       Bluetooth: Convert BCM92035 support to driver setup callback
> >       Bluetooth: Remove driver init queue from core
> > 
> >  drivers/bluetooth/btusb.c        |   28 +++++++++++--------
> >  include/net/bluetooth/hci_core.h |    3 +-
> >  net/bluetooth/hci_core.c         |   56 ++++++++++++++------------------------
> >  3 files changed, 38 insertions(+), 49 deletions(-)
> 
> There patches have now been pushed to the bluetooth-next tree.

I had to temporarily remove these since they cause build breakage when
building as modules:

>> ERROR: "hci_send_cmd" [drivers/bluetooth/btusb.ko] undefined!

It seems the reason is a missing EXPORT_SYMBOL declaration for
hci_send_cmd which the attached patch should fix. I'll also send a
revised patch set of my own function additions since those too will need
this declaration.

Johan

--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-Bluetooth-Export-hci_send_cmd-outside-of-the-HCI-cor.patch"

>From 74b40041d3caeae96d9cbdd2f0ac8a478b79c7c1 Mon Sep 17 00:00:00 2001
From: Johan Hedberg <johan.hedberg@intel.com>
Date: Thu, 4 Apr 2013 12:39:53 +0300
Subject: [PATCH] Bluetooth: Export hci_send_cmd outside of the HCI core

This function will be needed by HCI drivers when we enable the driver
setup sequence to use the HCI core functionality. Hence, export the
symbol using EXPORT_SYMBOL.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_core.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index a199d63..6dfb2f3 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2538,6 +2538,7 @@ int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen, void *param)
 
 	return 0;
 }
+EXPORT_SYMBOL(hci_send_cmd);
 
 /* Queue a command to an asynchronous HCI request */
 void hci_req_add(struct hci_request *req, u16 opcode, u32 plen, void *param)
-- 
1.7.10.4


--3V7upXqbjpZ4EhLz--
