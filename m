Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Bobby Noelte <b0661n0e17e@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bobby Noelte <b0661n0e17e@gmail.com>
Subject: [Patch BlueZ 0/1] Make network server interface handling more robust
Date: Sun, 18 Sep 2016 18:35:30 +0200
Message-Id: <1474216531-11518-1-git-send-email-b0661n0e17e@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I encountered a lot problems connecting to a NAP server running on
Ubuntu 16.04 x86_64. Systemd-udev was renaming the bnepx interfaces
before network server could bring up the interface. Network server
went on to use the original interface name and failed on the creation
of the interface. This did not happen always but quite often.

The obvious solution was to prevent udev from renaming. But I could
not make that work. Also, IMHO, it is the task of bluetoothd to cope
with this situation because systemd-udev is now pretty common.

The choosen solution is to use the interface index where possible.
It does not change on rename. The kernel does not provide the ifindex
on BNEPCONNADD, but the interface name. So there is still a race
condition when retrieving the ifindex. Also there are race conditions
when using an interface name that was retrieved by interface index;
which is necessary for if up/down. To cope with these potential
races retry cycles are added.

The patched version of bluetoothd was tested using a SAMSUNG S2
(Android 4.1.2) and a NVIDIA Shield (Android 5.1.1). No connection
errors due to interface creation were realized so far. The
retries are necessary though.

The patch is 'minimal invasive'. Only the file bnep.c is changed.
Only static local function interfaces of bnep.c are changed/ added.
The patch also adds documentation to the static local functions
that are substantially changed or added. make check is passed.

Comments, suggestions appreciated.
Thanks,

Bobby

b0661n0e71e@gmail.com (1):
  Make network server interface handling more robust

 profiles/network/bnep.c | 311 ++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 260 insertions(+), 51 deletions(-)

--
2.7.4

