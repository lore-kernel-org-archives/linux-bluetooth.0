Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A93EC433DB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Feb 2021 04:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 416B664E45
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Feb 2021 04:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbhBJELj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 9 Feb 2021 23:11:39 -0500
Received: from mga11.intel.com ([192.55.52.93]:31115 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229809AbhBJELj (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 9 Feb 2021 23:11:39 -0500
IronPort-SDR: GVgRtUDZy/Txt4CLiNLxicw9PuFgZMqITt4GwMlRtM/joe3CAhO7R37X8s5RanywPzTi8hmfk1
 mypoSyE8RrOg==
X-IronPort-AV: E=McAfee;i="6000,8403,9890"; a="178499641"
X-IronPort-AV: E=Sophos;i="5.81,167,1610438400"; 
   d="txt'?scan'208";a="178499641"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2021 20:09:47 -0800
IronPort-SDR: /vZvtKygLzNm35j+tPh6KL7AXLcQA1jbm9lYQ/nIjJTHl7TwfxKC7nSX7lp7wnqvWCS7dXsoqo
 BuuQCTUjK+AQ==
X-IronPort-AV: E=Sophos;i="5.81,167,1610438400"; 
   d="txt'?scan'208";a="375213920"
Received: from acquinto-mobl.amr.corp.intel.com ([10.251.24.24])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2021 20:09:46 -0800
Message-ID: <6fe38cde579c2375e3284b3c42297839211ee49b.camel@linux.intel.com>
Subject: Re: [PATCH v3 1/6] Bluetooth: btintel: Check firmware version
 before download
From:   Tedd Ho-Jeong An <tedd.an@linux.intel.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Date:   Tue, 09 Feb 2021 20:09:39 -0800
In-Reply-To: <2f3bf6dde215f4094404b377d8ad51b8b767cf3d.camel@gmail.com>
References: <20210209233404.2121960-1-luiz.dentz@gmail.com>
         <f689e973a5ac33516c57ebf647e78bcc1476670c.camel@gmail.com>
         <2f3bf6dde215f4094404b377d8ad51b8b767cf3d.camel@gmail.com>
Organization: Intel Corporation
Content-Type: multipart/mixed; boundary="=-DFM2Bguiah1w40wuLQav"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--=-DFM2Bguiah1w40wuLQav
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hi Luiz,

On Tue, 2021-02-09 at 17:26 -0800, Tedd Ho-Jeong An wrote:
> Hi, Luiz,
> 
> On Tue, 2021-02-09 at 17:04 -0800, Tedd Ho-Jeong An wrote:
> > Hi Luiz,
> > 
> > On Tue, 2021-02-09 at 15:33 -0800, Luiz Augusto von Dentz wrote:
> > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > 
> > > This checks the firmware build number, week and year matches with
> > > repective version loaded and then skip the download process.
> > > 
> > > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > ---
> > > v2: Add patch that mover checks for operational mode after the version
> > > checking.
> > > v3: Fix not checking for operation mode before using btintel_read_boot_params
> > > since some models depend on that to contruct the fw filename. Also attempt to
> > > cleanup duplicated code.
> > > 
> > >  drivers/bluetooth/btintel.c   | 94 +++++++++++++++++++++++++++--------
> > >  drivers/bluetooth/btintel.h   |  5 +-
> > >  drivers/bluetooth/btusb.c     | 16 +++++-
> > >  drivers/bluetooth/hci_intel.c |  7 ++-
> > >  4 files changed, 96 insertions(+), 26 deletions(-)

I just completed the following test with this patches and here are the results.
Dmesg outputs are attached.

1. Cold boot
	FW loaded as expected.
2. New FW + cold boot
	New FW loaded as expected.
3. Reboot
	Same FW loaded again after restting the device to bootloader.
4. New FW + Reboot
	New FW loaded after resetting the device to bootloader.
5. Suspend
	No BT driver activity since no enumeration

Please check #3 case which loading the firmware again even if the same
version of firmeare is already running.

This is the dmesg output.
[    4.021072] Bluetooth: Core ver 2.22
[    4.021089] Bluetooth: HCI device and connection manager initialized
[    4.021092] Bluetooth: HCI socket layer initialized
[    4.021093] Bluetooth: L2CAP socket layer initialized
[    4.021097] Bluetooth: SCO socket layer initialized
[    4.625690] Bluetooth: hci0: Firmware revision 0.1 build 26 week 11 2020
[    4.631875] Bluetooth: hci0: Found device firmware: intel/ibt-17-16-1.sfi
[    5.955215] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    5.955217] Bluetooth: BNEP filters: protocol multicast
[    5.955220] Bluetooth: BNEP socket layer initialized
[    6.660529] Bluetooth: hci0: command 0xfc01 tx timeout
[   14.654714] Bluetooth: hci0: FW download error recovery failed (-110)
[   15.079684] Bluetooth: hci0: Bootloader revision 0.1 build 42 week 52 2015
[   15.080652] Bluetooth: hci0: Device revision is 2
[   15.080662] Bluetooth: hci0: Secure boot is enabled
[   15.080667] Bluetooth: hci0: OTP lock is enabled
[   15.080673] Bluetooth: hci0: API lock is enabled
[   15.080678] Bluetooth: hci0: Debug lock is disabled
[   15.080687] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
[   15.081832] Bluetooth: hci0: Found device firmware: intel/ibt-17-16-1.sfi
[   16.965194] Bluetooth: hci0: Waiting for firmware download to complete
[   16.965560] Bluetooth: hci0: Firmware loaded in 1839570 usecs
[   16.965637] Bluetooth: hci0: Waiting for device to boot
[   16.978543] Bluetooth: hci0: Device booted in 12630 usecs
[   16.978895] Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-17-16-1.ddc
[   16.981587] Bluetooth: hci0: Applying Intel DDC parameters completed
[   16.984616] Bluetooth: hci0: Firmware revision 0.1 build 26 week 11 2020
[   17.045576] Bluetooth: hci0: MSFT filter_enable is already on
[   70.621004] Bluetooth: RFCOMM TTY layer initialized
[   70.621010] Bluetooth: RFCOMM socket layer initialized
[   70.621014] Bluetooth: RFCOMM ver 1.11

While testing the scenarios, I found a bug (not from your patch series)
which prevents the driver from loading DDC. I will submit patch separately.

> > 
> > Regards,
> > Tedd
> > 

Regards,
Tedd

--=-DFM2Bguiah1w40wuLQav
Content-Disposition: attachment; filename="fw_check_test.txt"
Content-Type: text/plain; name="fw_check_test.txt"; charset="UTF-8"
Content-Transfer-Encoding: base64

Y29sZCByZWJvb3Q6ClsgICAgNC4yMDM2MDhdIEJsdWV0b290aDogaGNpMDogQm9vdGxvYWRlciBy
ZXZpc2lvbiAwLjEgYnVpbGQgNDIgd2VlayA1MiAyMDE1ClsgICAgNC4yMzUxMjddIEJsdWV0b290
aDogaGNpMDogRm91bmQgZGV2aWNlIGZpcm13YXJlOiBpbnRlbC9pYnQtMTctMTYtMS5zZmkKWyAg
ICA1LjkwOTYyNV0gQmx1ZXRvb3RoOiBoY2kwOiBXYWl0aW5nIGZvciBmaXJtd2FyZSBkb3dubG9h
ZCB0byBjb21wbGV0ZQpbICAgIDUuOTEwNTE4XSBCbHVldG9vdGg6IGhjaTA6IEZpcm13YXJlIGxv
YWRlZCBpbiAxNjM2MTIwIHVzZWNzClsgICAgNS45MTA1NDddIEJsdWV0b290aDogaGNpMDogV2Fp
dGluZyBmb3IgZGV2aWNlIHRvIGJvb3QKWyAgICA1LjkyNDUxOV0gQmx1ZXRvb3RoOiBoY2kwOiBE
ZXZpY2UgYm9vdGVkIGluIDEzNjUxIHVzZWNzClsgICAgNS45MjY3OTJdIEJsdWV0b290aDogaGNp
MDogRm91bmQgSW50ZWwgRERDIHBhcmFtZXRlcnM6IGludGVsL2lidC0xNy0xNi0xLmRkYwpbICAg
IDUuOTI4NTIzXSBCbHVldG9vdGg6IGhjaTA6IEFwcGx5aW5nIEludGVsIEREQyBwYXJhbWV0ZXJz
IGNvbXBsZXRlZApbICAgIDUuOTMxNTIzXSBCbHVldG9vdGg6IGhjaTA6IEZpcm13YXJlIHJldmlz
aW9uIDAuMSBidWlsZCAxNjggd2VlayA0OCAyMDIwCgpOZXcgRlcgKyBjb2xkIHJlYm9vdDoKWyAg
ICA0LjAwMzY4N10gQmx1ZXRvb3RoOiBDb3JlIHZlciAyLjIyClsgICAgNC4wMDM3MTBdIEJsdWV0
b290aDogSENJIGRldmljZSBhbmQgY29ubmVjdGlvbiBtYW5hZ2VyIGluaXRpYWxpemVkClsgICAg
NC4wMDM3MTNdIEJsdWV0b290aDogSENJIHNvY2tldCBsYXllciBpbml0aWFsaXplZApbICAgIDQu
MDAzNzE1XSBCbHVldG9vdGg6IEwyQ0FQIHNvY2tldCBsYXllciBpbml0aWFsaXplZApbICAgIDQu
MDAzNzE4XSBCbHVldG9vdGg6IFNDTyBzb2NrZXQgbGF5ZXIgaW5pdGlhbGl6ZWQKWyAgICA0LjIz
ODM5OV0gQmx1ZXRvb3RoOiBoY2kwOiBCb290bG9hZGVyIHJldmlzaW9uIDAuMSBidWlsZCA0MiB3
ZWVrIDUyIDIwMTUKWyAgICA0LjIzOTM5NV0gQmx1ZXRvb3RoOiBoY2kwOiBEZXZpY2UgcmV2aXNp
b24gaXMgMgpbICAgIDQuMjM5Mzk2XSBCbHVldG9vdGg6IGhjaTA6IFNlY3VyZSBib290IGlzIGVu
YWJsZWQKWyAgICA0LjIzOTM5Nl0gQmx1ZXRvb3RoOiBoY2kwOiBPVFAgbG9jayBpcyBlbmFibGVk
ClsgICAgNC4yMzkzOTddIEJsdWV0b290aDogaGNpMDogQVBJIGxvY2sgaXMgZW5hYmxlZApbICAg
IDQuMjM5Mzk4XSBCbHVldG9vdGg6IGhjaTA6IERlYnVnIGxvY2sgaXMgZGlzYWJsZWQKWyAgICA0
LjIzOTM5OV0gQmx1ZXRvb3RoOiBoY2kwOiBNaW5pbXVtIGZpcm13YXJlIGJ1aWxkIDEgd2VlayAx
MCAyMDE0ClsgICAgNC4zMTE3MzhdIEJsdWV0b290aDogaGNpMDogRm91bmQgZGV2aWNlIGZpcm13
YXJlOiBpbnRlbC9pYnQtMTctMTYtMS5zZmkKWyAgICA1LjYyOTEzNV0gQmx1ZXRvb3RoOiBCTkVQ
IChFdGhlcm5ldCBFbXVsYXRpb24pIHZlciAxLjMKWyAgICA1LjYyOTEzN10gQmx1ZXRvb3RoOiBC
TkVQIGZpbHRlcnM6IHByb3RvY29sIG11bHRpY2FzdApbICAgIDUuNjI5MTM5XSBCbHVldG9vdGg6
IEJORVAgc29ja2V0IGxheWVyIGluaXRpYWxpemVkClsgICAgNS43MDMwMjBdIEJsdWV0b290aDog
aGNpMDogV2FpdGluZyBmb3IgZmlybXdhcmUgZG93bmxvYWQgdG8gY29tcGxldGUKWyAgICA1Ljcw
MzM4NF0gQmx1ZXRvb3RoOiBoY2kwOiBGaXJtd2FyZSBsb2FkZWQgaW4gMTM1OTAyNiB1c2Vjcwpb
ICAgIDUuNzAzNDExXSBCbHVldG9vdGg6IGhjaTA6IFdhaXRpbmcgZm9yIGRldmljZSB0byBib290
ClsgICAgNS43MTY0MTJdIEJsdWV0b290aDogaGNpMDogRGV2aWNlIGJvb3RlZCBpbiAxMjcwNyB1
c2VjcwpbICAgIDUuNzE2NzE0XSBCbHVldG9vdGg6IGhjaTA6IEZvdW5kIEludGVsIEREQyBwYXJh
bWV0ZXJzOiBpbnRlbC9pYnQtMTctMTYtMS5kZGMKWyAgICA1LjcxOTM4M10gQmx1ZXRvb3RoOiBo
Y2kwOiBBcHBseWluZyBJbnRlbCBEREMgcGFyYW1ldGVycyBjb21wbGV0ZWQKWyAgICA1LjcyMjM4
OV0gQmx1ZXRvb3RoOiBoY2kwOiBGaXJtd2FyZSByZXZpc2lvbiAwLjEgYnVpbGQgMjYgd2VlayAx
MSAyMDIwClsgICAgNS43ODA0MDZdIEJsdWV0b290aDogaGNpMDogTVNGVCBmaWx0ZXJfZW5hYmxl
IGlzIGFscmVhZHkgb24KWyAgIDE0LjgyMjMzNl0gQmx1ZXRvb3RoOiBSRkNPTU0gVFRZIGxheWVy
IGluaXRpYWxpemVkClsgICAxNC44MjIzNDJdIEJsdWV0b290aDogUkZDT01NIHNvY2tldCBsYXll
ciBpbml0aWFsaXplZApbICAgMTQuODIyMzQ1XSBCbHVldG9vdGg6IFJGQ09NTSB2ZXIgMS4xMQoK
ClJlYm9vdApbICAgIDQuMDIxMDcyXSBCbHVldG9vdGg6IENvcmUgdmVyIDIuMjIKWyAgICA0LjAy
MTA4OV0gQmx1ZXRvb3RoOiBIQ0kgZGV2aWNlIGFuZCBjb25uZWN0aW9uIG1hbmFnZXIgaW5pdGlh
bGl6ZWQKWyAgICA0LjAyMTA5Ml0gQmx1ZXRvb3RoOiBIQ0kgc29ja2V0IGxheWVyIGluaXRpYWxp
emVkClsgICAgNC4wMjEwOTNdIEJsdWV0b290aDogTDJDQVAgc29ja2V0IGxheWVyIGluaXRpYWxp
emVkClsgICAgNC4wMjEwOTddIEJsdWV0b290aDogU0NPIHNvY2tldCBsYXllciBpbml0aWFsaXpl
ZApbICAgIDQuNjI1NjkwXSBCbHVldG9vdGg6IGhjaTA6IEZpcm13YXJlIHJldmlzaW9uIDAuMSBi
dWlsZCAyNiB3ZWVrIDExIDIwMjAKWyAgICA0LjYzMTg3NV0gQmx1ZXRvb3RoOiBoY2kwOiBGb3Vu
ZCBkZXZpY2UgZmlybXdhcmU6IGludGVsL2lidC0xNy0xNi0xLnNmaQpbICAgIDUuOTU1MjE1XSBC
bHVldG9vdGg6IEJORVAgKEV0aGVybmV0IEVtdWxhdGlvbikgdmVyIDEuMwpbICAgIDUuOTU1MjE3
XSBCbHVldG9vdGg6IEJORVAgZmlsdGVyczogcHJvdG9jb2wgbXVsdGljYXN0ClsgICAgNS45NTUy
MjBdIEJsdWV0b290aDogQk5FUCBzb2NrZXQgbGF5ZXIgaW5pdGlhbGl6ZWQKWyAgICA2LjY2MDUy
OV0gQmx1ZXRvb3RoOiBoY2kwOiBjb21tYW5kIDB4ZmMwMSB0eCB0aW1lb3V0ClsgICAxNC42NTQ3
MTRdIEJsdWV0b290aDogaGNpMDogRlcgZG93bmxvYWQgZXJyb3IgcmVjb3ZlcnkgZmFpbGVkICgt
MTEwKQpbICAgMTUuMDc5Njg0XSBCbHVldG9vdGg6IGhjaTA6IEJvb3Rsb2FkZXIgcmV2aXNpb24g
MC4xIGJ1aWxkIDQyIHdlZWsgNTIgMjAxNQpbICAgMTUuMDgwNjUyXSBCbHVldG9vdGg6IGhjaTA6
IERldmljZSByZXZpc2lvbiBpcyAyClsgICAxNS4wODA2NjJdIEJsdWV0b290aDogaGNpMDogU2Vj
dXJlIGJvb3QgaXMgZW5hYmxlZApbICAgMTUuMDgwNjY3XSBCbHVldG9vdGg6IGhjaTA6IE9UUCBs
b2NrIGlzIGVuYWJsZWQKWyAgIDE1LjA4MDY3M10gQmx1ZXRvb3RoOiBoY2kwOiBBUEkgbG9jayBp
cyBlbmFibGVkClsgICAxNS4wODA2NzhdIEJsdWV0b290aDogaGNpMDogRGVidWcgbG9jayBpcyBk
aXNhYmxlZApbICAgMTUuMDgwNjg3XSBCbHVldG9vdGg6IGhjaTA6IE1pbmltdW0gZmlybXdhcmUg
YnVpbGQgMSB3ZWVrIDEwIDIwMTQKWyAgIDE1LjA4MTgzMl0gQmx1ZXRvb3RoOiBoY2kwOiBGb3Vu
ZCBkZXZpY2UgZmlybXdhcmU6IGludGVsL2lidC0xNy0xNi0xLnNmaQpbICAgMTYuOTY1MTk0XSBC
bHVldG9vdGg6IGhjaTA6IFdhaXRpbmcgZm9yIGZpcm13YXJlIGRvd25sb2FkIHRvIGNvbXBsZXRl
ClsgICAxNi45NjU1NjBdIEJsdWV0b290aDogaGNpMDogRmlybXdhcmUgbG9hZGVkIGluIDE4Mzk1
NzAgdXNlY3MKWyAgIDE2Ljk2NTYzN10gQmx1ZXRvb3RoOiBoY2kwOiBXYWl0aW5nIGZvciBkZXZp
Y2UgdG8gYm9vdApbICAgMTYuOTc4NTQzXSBCbHVldG9vdGg6IGhjaTA6IERldmljZSBib290ZWQg
aW4gMTI2MzAgdXNlY3MKWyAgIDE2Ljk3ODg5NV0gQmx1ZXRvb3RoOiBoY2kwOiBGb3VuZCBJbnRl
bCBEREMgcGFyYW1ldGVyczogaW50ZWwvaWJ0LTE3LTE2LTEuZGRjClsgICAxNi45ODE1ODddIEJs
dWV0b290aDogaGNpMDogQXBwbHlpbmcgSW50ZWwgRERDIHBhcmFtZXRlcnMgY29tcGxldGVkClsg
ICAxNi45ODQ2MTZdIEJsdWV0b290aDogaGNpMDogRmlybXdhcmUgcmV2aXNpb24gMC4xIGJ1aWxk
IDI2IHdlZWsgMTEgMjAyMApbICAgMTcuMDQ1NTc2XSBCbHVldG9vdGg6IGhjaTA6IE1TRlQgZmls
dGVyX2VuYWJsZSBpcyBhbHJlYWR5IG9uClsgICA3MC42MjEwMDRdIEJsdWV0b290aDogUkZDT01N
IFRUWSBsYXllciBpbml0aWFsaXplZApbICAgNzAuNjIxMDEwXSBCbHVldG9vdGg6IFJGQ09NTSBz
b2NrZXQgbGF5ZXIgaW5pdGlhbGl6ZWQKWyAgIDcwLjYyMTAxNF0gQmx1ZXRvb3RoOiBSRkNPTU0g
dmVyIDEuMTEKCk5ldyBGVyArIFJlYm9vdApbICAgIDMuODE0ODkzXSBCbHVldG9vdGg6IENvcmUg
dmVyIDIuMjIKWyAgICAzLjgxNDkwNl0gQmx1ZXRvb3RoOiBIQ0kgZGV2aWNlIGFuZCBjb25uZWN0
aW9uIG1hbmFnZXIgaW5pdGlhbGl6ZWQKWyAgICAzLjgxNDkwOF0gQmx1ZXRvb3RoOiBIQ0kgc29j
a2V0IGxheWVyIGluaXRpYWxpemVkClsgICAgMy44MTQ5MTBdIEJsdWV0b290aDogTDJDQVAgc29j
a2V0IGxheWVyIGluaXRpYWxpemVkClsgICAgMy44MTQ5MTFdIEJsdWV0b290aDogU0NPIHNvY2tl
dCBsYXllciBpbml0aWFsaXplZApbICAgIDMuOTk5NjAwXSBCbHVldG9vdGg6IGhjaTA6IEZpcm13
YXJlIHJldmlzaW9uIDAuMSBidWlsZCAyNiB3ZWVrIDExIDIwMjAKWyAgICA0LjAwMzc1MF0gQmx1
ZXRvb3RoOiBoY2kwOiBGb3VuZCBkZXZpY2UgZmlybXdhcmU6IGludGVsL2lidC0xNy0xNi0xLnNm
aQpbICAgIDYuMDE0MzcxXSBCbHVldG9vdGg6IGhjaTA6IGNvbW1hbmQgMHhmYzAxIHR4IHRpbWVv
dXQKWyAgICA3LjI2ODY2Ml0gQmx1ZXRvb3RoOiBCTkVQIChFdGhlcm5ldCBFbXVsYXRpb24pIHZl
ciAxLjMKWyAgICA3LjI2ODY2NF0gQmx1ZXRvb3RoOiBCTkVQIGZpbHRlcnM6IHByb3RvY29sIG11
bHRpY2FzdApbICAgIDcuMjY4NjY3XSBCbHVldG9vdGg6IEJORVAgc29ja2V0IGxheWVyIGluaXRp
YWxpemVkClsgICAxNC4xNDI2NDRdIEJsdWV0b290aDogaGNpMDogRlcgZG93bmxvYWQgZXJyb3Ig
cmVjb3ZlcnkgZmFpbGVkICgtMTEwKQpbICAgMTQuNTY5Njk4XSBCbHVldG9vdGg6IGhjaTA6IEJv
b3Rsb2FkZXIgcmV2aXNpb24gMC4xIGJ1aWxkIDQyIHdlZWsgNTIgMjAxNQpbICAgMTQuNTcwNjM2
XSBCbHVldG9vdGg6IGhjaTA6IERldmljZSByZXZpc2lvbiBpcyAyClsgICAxNC41NzA2NDVdIEJs
dWV0b290aDogaGNpMDogU2VjdXJlIGJvb3QgaXMgZW5hYmxlZApbICAgMTQuNTcwNjUwXSBCbHVl
dG9vdGg6IGhjaTA6IE9UUCBsb2NrIGlzIGVuYWJsZWQKWyAgIDE0LjU3MDY1Nl0gQmx1ZXRvb3Ro
OiBoY2kwOiBBUEkgbG9jayBpcyBlbmFibGVkClsgICAxNC41NzA2NjFdIEJsdWV0b290aDogaGNp
MDogRGVidWcgbG9jayBpcyBkaXNhYmxlZApbICAgMTQuNTcwNjY5XSBCbHVldG9vdGg6IGhjaTA6
IE1pbmltdW0gZmlybXdhcmUgYnVpbGQgMSB3ZWVrIDEwIDIwMTQKWyAgIDE0LjU3MTczM10gQmx1
ZXRvb3RoOiBoY2kwOiBGb3VuZCBkZXZpY2UgZmlybXdhcmU6IGludGVsL2lidC0xNy0xNi0xLnNm
aQpbICAgMTYuMDE3NTY3XSBCbHVldG9vdGg6IGhjaTA6IFdhaXRpbmcgZm9yIGZpcm13YXJlIGRv
d25sb2FkIHRvIGNvbXBsZXRlClsgICAxNi4wMTg1MjldIEJsdWV0b290aDogaGNpMDogRmlybXdh
cmUgbG9hZGVkIGluIDE0MTI4ODEgdXNlY3MKWyAgIDE2LjAxODY2Nl0gQmx1ZXRvb3RoOiBoY2kw
OiBXYWl0aW5nIGZvciBkZXZpY2UgdG8gYm9vdApbICAgMTYuMDMyNjI0XSBCbHVldG9vdGg6IGhj
aTA6IERldmljZSBib290ZWQgaW4gMTM3MDIgdXNlY3MKWyAgIDE2LjAzNTIwM10gQmx1ZXRvb3Ro
OiBoY2kwOiBGb3VuZCBJbnRlbCBEREMgcGFyYW1ldGVyczogaW50ZWwvaWJ0LTE3LTE2LTEuZGRj
ClsgICAxNi4wMzY3NTVdIEJsdWV0b290aDogaGNpMDogQXBwbHlpbmcgSW50ZWwgRERDIHBhcmFt
ZXRlcnMgY29tcGxldGVkClsgICAxNi4wMzk4MjJdIEJsdWV0b290aDogaGNpMDogRmlybXdhcmUg
cmV2aXNpb24gMC4xIGJ1aWxkIDE2OCB3ZWVrIDQ4IDIwMjAKWyAgIDE2LjA5OTY5MF0gQmx1ZXRv
b3RoOiBoY2kwOiBNU0ZUIGZpbHRlcl9lbmFibGUgaXMgYWxyZWFkeSBvbgpbICAgMTguNjYwODEx
XSBCbHVldG9vdGg6IFJGQ09NTSBUVFkgbGF5ZXIgaW5pdGlhbGl6ZWQKWyAgIDE4LjY2MDgxNV0g
Qmx1ZXRvb3RoOiBSRkNPTU0gc29ja2V0IGxheWVyIGluaXRpYWxpemVkClsgICAxOC42NjA4MTld
IEJsdWV0b290aDogUkZDT01NIHZlciAxLjExCgpTdXNwZW5kCk5vIENoYW5nZSBzaW5jZSBubyBl
bnVtZXJhdGlvbgoK


--=-DFM2Bguiah1w40wuLQav--

