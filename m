Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: armansito@google.com
Date: Tue, 27 Jan 2015 18:11:32 -0800
Message-ID: <CAHrH25Qfr9bRYad0scysHMcUD+SY651y4qZLk4EAWk-ym+970Q@mail.gmail.com>
Subject: GATT D-Bus API handling notifications
From: Arman Uguray <armansito@chromium.org>
To: BlueZ development <linux-bluetooth@vger.kernel.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

Earlier I chatted with Marcel on IRC about how we can resolve the
notification subscription issue that you were concerned about
(basically a server connecting and immediately sending a
notification). I think our consensus was that this mainly applies when
the two devices are bonded. In that case, we could make it so that the
exported GattService1 hierarchy stays around over disconnections if
there is a bond between the two devices. We would keep
StartNotify/StopNotify and keep around the data on external clients
that subscribed to notifications. Upon reconnection we would then
immediately register for notifications based on all the external
clients that subscribed.

Would this address the case? I think this case really applies when the
remote CCC has been configured so the peripheral remembers the
configuration between disconnections, which should only happen when
the devices are bonded but I'm not sure.

Let me know if that makes sense! Thanks!
Arman
