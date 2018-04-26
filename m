Return-Path: <loic.poulain@linaro.org>
MIME-Version: 1.0
In-Reply-To: <eec3a56977ca821c1e13537ab35b0c97@codeaurora.org>
References: <1524506380-7417-1-git-send-email-loic.poulain@linaro.org>
 <1524506380-7417-2-git-send-email-loic.poulain@linaro.org>
 <B39D4D6F-96FB-442E-84D8-BEA603E7A053@holtmann.org> <CAMZdPi8ABhv8EDaE+afFpHexuMKjst5djiMt4HFoGqPNHs+akQ@mail.gmail.com>
 <f46651bdc4bdab38ec6f2b00b7fda142@codeaurora.org> <CAMZdPi_khDRySWydoe577Q3vmDFzQY0SBzweJD60026Gb0d8Gw@mail.gmail.com>
 <eec3a56977ca821c1e13537ab35b0c97@codeaurora.org>
From: Loic Poulain <loic.poulain@linaro.org>
Date: Thu, 26 Apr 2018 08:52:54 +0200
Message-ID: <CAMZdPi9=VsrfomPCZURuGApEzakjKjD_8YjHfnO+i4e-1EgMLA@mail.gmail.com>
Subject: Re: [PATCH 2/2] Bluetooth: btqca: Add AR3002 rampatch support
To: bgodavar@codeaurora.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	"open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, linux-arm-msm@vger.kernel.org,
	kkapra@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Balakrishna,

> A small suggestion from my side, suppose in near future ROME <v3.2 wanted to
> go with new format i.e. acknowledging for last segment of RAM patch.
> then checking rom_build field may not work.
> i.e.
> if (le16_to_cpu(tlv_patch->rom_build) >= 0x0302)
> config->dnld_mode = tlv_patch->download_mode;
>
> i suggest you to check the byte download_mode directly and decide to wait
> for ACK from SoC, for every RAM patch segment sent.
> i think byte download_mode is explicitly for mode of downloading the patch
> i.e. with ACK or NACK. (pls double confirm about this byte).

Yes AFAIK, this byte is for download mode or reserved (0). So yes we
can unconditionally check it to determine the mode.

Regards,
Loic
