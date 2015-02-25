Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@tieto.com>
Subject: [PATCHv4 0/3] HOGP fixes and update of test results
Date: Wed, 25 Feb 2015 13:22:08 +0100
Message-Id: <1424866931-13334-1-git-send-email-mariusz.skamra@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

  I deleted most of the code related to finding include services. This was only used
in situation when HID service as primary service was not found. However according to
SPEC HID device shall implement HID service as primary. Further HOG is called
from hidhost's hog_conn_cb when HID service was found and connection was established using LE.
Now searching for include services is performed because TC_HGDR_RH_BV_01_I requires that.
Finding battery services is performed like before, during primary services discovery.
Compared to v3 I used queue instead of GSList for bas.

  Add a queue of battery services because according to HOGP SPEC there could be more
than one battery services like in TC_HGDC_HH_BV_14_I where there is only one HID service,
and two battery services. So the first found bas was overwritten by the second one and
after reconnection only one bas was attached.

  For test purposes requiring read of battery level read_value_cb was added.

Mariusz Skamra (3):
  android/bas: Read battery level characteristic
  android/hog: Fix find included battery services
  android/pts: Update test results for HOGP

 android/bas.c        | 13 ++++++--
 android/hog.c        | 84 +++++++++++++++++-----------------------------------
 android/pts-hogp.txt |  6 ++--
 3 files changed, 41 insertions(+), 62 deletions(-)

-- 
1.9.1

