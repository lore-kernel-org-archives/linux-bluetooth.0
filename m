Return-Path: <cyrus@holtmann.org>
Date: Thu, 17 Feb 2011 10:03:22 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: sachin.athanikar@accenture.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: BUG in Mobile initiated pairing
Message-ID: <20110217130322.GA10543@joana>
References: <23B1B83C3513ED4B8E8B2B9029CDE8EFC9388671C2@INDXM3113.dir.svc.accenture.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <23B1B83C3513ED4B8E8B2B9029CDE8EFC9388671C2@INDXM3113.dir.svc.accenture.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

HI Sachin,

* sachin.athanikar@accenture.com <sachin.athanikar@accenture.com> [2011-02-17 14:17:47 +0530]:

> Hi Gustavo,
> 
> I have a question on pairing.
> 
> Is standard pairing working fine in BlueZ with all necessary events being generated?
> 
> I am using blueZ 4.88 on Ubuntu 10.10.
> 
> Adapter initiated pairing:
> -------------------------
> I am using agent.c which is part of test folder of BlueZ code base.
> Agent.c is used for adapter initiated pairing where I am able to get the response and event from BlueZ (observed in DBUS monitor).
> 
> 
> Mobile Phone initiated pairing:
> ------------------------------------------
> I have modified the agent.c in test folder of BlueZ to accept the mobile initiated pairing request.
> 
> When the pairing is initiated from Mobile phone, after the successful pairing, the property changed event for "Paired" is not generated. And even the agent is not released.

The "Paired" is generated, and not releasing the agent is the usual behaviour
for this case.

-- 
Gustavo F. Padovan
http://profusion.mobi
