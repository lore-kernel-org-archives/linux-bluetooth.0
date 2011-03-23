Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4D89E589.5010909@interlinx.bc.ca>
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
	<4D89DCE6.7050106@interlinx.bc.ca>
	<4D89E589.5010909@interlinx.bc.ca>
Date: Wed, 23 Mar 2011 10:24:43 -0600
Message-ID: <AANLkTimoiBMB0e2KrQVdPT8BjORs1PUECs0DXmxBFi8n@mail.gmail.com>
Subject: Re: how to set adapter to master with bluez 4.69?
From: Brad Midgley <bmidgley@gmail.com>
To: "Brian J. Murrell" <brian@interlinx.bc.ca>
Cc: Brad Midgley <bmidgley-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Brian,

My suggestion earlier about influencing connection order won't apply I
think because the esco is opened indirectly after some negotiation on
the acl connection.

You could try a different headset. I think it is unusual for it to
behave this way. I haven't played with multiple bt adapters, that
would fix it but there's the possibility for more complications.

-- 
Brad Midgley
