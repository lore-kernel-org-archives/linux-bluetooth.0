Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Syam Sidhardhan <s.syam@samsung.com>
Subject: [PATCH BlueZ 0/3] SDP build warning and EIR parsing
Date: Mon, 16 Apr 2012 18:31:35 +0530
Message-id: <1334581298-11877-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patchset is sending as per my discussion with Johan over the IRC#bluez.
The first patch is: While building the code with the maintainer mode enable,
is throwing warning and further it leads to a build break in different cross
compilation environment.

The second and third patch is related to the EIR parsing.
Since the eir_length() parsing return value is incorrect, we are appending
the COD at incorrect location. As a result, while retrieving back we are
unable to get the COD back during emiting device found signal during discovery.

The same fix is required in the eir_has_data_type() aswell.



Syam Sidhardhan (3):
  sdp: Fix compilation warning due to data type mismatch
  eir: Fix incorrect eir_length() parsing
  eir: Fix incorrect eir_has_data_type() parsing

 lib/sdp.c |    2 +-
 src/eir.c |    8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

-- 
1.7.4.1

