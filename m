Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 19 Nov 2015 12:03:51 +0530
Message-ID: <CAKafyqpQwmUOHwH8j68kkni_k8F4pKAKE674w1pvAuL91GjrAw@mail.gmail.com>
Subject: HoG: Report Map Sharing is not Happening all the time.
From: Prabhu Chawandi <foss.chaws@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,

  In My bluetooth Smart Keyboard sometimes though connection is
established key presses were not being received by application. I
tried running 'evtest' /dev/input/eventX node was not created when the
issue was seen. After some debug I found the Report Maps were not
shared. [i dint see the log when run bluetoothd -d

1. Is it necessary to share report map all the time system is reboot ?
2. is the Report map not cached ? or Cached which system failed to pick ?

Please let me know your views.

many thanks,
Prabhu Chawandi
