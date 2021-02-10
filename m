Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9207DC433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Feb 2021 23:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 657E664ED0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Feb 2021 23:03:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232692AbhBJXDO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Feb 2021 18:03:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232478AbhBJXDG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Feb 2021 18:03:06 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A7DC061756
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Feb 2021 15:02:26 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id t25so2260241pga.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Feb 2021 15:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version;
        bh=r3pNeM1dLTD10GiUnyoCmnTvDAdkCFQgGOLDdrGMDp0=;
        b=mFk20vWzr27V5NSZnD+nMLw8wJPCTMr4KXI2IzT7TcDeDTxuDbenb/Id4bMLddbHu+
         VfkYCFSTjHSx4MNASbfOnBimTHfuqAVsfn/cdAuXgyZXCNw2zhDDJNvpl5CVNo48ZExs
         9Qd8y+z9SGUHy926+zgnKFFxMf1dO3szMYbSYmMAPUJ2YoFBedta4Na7vDWKegZjUwni
         F+02ntkEItmg1k2Lp84UzBvTKupPUxy+MVYj0AfOhqM9gGNUM55FmEDqWNVDjoKfDGAD
         NYoK9cdG8GhQXUTUx0Ja1BNMwz1oS9QaGVp9EMlFESkv3UK3eWyCbNCHOLYMqv+aCGI1
         CwSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version;
        bh=r3pNeM1dLTD10GiUnyoCmnTvDAdkCFQgGOLDdrGMDp0=;
        b=nsK6Psjm0BTkv/DEQNlEH8k35KHBFn7DVL/ghi218RJ5vqXm6aWPPyIEVi76LfO7QI
         WWcy7Ij+qPdHUVxOPw6O2mvc16+kfKwdagXvoD0pRzTbALdbwIza+F3hKoQgEjCpWFjz
         6xWf99kNph28Nl714RjUpYp3vDNKgDVKOiei5F9+RU0jZl8s7LcIqPFXRIC6jWLFCIOA
         l+2DJ3Z6l44poOB4kbdFY8Y3rde5J/vToEYNAsWnMmcx5NNkegqhcWRNjFTzDlwkOKRA
         Hs5LnHCGMu9UcSmQPaUBdJY14AXave2Eu+0haTWPOf5le4yHG0G/UxLjPA4g3AuCx8bB
         bJbg==
X-Gm-Message-State: AOAM532B6YnOuy52UlVIoB4XrJO9CKHBh2ujsKJS/brhe8xOAdBgpobU
        TC5x6msGNAtbnUUMNEu4Y0Al5RKjSdZt5g==
X-Google-Smtp-Source: ABdhPJwoU9TMLH+84VxbPuXiUYvVy9c+XgNPicXHSdSFW4i6eyoqyK/dE6/OUY/Fhz4/WWBvklgqvg==
X-Received: by 2002:a05:6a00:168d:b029:1ba:d500:1209 with SMTP id k13-20020a056a00168db02901bad5001209mr5236824pfc.4.1612998145975;
        Wed, 10 Feb 2021 15:02:25 -0800 (PST)
Received: from han1-NUC8i7BEH ([2601:1c0:6a81:13a0:4de5:c442:c0b3:4b7d])
        by smtp.gmail.com with ESMTPSA id e4sm3048283pjt.38.2021.02.10.15.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 15:02:25 -0800 (PST)
Message-ID: <2fb94a9173d962cc05075e37676dd7b3c046eee6.camel@gmail.com>
Subject: Re: [PATCH v6 1/6] Bluetooth: btintel: Check firmware version
 before download
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Date:   Wed, 10 Feb 2021 15:02:24 -0800
In-Reply-To: <20210210201852.2246985-1-luiz.dentz@gmail.com>
References: <20210210201852.2246985-1-luiz.dentz@gmail.com>
Content-Type: multipart/mixed; boundary="=-v8sYEROfXx/sjFuc99KF"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--=-v8sYEROfXx/sjFuc99KF
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hi Luiz,

On Wed, 2021-02-10 at 12:18 -0800, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This checks the firmware build number, week and year matches with
> repective version loaded and then skip the download process.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> v2: Add patch that mover checks for operational mode after the version
> checking.
> v3: Fix not checking for operation mode before using btintel_read_boot_params
> since some models depend on that to contruct the fw filename. Also attempt to
> cleanup duplicated code.
> v4: Fix forwarding -EALREADY when firmware has already been loaded.
> v5: Fix not advancing fw_ptr.
> v6: Fix btusb_setup_intel_new_get_fw_name error checking for ddc.
> 
>  drivers/bluetooth/btintel.c   | 94 +++++++++++++++++++++++++++--------
>  drivers/bluetooth/btintel.h   |  5 +-
>  drivers/bluetooth/btusb.c     | 18 ++++++-
>  drivers/bluetooth/hci_intel.c |  7 ++-
>  4 files changed, 98 insertions(+), 26 deletions(-)
> 

I tested with ThP and it worked great as expected. However, when I used
a legacy WsP, it failed to download, and here is the output:

[  682.597921] Bluetooth: hci1: Bootloader revision 0.0 build 26 week 38 2015
[  682.598980] Bluetooth: hci1: Device revision is 16
[  682.598981] Bluetooth: hci1: Secure boot is enabled
[  682.598982] Bluetooth: hci1: OTP lock is enabled
[  682.598983] Bluetooth: hci1: API lock is enabled
[  682.598984] Bluetooth: hci1: Debug lock is disabled
[  682.598985] Bluetooth: hci1: Minimum firmware build 1 week 10 2014
[  682.602706] Bluetooth: hci1: Found device firmware: intel/ibt-12-16.sfi
[  682.602744] Bluetooth: hci1: Boot Address: 0x40800
[  682.602745] Bluetooth: hci1: Firmware Version: 26-38.15
[  682.602745] Bluetooth: hci1: Firmware already loaded
[  682.602829] Bluetooth: hci1: Waiting for device to boot
[  682.608593] usb 1-2: USB disconnect, device number 6
[  683.618723] Bluetooth: hci1: Device boot timeout
[  683.618817] Bluetooth: hci1: sending frame failed (-19)

It looks like the parameter values of "write_boot_params" command in the firmware
file is same as the bootloader version, when it should be the actual firmware
version, and it caused the firmeare downloading to fail.

So, for those legacy device like WsP and SfP, we may need to skip for checking the
version and try not to reload the firmware.

Regards,
Tedd

--=-v8sYEROfXx/sjFuc99KF
Content-Disposition: attachment; filename="fw_check_test_v6.txt"
Content-Transfer-Encoding: base64
Content-Type: text/plain; name="fw_check_test_v6.txt"; charset="UTF-8"

Y29sZCBib290ClsgICAgMy45MDYyNTFdIEJsdWV0b290aDogQ29yZSB2ZXIgMi4yMgpbICAgIDMu
OTA2MjY0XSBCbHVldG9vdGg6IEhDSSBkZXZpY2UgYW5kIGNvbm5lY3Rpb24gbWFuYWdlciBpbml0
aWFsaXplZApbICAgIDMuOTA2MjY2XSBCbHVldG9vdGg6IEhDSSBzb2NrZXQgbGF5ZXIgaW5pdGlh
bGl6ZWQKWyAgICAzLjkwNjI2OV0gQmx1ZXRvb3RoOiBMMkNBUCBzb2NrZXQgbGF5ZXIgaW5pdGlh
bGl6ZWQKWyAgICAzLjkwNjI3MF0gQmx1ZXRvb3RoOiBTQ08gc29ja2V0IGxheWVyIGluaXRpYWxp
emVkClsgICAgNC4wNjAzODFdIEJsdWV0b290aDogaGNpMDogQm9vdGxvYWRlciByZXZpc2lvbiAw
LjEgYnVpbGQgNDIgd2VlayA1MiAyMDE1ClsgICAgNC4wNjE2NTFdIEJsdWV0b290aDogaGNpMDog
RGV2aWNlIHJldmlzaW9uIGlzIDIKWyAgICA0LjA2MTY1NV0gQmx1ZXRvb3RoOiBoY2kwOiBTZWN1
cmUgYm9vdCBpcyBlbmFibGVkClsgICAgNC4wNjE2NTZdIEJsdWV0b290aDogaGNpMDogT1RQIGxv
Y2sgaXMgZW5hYmxlZApbICAgIDQuMDYxNjU2XSBCbHVldG9vdGg6IGhjaTA6IEFQSSBsb2NrIGlz
IGVuYWJsZWQKWyAgICA0LjA2MTY1N10gQmx1ZXRvb3RoOiBoY2kwOiBEZWJ1ZyBsb2NrIGlzIGRp
c2FibGVkClsgICAgNC4wNjE2NThdIEJsdWV0b290aDogaGNpMDogTWluaW11bSBmaXJtd2FyZSBi
dWlsZCAxIHdlZWsgMTAgMjAxNApbICAgIDQuMDgyMjM4XSBCbHVldG9vdGg6IGhjaTA6IEZvdW5k
IGRldmljZSBmaXJtd2FyZTogaW50ZWwvaWJ0LTE3LTE2LTEuc2ZpClsgICAgNC4wODIzMTVdIEJs
dWV0b290aDogaGNpMDogQm9vdCBBZGRyZXNzOiAweDQwODAwClsgICAgNC4wODIzMTZdIEJsdWV0
b290aDogaGNpMDogRmlybXdhcmUgVmVyc2lvbjogMjYtMTEuMjAKWyAgICA1LjY0NDYwMV0gQmx1
ZXRvb3RoOiBoY2kwOiBXYWl0aW5nIGZvciBmaXJtd2FyZSBkb3dubG9hZCB0byBjb21wbGV0ZQpb
ICAgIDUuNjQ1NDAxXSBCbHVldG9vdGg6IGhjaTA6IEZpcm13YXJlIGxvYWRlZCBpbiAxNTI2NTI0
IHVzZWNzClsgICAgNS42NDU0MjFdIEJsdWV0b290aDogaGNpMDogV2FpdGluZyBmb3IgZGV2aWNl
IHRvIGJvb3QKWyAgICA1LjY1ODQyN10gQmx1ZXRvb3RoOiBoY2kwOiBEZXZpY2UgYm9vdGVkIGlu
IDEyNzA5IHVzZWNzClsgICAgNS44NTc0NTNdIEJsdWV0b290aDogaGNpMDogRm91bmQgSW50ZWwg
RERDIHBhcmFtZXRlcnM6IGludGVsL2lidC0xNy0xNi0xLmRkYwpbICAgIDUuODYwNDI2XSBCbHVl
dG9vdGg6IGhjaTA6IEFwcGx5aW5nIEludGVsIEREQyBwYXJhbWV0ZXJzIGNvbXBsZXRlZApbICAg
IDUuODYzMzg1XSBCbHVldG9vdGg6IGhjaTA6IEZpcm13YXJlIHJldmlzaW9uIDAuMSBidWlsZCAy
NiB3ZWVrIDExIDIwMjAKWyAgICA1LjkyMTM2OV0gQmx1ZXRvb3RoOiBoY2kwOiBNU0ZUIGZpbHRl
cl9lbmFibGUgaXMgYWxyZWFkeSBvbgpbICAgIDYuMjM2MTUxXSBCbHVldG9vdGg6IEJORVAgKEV0
aGVybmV0IEVtdWxhdGlvbikgdmVyIDEuMwpbICAgIDYuMjM2MTUzXSBCbHVldG9vdGg6IEJORVAg
ZmlsdGVyczogcHJvdG9jb2wgbXVsdGljYXN0ClsgICAgNi4yMzYxNTVdIEJsdWV0b290aDogQk5F
UCBzb2NrZXQgbGF5ZXIgaW5pdGlhbGl6ZWQKWyAgIDIxLjQwMDIwNF0gQmx1ZXRvb3RoOiBSRkNP
TU0gVFRZIGxheWVyIGluaXRpYWxpemVkClsgICAyMS40MDAyMDhdIEJsdWV0b290aDogUkZDT01N
IHNvY2tldCBsYXllciBpbml0aWFsaXplZApbICAgMjEuNDAwMjExXSBCbHVldG9vdGg6IFJGQ09N
TSB2ZXIgMS4xMQoKUmVib290CmhhbjFAaGFuMS1OVUM4aTdCRUg6fiQgZG1lc2cgfCBncmVwIEJs
dWV0b290aApbICAgIDMuOTA5MDkzXSBCbHVldG9vdGg6IENvcmUgdmVyIDIuMjIKWyAgICAzLjkw
OTEyNF0gQmx1ZXRvb3RoOiBIQ0kgZGV2aWNlIGFuZCBjb25uZWN0aW9uIG1hbmFnZXIgaW5pdGlh
bGl6ZWQKWyAgICAzLjkwOTEzMF0gQmx1ZXRvb3RoOiBIQ0kgc29ja2V0IGxheWVyIGluaXRpYWxp
emVkClsgICAgMy45MDkxMzJdIEJsdWV0b290aDogTDJDQVAgc29ja2V0IGxheWVyIGluaXRpYWxp
emVkClsgICAgMy45MDkxMzVdIEJsdWV0b290aDogU0NPIHNvY2tldCBsYXllciBpbml0aWFsaXpl
ZApbICAgIDMuOTkyMDQzXSBCbHVldG9vdGg6IGhjaTA6IEZpcm13YXJlIHJldmlzaW9uIDAuMSBi
dWlsZCAyNiB3ZWVrIDExIDIwMjAKWyAgICA0LjAyMzgxNl0gQmx1ZXRvb3RoOiBoY2kwOiBGb3Vu
ZCBkZXZpY2UgZmlybXdhcmU6IGludGVsL2lidC0xNy0xNi0xLnNmaQpbICAgIDQuMDIzOTUzXSBC
bHVldG9vdGg6IGhjaTA6IEJvb3QgQWRkcmVzczogMHg0MDgwMApbICAgIDQuMDIzOTU3XSBCbHVl
dG9vdGg6IGhjaTA6IEZpcm13YXJlIFZlcnNpb246IDI2LTExLjIwClsgICAgNC4wMjM5NThdIEJs
dWV0b290aDogaGNpMDogRmlybXdhcmUgYWxyZWFkeSBsb2FkZWQKWyAgICA0LjA4MjYxNl0gQmx1
ZXRvb3RoOiBoY2kwOiBNU0ZUIGZpbHRlcl9lbmFibGUgaXMgYWxyZWFkeSBvbgpbICAgIDYuODU4
Mjc2XSBCbHVldG9vdGg6IEJORVAgKEV0aGVybmV0IEVtdWxhdGlvbikgdmVyIDEuMwpbICAgIDYu
ODU4Mjc4XSBCbHVldG9vdGg6IEJORVAgZmlsdGVyczogcHJvdG9jb2wgbXVsdGljYXN0ClsgICAg
Ni44NTgyODFdIEJsdWV0b290aDogQk5FUCBzb2NrZXQgbGF5ZXIgaW5pdGlhbGl6ZWQKWyAgICA2
Ljk2MjYxMF0gQmx1ZXRvb3RoOiBoY2kwOiBNU0ZUIGZpbHRlcl9lbmFibGUgaXMgYWxyZWFkeSBv
bgpbICAgNTMuODE1OTczXSBCbHVldG9vdGg6IFJGQ09NTSBUVFkgbGF5ZXIgaW5pdGlhbGl6ZWQK
WyAgIDUzLjgxNTk3OV0gQmx1ZXRvb3RoOiBSRkNPTU0gc29ja2V0IGxheWVyIGluaXRpYWxpemVk
ClsgICA1My44MTU5ODJdIEJsdWV0b290aDogUkZDT01NIHZlciAxLjExCgoKTmV3IEZXICsgUmVi
b290ClsgICAgMy44MzE3NzNdIEJsdWV0b290aDogQ29yZSB2ZXIgMi4yMgpbICAgIDMuODMxNzg4
XSBCbHVldG9vdGg6IEhDSSBkZXZpY2UgYW5kIGNvbm5lY3Rpb24gbWFuYWdlciBpbml0aWFsaXpl
ZApbICAgIDMuODMxNzkwXSBCbHVldG9vdGg6IEhDSSBzb2NrZXQgbGF5ZXIgaW5pdGlhbGl6ZWQK
WyAgICAzLjgzMTc5MV0gQmx1ZXRvb3RoOiBMMkNBUCBzb2NrZXQgbGF5ZXIgaW5pdGlhbGl6ZWQK
WyAgICAzLjgzMTc5NF0gQmx1ZXRvb3RoOiBTQ08gc29ja2V0IGxheWVyIGluaXRpYWxpemVkClsg
ICAgNC4xMjA0OThdIEJsdWV0b290aDogaGNpMDogRmlybXdhcmUgcmV2aXNpb24gMC4xIGJ1aWxk
IDI2IHdlZWsgMTEgMjAyMApbICAgIDQuMTI4Njc0XSBCbHVldG9vdGg6IGhjaTA6IEZvdW5kIGRl
dmljZSBmaXJtd2FyZTogaW50ZWwvaWJ0LTE3LTE2LTEuc2ZpClsgICAgNC4xMjg4MzFdIEJsdWV0
b290aDogaGNpMDogQm9vdCBBZGRyZXNzOiAweDQwODAwClsgICAgNC4xMjg4MzZdIEJsdWV0b290
aDogaGNpMDogRmlybXdhcmUgVmVyc2lvbjogMTY4LTQ4LjIwClsgICAgNi4xNDYzMTFdIEJsdWV0
b290aDogaGNpMDogY29tbWFuZCAweGZjMDEgdHggdGltZW91dApbICAgIDcuMDI3NTYxXSBCbHVl
dG9vdGg6IEJORVAgKEV0aGVybmV0IEVtdWxhdGlvbikgdmVyIDEuMwpbICAgIDcuMDI3NTYzXSBC
bHVldG9vdGg6IEJORVAgZmlsdGVyczogcHJvdG9jb2wgbXVsdGljYXN0ClsgICAgNy4wMjc1Njhd
IEJsdWV0b290aDogQk5FUCBzb2NrZXQgbGF5ZXIgaW5pdGlhbGl6ZWQKWyAgIDE0LjE0MjcxMF0g
Qmx1ZXRvb3RoOiBoY2kwOiBGVyBkb3dubG9hZCBlcnJvciByZWNvdmVyeSBmYWlsZWQgKC0xMTAp
ClsgICAxNC41Njk2NTRdIEJsdWV0b290aDogaGNpMDogQm9vdGxvYWRlciByZXZpc2lvbiAwLjEg
YnVpbGQgNDIgd2VlayA1MiAyMDE1ClsgICAxNC41NzA2NjVdIEJsdWV0b290aDogaGNpMDogRGV2
aWNlIHJldmlzaW9uIGlzIDIKWyAgIDE0LjU3MDY3M10gQmx1ZXRvb3RoOiBoY2kwOiBTZWN1cmUg
Ym9vdCBpcyBlbmFibGVkClsgICAxNC41NzA2NzhdIEJsdWV0b290aDogaGNpMDogT1RQIGxvY2sg
aXMgZW5hYmxlZApbICAgMTQuNTcwNjgzXSBCbHVldG9vdGg6IGhjaTA6IEFQSSBsb2NrIGlzIGVu
YWJsZWQKWyAgIDE0LjU3MDY4OF0gQmx1ZXRvb3RoOiBoY2kwOiBEZWJ1ZyBsb2NrIGlzIGRpc2Fi
bGVkClsgICAxNC41NzA2OTZdIEJsdWV0b290aDogaGNpMDogTWluaW11bSBmaXJtd2FyZSBidWls
ZCAxIHdlZWsgMTAgMjAxNApbICAgMTQuNTcxODU1XSBCbHVldG9vdGg6IGhjaTA6IEZvdW5kIGRl
dmljZSBmaXJtd2FyZTogaW50ZWwvaWJ0LTE3LTE2LTEuc2ZpClsgICAxNC41NzE4OTJdIEJsdWV0
b290aDogaGNpMDogQm9vdCBBZGRyZXNzOiAweDQwODAwClsgICAxNC41NzE4OTRdIEJsdWV0b290
aDogaGNpMDogRmlybXdhcmUgVmVyc2lvbjogMTY4LTQ4LjIwClsgICAxNi4wMTE0NzFdIEJsdWV0
b290aDogaGNpMDogV2FpdGluZyBmb3IgZmlybXdhcmUgZG93bmxvYWQgdG8gY29tcGxldGUKWyAg
IDE2LjAxMTU1NF0gQmx1ZXRvb3RoOiBoY2kwOiBGaXJtd2FyZSBsb2FkZWQgaW4gMTQwNTk1NCB1
c2VjcwpbICAgMTYuMDExNTc2XSBCbHVldG9vdGg6IGhjaTA6IFdhaXRpbmcgZm9yIGRldmljZSB0
byBib290ClsgICAxNi4wMjU3MTddIEJsdWV0b290aDogaGNpMDogRGV2aWNlIGJvb3RlZCBpbiAx
MzgwNyB1c2VjcwpbICAgMTYuMDI4NDQ5XSBCbHVldG9vdGg6IGhjaTA6IEZvdW5kIEludGVsIERE
QyBwYXJhbWV0ZXJzOiBpbnRlbC9pYnQtMTctMTYtMS5kZGMKWyAgIDE2LjAzMDY1NV0gQmx1ZXRv
b3RoOiBoY2kwOiBBcHBseWluZyBJbnRlbCBEREMgcGFyYW1ldGVycyBjb21wbGV0ZWQKWyAgIDE2
LjAzMzc2Ml0gQmx1ZXRvb3RoOiBoY2kwOiBGaXJtd2FyZSByZXZpc2lvbiAwLjEgYnVpbGQgMTY4
IHdlZWsgNDggMjAyMApbICAgMTYuMDk1NjMyXSBCbHVldG9vdGg6IGhjaTA6IE1TRlQgZmlsdGVy
X2VuYWJsZSBpcyBhbHJlYWR5IG9uClsgIDg5MS43OTIwNTRdIEJsdWV0b290aDogUkZDT01NIFRU
WSBsYXllciBpbml0aWFsaXplZApbICA4OTEuNzkyMDU5XSBCbHVldG9vdGg6IFJGQ09NTSBzb2Nr
ZXQgbGF5ZXIgaW5pdGlhbGl6ZWQKWyAgODkxLjc5MjA2Ml0gQmx1ZXRvb3RoOiBSRkNPTU0gdmVy
IDEuMTEKCg==


--=-v8sYEROfXx/sjFuc99KF--

