Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Oliver Rode <oli67r@gmail.com>
Date: Mon, 29 Aug 2016 23:58:38 +0200
Message-ID: <CAGNHjALN16FE0_7r4EYCELK5zA5nhs_QkNHC5_my1xtQT5wPmg@mail.gmail.com>
Subject: [RFC] Bluetooth: API: Registering Agent1 object has no effect
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi everybody,

I have trouble with registering an Agent1 object over glib2.0 D-Bus API.
Do you have a current example that works with the new D-Bus API?


The desired effect is, when pairing with a CC2650 sensor tag, my agent1
object's callback get invoked and not the desktop's agent (he display a
pop-up and queries - i want to handle this by a coded subroutine).

With bluetoothctl it works to prevent the desktop from displaying the
popup. But this cute tool seems not to be ported to the new D-Bus API, so i
it works different (but very very cool tool !!).

I tried to archive this over glib2.0 and gdbus-codegen but it does not work.

An Agent1 object can be successfully been registered with BlueZ's
AgentManager1, but during pairing it is expected that the Agent1 call-back
method is invoked. That does not happen. Instead the desktop's agent popup
is displayed. Something wents wrong. I need to find out why AgentManager1's
registerAgent() and requestDefaultAgent() do fail, but do not report an
error.

I did not manage to find out with bluetoothctl what happens. For some
reason the callback of the Agent1 object are not invoked. Maybe a glib
issue ? What is the right debugging setup to find this out?

Maybe you can help me with some hints or a C example. Thank you.!

Regards,
Oliver


PS:
My project and the issue is public. Please be aware it is invoked over
Java/JNI:
https://github.com/olir/lbt4j/issues/1
