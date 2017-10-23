Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: "Kanakkassery, JaganathX" <jaganathx.kanakkassery@intel.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH 1/3] Bluetooth: Introduce helpers for LE set scan start
 and complete
Date: Mon, 23 Oct 2017 06:03:44 +0000
Message-ID: <65A6897373DD1D478DA815A9759D0E0A66575A48@BGSMSX108.gar.corp.intel.com>
References: <1507802154-3960-1-git-send-email-jaganathx.kanakkassery@intel.com>
In-Reply-To: <1507802154-3960-1-git-send-email-jaganathx.kanakkassery@intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi.

>Introduce a helper hci_req_start_scan() which starts an LE scan and call it from passive_Scan() and active_scan().
>There is not functionality change in this patch.
>
>This is basically done to enable extended scanning if the controller supports which will be done in the subsequent patch
>
>Signed-off-by: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>

Any update on this patch set Plz?

Thanks,
Jaganath
