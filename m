Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4D7F5EF2.2000709@interlinx.bc.ca>
References: <4D6EF7ED.2090905@interlinx.bc.ca>
	<4D740AA7.5080209@interlinx.bc.ca>
	<AANLkTin3-+9txbUyFxyrirySnkjwWVeMHrZtCqGfz-4m@mail.gmail.com>
	<4D754A84.1020609@interlinx.bc.ca>
	<AANLkTimzHs1=z11GJ-ye10o_6PfoQ_R1RkDeS1jCVue2@mail.gmail.com>
	<AANLkTi=G2_hvZrZ=pG6naJ2fw7n4_T8=3+heV29vRPRD@mail.gmail.com>
	<4D7DF55D.2010402@interlinx.bc.ca>
	<4D7E0A15.5000708@interlinx.bc.ca>
	<4D7E211F.1030000@interlinx.bc.ca>
	<AANLkTi=N_5BaEOaaFsTHhNF82Vo83bzeNuzqmd9rMU3j@mail.gmail.com>
	<4D7F5AE3.20909@interlinx.bc.ca>
	<4D7F5EF2.2000709@interlinx.bc.ca>
Date: Tue, 15 Mar 2011 09:25:35 -0600
Message-ID: <AANLkTim2oLMjE-9C0G7VCjXafg03xnb7a0Q04zwKh2ns@mail.gmail.com>
Subject: Re: how to set adapter to master with bluez 4.69?
From: Brad Midgley <bmidgley@gmail.com>
To: "Brian J. Murrell" <brian@interlinx.bc.ca>
Cc: linux-bluetooth@vger.kernel.org,
	Brad Midgley
	<public-bmidgley-Re5JQEeQqe8AvxtiuMwx3w-1dZseelyfdZg9hUCZPvPmw@public.gmane.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Brian,

You can have both master and slave connections simultaneously, just
like you can be slave to more than one master. In both cases it means
your adapter is in different piconets.

There are rules about whether devices can refuse the master/slave
switch. It's been some time since I read this so I can't remember, but
maybe it's the initiating device that starts out as slave and the
remote device has to agree to a role switch. So you should be able to
force the headset to cooperate, even if it's refusing role switches,
by changing who initiates that connection in addition to a link policy
that keeps your adapter as master.

Brad
