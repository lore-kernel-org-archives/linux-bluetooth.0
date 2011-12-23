Return-Path: <cyrus@holtmann.org>
From: Hemant Gupta <hemant.gupta@stericsson.com>
To: <linux-bluetooth@vger.kernel.org>
Cc: Naresh Gupta <naresh.gupta@stericsson.com>,
	Hemant Gupta <hemantgupta.ste@gmail.com>,
	Hemant Gupta <hemant.gupta@stericsson.com>
Subject: [PATCH-v1 0/1] Bluetooth: Incorrect address while storing LTK 
Date: Fri, 23 Dec 2011 11:07:23 +0530
Message-ID: <1324618644-17551-1-git-send-email-hemant.gupta@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is bug in SMP (Security Manager Protocol) where the Address of
Local Adapter is used while storing the Long Term Key. This resulted
in a new create device call to remote device with Local Device Address.
Patch is same as before just rebased over latest Kernel, including SMP
patches from Brian Gix.

Hemant Gupta (1):
  Bluetooth: Incorrect address while storing LTK.

 net/bluetooth/smp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

