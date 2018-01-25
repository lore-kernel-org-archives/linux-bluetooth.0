Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Vincent Petry <pvince81@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Apparent bluez 5.48 regression: Headphones fail to reconnect after
 suspend/resume
Message-ID: <d74ae042-eec6-e4bb-45f9-904631fe642b@gmail.com>
Date: Thu, 25 Jan 2018 07:44:33 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I just joined the mailing list so can't directly reply to old messages,
so sending with same title.

I'm experiencing the same issue as Robert here
https://www.spinics.net/lists/linux-bluetooth/msg73824.html, happening
on the same laptop Dell XPS 13 but with different sub-model 9333, but on
openSUSE Tumbleweed.

It looks like the bluez component is in a wrong state when either
loading btusb with modprobe later on or resuming from suspend. The
workaround is to restart the systemd bluetooth daemon. I suspect that
plugging in USB bluetooth dongles would also have the same issue but I
don't have one to test.

It used to work correctly before the upgrade from 5.47 to 5.48.

See my original report here for details:
https://bugzilla.suse.com/show_bug.cgi?id=1076898
Robert's report https://bugzilla.redhat.com/show_bug.cgi?id=1534857,
also confirmed by a third person.

Please let us know if this is reproducible on your side or whether it's
an isolated case specific to our Dell hardware.

Thanks,

Vincent Petry




