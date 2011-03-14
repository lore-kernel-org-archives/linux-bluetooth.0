Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4D7E211F.1030000@interlinx.bc.ca>
References: <4D6EF7ED.2090905@interlinx.bc.ca>
	<4D740AA7.5080209@interlinx.bc.ca>
	<AANLkTin3-+9txbUyFxyrirySnkjwWVeMHrZtCqGfz-4m@mail.gmail.com>
	<4D754A84.1020609@interlinx.bc.ca>
	<AANLkTimzHs1=z11GJ-ye10o_6PfoQ_R1RkDeS1jCVue2@mail.gmail.com>
	<AANLkTi=G2_hvZrZ=pG6naJ2fw7n4_T8=3+heV29vRPRD@mail.gmail.com>
	<4D7DF55D.2010402@interlinx.bc.ca>
	<4D7E0A15.5000708@interlinx.bc.ca>
	<4D7E211F.1030000@interlinx.bc.ca>
Date: Mon, 14 Mar 2011 09:29:02 -0600
Message-ID: <AANLkTi=N_5BaEOaaFsTHhNF82Vo83bzeNuzqmd9rMU3j@mail.gmail.com>
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

iirc, the hcitool output tells you the role of the local adapter in
the connection. So when you see 'master' in that list, it's what you
want. You should also be requesting master when you try hcitool.

Brad
