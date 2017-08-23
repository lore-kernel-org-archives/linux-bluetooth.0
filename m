Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 22 Aug 2017 22:09:18 -0400
Message-ID: <CADnq5_PvCCWpx-+zbvxHC_SRG3Yq-n7wqy59ymGb=GUmm3Bkdw@mail.gmail.com>
Subject: RTL8822BE Bluetooth device
To: linux-bluetooth@vger.kernel.org, alex_lu@realsil.com.cn,
        Larry.Finger@lwfinger.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I have this device, but the driver requires a firmware file
(rtl8821a_config.bin) which does not seem to exist.  Looking at the
code[1], there appear to be several firmware config files for variants
of this device:
+ switch (lmp_subver) {
+ case RTL_ROM_LMP_8723B:
+ cfg_name = "rtl_bt/rtl8723b_config.bin";
+ break;
+ case RTL_ROM_LMP_8821A:
+ cfg_name = "rtl_bt/rtl8821a_config.bin";
+ break;
+ case RTL_ROM_LMP_8761A:
+ cfg_name = "rtl_bt/rtl8761a_config.bin";
+ break;
+ case RTL_ROM_LMP_8822B:
+ cfg_name = "rtl_bt/rtl8822b_config.bin";
+ break;
However, the only file that seem to actually exist is
rtl8822b_config.bin.  Does anyone know where to get the others?

Thanks,

Alex

[1] https://patchwork.kernel.org/patch/9323749/
