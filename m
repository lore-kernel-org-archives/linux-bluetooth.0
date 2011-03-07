Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4D754A84.1020609@interlinx.bc.ca>
References: <4D6EF7ED.2090905@interlinx.bc.ca>
	<4D740AA7.5080209@interlinx.bc.ca>
	<AANLkTin3-+9txbUyFxyrirySnkjwWVeMHrZtCqGfz-4m@mail.gmail.com>
	<4D754A84.1020609@interlinx.bc.ca>
Date: Mon, 7 Mar 2011 16:09:12 -0700
Message-ID: <AANLkTimzHs1=z11GJ-ye10o_6PfoQ_R1RkDeS1jCVue2@mail.gmail.com>
Subject: Re: how to set adapter to master with bluez 4.69?
From: Brad Midgley <bmidgley@gmail.com>
To: "Brian J. Murrell" <brian@interlinx.bc.ca>
Cc: public-linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@plane.gmane.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>




Brian

> $ hcitool con
> Connections:
>        > ACL 00:1F:20:0F:30:6A handle 11 state 1 lm MASTER
>
> So it seems the mouse, which is the only remote device that's on, is master.
>
> When I try to change that I get:
>
> $ sudo hcitool sr 00:1F:20:0F:30:6A slave
> Switch role request failed: Input/output error

iirc, the remote device can deny a role switch. try the situation you
want, changing to master.

I think we can work this up. We need a new checkbox in bluez-gnome's
properties/general.c I think.

-- 
Brad Midgley


