Return-Path: <loic.poulain@linaro.org>
MIME-Version: 1.0
In-Reply-To: <f46651bdc4bdab38ec6f2b00b7fda142@codeaurora.org>
References: <1524506380-7417-1-git-send-email-loic.poulain@linaro.org>
 <1524506380-7417-2-git-send-email-loic.poulain@linaro.org>
 <B39D4D6F-96FB-442E-84D8-BEA603E7A053@holtmann.org> <CAMZdPi8ABhv8EDaE+afFpHexuMKjst5djiMt4HFoGqPNHs+akQ@mail.gmail.com>
 <f46651bdc4bdab38ec6f2b00b7fda142@codeaurora.org>
From: Loic Poulain <loic.poulain@linaro.org>
Date: Wed, 25 Apr 2018 15:37:29 +0200
Message-ID: <CAMZdPi_khDRySWydoe577Q3vmDFzQY0SBzweJD60026Gb0d8Gw@mail.gmail.com>
Subject: Re: [PATCH 2/2] Bluetooth: btqca: Add AR3002 rampatch support
To: bgodavar@codeaurora.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	"open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, linux-arm-msm@vger.kernel.org,
	kkapra@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Balakrishna,

On 25 April 2018 at 14:16,  <bgodavar@codeaurora.org> wrote:
>
> Thank you for adding me to loop, is the header size of RAM patch file
> remains same for ROME < 3.2 and ROME >= 3.2, what about the header format,
> do we have same header format for different ROME versions, even mismatch of
> header will not break any execution, but it may show wrong data in kernel
> logs.

Yes, at least in my case, we just use byte 7 which was previously 'reserved':

 struct edl_event_hdr {
@@ -94,7 +102,8 @@ struct tlv_type_patch {
        __le32 data_length;
        __u8   format_version;
        __u8   signature;
-       __le16 reserved1;
+       __u8   download_mode;
+       __u8   reserved1;
        __le16 product_id;
        __le16 rom_build;
        __le16 patch_version;

Regards,
Loic
