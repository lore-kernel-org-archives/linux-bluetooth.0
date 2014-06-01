Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Mark Ventimiglia <mark.ventimiglia@gmail.com>
Date: Sat, 31 May 2014 22:49:34 -0500
Message-ID: <CANhQzn18sxtZkq2gQPqBnJD+v+t55ah9GWqR0yEemFOt6dnmQg@mail.gmail.com>
Subject: Bluez 5.18 - Agent not being released when unregistered
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I'm writing a custom agent for an embedded Linux application that's
running BlueZ 5.18 on a Raspberry Pi w/ Linux 3.6.11+. I am able to
register the agent and handle pairing requests fine, but when I
unregister the agent I'm not seeing the D-Bus Release method call go
out. To test this, I wrote a simple program to register the agent,
sleep for 3 seconds, and unregister the agent. When I turn on debug
for bluetoothd, I get the following in the debug log:

Jun  1 00:46:27 raspberrypi bluetoothd[5498]: src/agent.c:agent_ref()
0x1fee8e0: ref=1
Jun  1 00:46:27 raspberrypi bluetoothd[5498]:
src/agent.c:register_agent() agent :1.284
Jun  1 00:46:27 raspberrypi bluetoothd[5498]:
src/agent.c:set_default_agent() Default agent set to :1.284
/test/agent
Jun  1 00:46:30 raspberrypi bluetoothd[5498]:
src/agent.c:unregister_agent() agent :1.284
Jun  1 00:46:30 raspberrypi bluetoothd[5498]:
src/agent.c:agent_disconnect() Agent :1.284 disconnected
Jun  1 00:46:30 raspberrypi bluetoothd[5498]:
src/agent.c:set_default_agent() Default agent cleared
Jun  1 00:46:31 raspberrypi bluetoothd[5498]:
src/agent.c:agent_destroy() agent :1.284
Jun  1 00:46:31 raspberrypi bluetoothd[5498]:
src/agent.c:agent_unref() 0x1fee8e0: ref=0

I noticed that agent_release() is not called. In the 5.18 code,
agent_release() is called by agent_destroy(), which is installed as a
hash table remove hook that is called when agent_disconnect() calls
g_hash_table_remove(). Before removing the agent from the hash table,
agent_disconnect() sets agent->watch = 0. However, agent_destroy()
only calls agent_release() if agent->watch == 0. According to my read,
this can never be true (and agent_release() will never get called)
because agent->watch will have already been set to 0 in
agent_disconnect() before agent_destroy() is ever called.

Am I missing something in this sequence of events? Or is
agent_release() not supposed to be called when an agent is
unregistered?

Regards,
Mark
