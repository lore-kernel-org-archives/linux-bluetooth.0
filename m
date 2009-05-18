Return-Path: <cyrus@holtmann.org>
Subject: RE: Passkey-Agent for bluez 4.xx
From: Marcel Holtmann <marcel@holtmann.org>
To: "Wilson, Scott" <SCOTT.WILSON@CUBIC.COM>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <88BAD6A2A6AF68449DBBF80948806AC9014F56F0@bb-corp-ex1.corp.cubic.cub>
References: <88BAD6A2A6AF68449DBBF80948806AC9014F5692@bb-corp-ex1.corp.cubic.cub>
	 <20090518205242.256782ab@symphony>
	 <88BAD6A2A6AF68449DBBF80948806AC9014F56F0@bb-corp-ex1.corp.cubic.cub>
Content-Type: text/plain
Date: Mon, 18 May 2009 15:16:10 -0700
Message-Id: <1242684970.17495.3.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Scott,

> >> My question is, how hard would it be to fix the agent.c code myself?
> 
> >Most of the work has been done, I believe. You should speak to Alan
> >Carvalho de Assis at acassis@gmail.com.
> 
> >James
> 
> I have some additional questions:
> 
> While on the "full" Linux operating system (on a PC), some type of agent
> is installed and executed for me in that environment.  Where is this
> agent coming from?  How is it being executed for me? To my knowledge, I
> have never installed an agent or configured one.
> 
> I can't seem to find many agent interactions in the Bluez code -
> although I find references to it.  Not surprisingly, the main agent
> reference is in test/agent.c.
> 
> When I go to execute my project on my embedded device, there is no
> agent.  From all other aspects that I am aware of, the other things
> (dbus, bluez, etc) seem to be similar (my team has already tackled those
> challenges - although some may still remain).
> 
> Is it possible that this agent is not included with the dbus that runs
> on the embedded device, but is on the PC?  Does Gnome include this
> agent?  Does it come from the bluetooth-applet?

the simple answer is yes. The agent is part of bluetooth-applet. Either
from bluez-gnome package or nowadays from gnome-bluetooth.

The agent is running in a userspace session, while bluetoothd running at
system level as root.

Other example agents are test/agent.c or simple-agent. Also KDE has its
own agent and so does the Maemo based devices.

Regards

Marcel


