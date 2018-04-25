Return-Path: <bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Wed, 25 Apr 2018 20:49:29 +0530
From: bgodavar@codeaurora.org
To: Loic Poulain <loic.poulain@linaro.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, "open list:BLUETOOTH DRIVERS"
 <linux-bluetooth@vger.kernel.org>, linux-arm-msm@vger.kernel.org,
 kkapra@codeaurora.org
Subject: Re: [PATCH 2/2] Bluetooth: btqca: Add AR3002 rampatch support
In-Reply-To: <CAMZdPi_khDRySWydoe577Q3vmDFzQY0SBzweJD60026Gb0d8Gw@mail.gmail.com>
References: <1524506380-7417-1-git-send-email-loic.poulain@linaro.org>
 <1524506380-7417-2-git-send-email-loic.poulain@linaro.org>
 <B39D4D6F-96FB-442E-84D8-BEA603E7A053@holtmann.org>
 <CAMZdPi8ABhv8EDaE+afFpHexuMKjst5djiMt4HFoGqPNHs+akQ@mail.gmail.com>
 <f46651bdc4bdab38ec6f2b00b7fda142@codeaurora.org>
 <CAMZdPi_khDRySWydoe577Q3vmDFzQY0SBzweJD60026Gb0d8Gw@mail.gmail.com>
Message-ID: <eec3a56977ca821c1e13537ab35b0c97@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

On 2018-04-25 19:07, Loic Poulain wrote:
> Hi Balakrishna,
> 
> On 25 April 2018 at 14:16,  <bgodavar@codeaurora.org> wrote:
>> 
>> Thank you for adding me to loop, is the header size of RAM patch file
>> remains same for ROME < 3.2 and ROME >= 3.2, what about the header 
>> format,
>> do we have same header format for different ROME versions, even 
>> mismatch of
>> header will not break any execution, but it may show wrong data in 
>> kernel
>> logs.
> 
> Yes, at least in my case, we just use byte 7 which was previously 
> 'reserved':
> 
>  struct edl_event_hdr {
> @@ -94,7 +102,8 @@ struct tlv_type_patch {
>         __le32 data_length;
>         __u8   format_version;
>         __u8   signature;
> -       __le16 reserved1;
> +       __u8   download_mode;
> +       __u8   reserved1;
>         __le16 product_id;
>         __le16 rom_build;
>         __le16 patch_version;
> 
> Regards,
> Loic

A small suggestion from my side, suppose in near future ROME <v3.2 
wanted to go with new format i.e. acknowledging for last segment of RAM 
patch.
then checking rom_build field may not work.
i.e.
if (le16_to_cpu(tlv_patch->rom_build) >= 0x0302)
config->dnld_mode = tlv_patch->download_mode;

i suggest you to check the byte download_mode directly and decide to 
wait for ACK from SoC, for every RAM patch segment sent.
i think byte download_mode is explicitly for mode of downloading the 
patch i.e. with ACK or NACK. (pls double confirm about this byte).

This is how we are doing for wcn3990 (in Add support wcn3990 patch).

Regards
Balakrishna.
