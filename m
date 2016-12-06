Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Don Zickus <dzickus@redhat.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, brn@deako.com,
        Don Zickus <dzickus@redhat.com>
Subject: [RFC 0/3] core/adapter: Add disabling duplicate device filtering from d-bus
Date: Tue,  6 Dec 2016 16:39:57 -0500
Message-Id: <1481060400-7088-1-git-send-email-dzickus@redhat.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Recent discussions on the bluez mailing list revealed it was not easy
to disable duplicate device filtering from the d-bus interface.

As a result, if I wanted to monitor LE devices entering and leaving the
adapters range (using RSSI data), it was difficult.

This patchset is a dirty hack to make this work. The first patch enables
it on the kernel side, while the other two patches enable it from the bluez
side.

I understand there are concerns about flooding the d-bus interface when
enabling this.  I tried to write a throttling mechanism using the mainloop
as my timer, but soon realized you can only have 1 device RSSI event
per loop, so that wasn't going to work.  Open to suggestions if still a
concern.

Posted as an RFC just to generate discussion.  I expect I missed a lot of
little details here, but wanted to post my proof of concept to see if this
is something to work with.

This patchset includes both the kernel and bluez patches.  I understand this is
not recommended for normal practice.  But I thought for an RFC, it is nice to
keep things together for now.



kernel:

Don Zickus (1):
  bluetooth: Add managment ability to disable duplicate device fitlering

 include/net/bluetooth/hci_core.h | 1 +
 include/net/bluetooth/mgmt.h     | 1 +
 net/bluetooth/hci_request.c      | 2 +-
 net/bluetooth/mgmt.c             | 5 +++++
 4 files changed, 8 insertions(+), 1 deletion(-)


bluez:

Don Zickus (2):
  core/adapter: Add le_duplicates flag to management interface
  core/adapter: Hook le_duplicates into d-bus interface

 client/main.c       |  5 +++++
 doc/adapter-api.txt |  1 +
 lib/mgmt.h          |  1 +
 src/adapter.c       | 37 +++++++++++++++++++++++++++++++------
 4 files changed, 38 insertions(+), 6 deletions(-)

-- 
1.8.3.1

