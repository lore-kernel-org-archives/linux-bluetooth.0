Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4D820B1D.1080903@interlinx.bc.ca>
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
	<AANLkTim2oLMjE-9C0G7VCjXafg03xnb7a0Q04zwKh2ns@mail.gmail.com>
	<4D820851.4040809@interlinx.bc.ca>
	<4D820B1D.1080903@interlinx.bc.ca>
Date: Thu, 17 Mar 2011 09:46:21 -0600
Message-ID: <AANLkTi=PMJtrWUZM6EmQSACbA9O++WKL4+5iaRBuTypK@mail.gmail.com>
Subject: Re: how to set adapter to master with bluez 4.69?
From: Brad Midgley <bmidgley@gmail.com>
To: "Brian J. Murrell" <brian@whamcloud.com>
Cc: linux-bluetooth@vger.kernel.org,
	Brad Midgley
	<public-bmidgley-Re5JQEeQqe8AvxtiuMwx3w-1dZseelyfdZg9hUCZPvPmw@public.gmane.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Brian,

> I wonder why it worked so well on my laptop and doesn't work so well on
> my PC?

I suspect it's because some adapters can deal with switching between
multiple piconets much more gracefully than others, but it could be
something else.

iirc, you should have accept in your link policy.

-- 
Brad Midgley
