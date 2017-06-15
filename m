Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: mohammed rilwan <rilwan03@gmail.com>
Date: Thu, 15 Jun 2017 13:35:16 +0530
Message-ID: <CAMaUp9ZGPv2EzzpHsnmEnc8stK=S1ob+LaGAoYDhKGLaj2=-WQ@mail.gmail.com>
Subject: bluetooth sco connection
To: linux-bluetooth@vger.kernel.org,
        General PulseAudio Discussion
        <pulseaudio-discuss@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

sco connection fails on ubuntu 17.04 with external bluetooth dongle
where as a2dp works well.Tried with several dongles-broadcom,mediatek.
With inbuilt dongle everything works fine.

Any help please.
while getting call i am getting below log -

Jun 15 13:23:56 sat rtkit-daemon[1239]: Supervising 3 threads of 1
processes of 1 users.
Jun 15 13:23:56 sat rtkit-daemon[1239]: Successfully made thread 26213
of process 1697 (n/a) owned by '1000' RT at priority 5.
Jun 15 13:23:56 sat rtkit-daemon[1239]: Supervising 4 threads of 1
processes of 1 users.
Jun 15 13:23:56 sat dbus[778]: [system] Rejected send message, 3
matched rules; type="method_return", sender=":1.99" (uid=1000 pid=1697
comm="/usr/bin/pulseaudio --start --log-target=syslog ")
interface="(unset)" member="(unset)" error name="(unset)"
requested_reply="0" destination=":1.125" (uid=0 pid=2294
comm="/usr/sbin/ofonod -P ril --nodetach ")

Thanks
Rilwan
