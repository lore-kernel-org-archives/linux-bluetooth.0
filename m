Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Passkey-Agent for bluez 4.xx
Date: Mon, 18 May 2009 14:53:38 -0700
Message-ID: <88BAD6A2A6AF68449DBBF80948806AC9014F56F0@bb-corp-ex1.corp.cubic.cub>
In-Reply-To: <20090518205242.256782ab@symphony>
References: <88BAD6A2A6AF68449DBBF80948806AC9014F5692@bb-corp-ex1.corp.cubic.cub> <20090518205242.256782ab@symphony>
From: "Wilson, Scott" <SCOTT.WILSON@CUBIC.COM>
To: <linux-bluetooth@vger.kernel.org>
Cc: "Wilson, Scott" <SCOTT.WILSON@CUBIC.COM>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

All,

Regarding my earlier post and the reply by James Le Cuirot:

>> My question is, how hard would it be to fix the agent.c code myself?

>Most of the work has been done, I believe. You should speak to Alan
>Carvalho de Assis at acassis@gmail.com.

>James

I have some additional questions:

While on the "full" Linux operating system (on a PC), some type of agent
is installed and executed for me in that environment.  Where is this
agent coming from?  How is it being executed for me? To my knowledge, I
have never installed an agent or configured one.

I can't seem to find many agent interactions in the Bluez code -
although I find references to it.  Not surprisingly, the main agent
reference is in test/agent.c.

When I go to execute my project on my embedded device, there is no
agent.  From all other aspects that I am aware of, the other things
(dbus, bluez, etc) seem to be similar (my team has already tackled those
challenges - although some may still remain).

Is it possible that this agent is not included with the dbus that runs
on the embedded device, but is on the PC?  Does Gnome include this
agent?  Does it come from the bluetooth-applet?

Any and all comments welcome.  Thank you in advance.

Regards,

Scott Wilson

