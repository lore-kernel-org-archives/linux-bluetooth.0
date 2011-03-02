Return-Path: <cyrus@holtmann.org>
From: Arun Kumar SINGH <arunkr.singh@stericsson.com>
To: Marco Sinigaglia <marco.sinigaglia@csr.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Wed, 2 Mar 2011 18:50:05 +0100
Subject: RE: [PATCH] Adjust timeout LE
Message-ID: <AFCDDB4A3EA003429EEF1E7B211FDBBA334C1F57ED@EXDCVYMBSTM005.EQ1STM.local>
References: <4D6E5398.4070300@csr.com>
In-Reply-To: <4D6E5398.4070300@csr.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marco,



>The hci_send_req 100ms
>timeout is not enough when
>the chip is in deep
>sleep.
>This patch increases it to
>1000ms.
>
>From: Marco Sinigaglia,
>marco.sinigaglia@csr.com
>---
>lib/hci.c         |    6
>+++---
>tools/hciconfig.c |    2 +-
>2 files changed, 4
>insertions(+), 4 deletions(-
>)
>
>diff --git a/lib/hci.c
>b/lib/hci.c
>index 02fc0cf..96fafe1
>100644
>--- a/lib/hci.c
>+++ b/lib/hci.c
>@@ -2753,7 +2753,7 @@ int
>hci_le_set_scan_enable(int
>dd, uint8_t enable,
>uint8_t filter_dup)
>         rq.rparam =
>&status;
>         rq.rlen = 1;
>
>-       if (hci_send_req(dd,
>&rq, 100) < 0)
>+       if (hci_send_req(dd,
>&rq, 1000) < 0)
>                 return -1;
>
>         if (status) {
>@@ -2787,7 +2787,7 @@ int
>hci_le_set_scan_parameters(i
>nt dd, uint8_t type,
>         rq.rparam =
>&status;
>         rq.rlen = 1;
>
>-       if (hci_send_req(dd,
>&rq, 100) < 0)
>+       if (hci_send_req(dd,
>&rq, 1000) < 0)
>                 return -1;
>
>         if (status) {
>@@ -2815,7 +2815,7 @@ int
>hci_le_set_advertise_enable(
>int dd, uint8_t
>enable)
>         rq.rparam =
>&status;
>         rq.rlen = 1;
>
>-       if (hci_send_req(dd,
>&rq, 100) < 0)
>+       if (hci_send_req(dd,
>&rq, 1000) < 0)
>                 return -1;
>
>         if (status) {
>diff --git
>a/tools/hciconfig.c
>b/tools/hciconfig.c
>index 05a8910..aa6d009
>100644
>--- a/tools/hciconfig.c
>+++ b/tools/hciconfig.c
>@@ -268,7 +268,7 @@ static
>void cmd_le_adv(int ctl, int
>hdev, char *opt)
>         rq.rparam =
>&status;
>         rq.rlen = 1;
>
>-       ret =
>hci_send_req(dd, &rq, 100);
>+       ret =
>hci_send_req(dd, &rq, 1000);
>
>         hci_close_dev(dd);

Shouldn't the to parameter be passed to hci_le_set_scan_enable(...) rather than hard-coding it and passing it to hci_send_req(as 1000)? 
I see that as the logical way for all hci_* functions in hci.c that eventually call hci_send_req(). hci_le_set_scan_parameters and few others yet don't have to as input argument and should be patched suitably ...
 

Thanks,
Arun
