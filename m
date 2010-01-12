Return-Path: <cyrus@holtmann.org>
Message-ID: <4B4CE9A0.3020902@pardus.org.tr>
Date: Tue, 12 Jan 2010 23:29:04 +0200
From: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozan@pardus.org.tr>
MIME-Version: 1.0
To: Linux Wireless List <linux-wireless@vger.kernel.org>,
	linux-bluetooth@vger.kernel.org
Subject: CONFIG_BT_CMTP is not checked in compat-wireless
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

CONFIG_BT_CMTP depends on BT && BT_L2CAP && ISDN_CAPI but in config.mk there isn't an explicit check for
those conditions. On a ISDN_CAPI disabled kernel this causes unresolved symbols as cmtp.ko is built

Something like below fixes the problem (at least for CMTP case) by not compiling net/bluetooth/cmtp:

# CONFIG_BT_CMTP depends on ISDN_CAPI
ifneq ($(CONFIG_BT_CMTP),)
CONFIG_BT_CMTP=m
endif


Regards,
Ozan Caglayan

