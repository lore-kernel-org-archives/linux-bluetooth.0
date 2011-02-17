Return-Path: <cyrus@holtmann.org>
From: <sachin.athanikar@accenture.com>
To: <padovan@profusion.mobi>
CC: <linux-bluetooth@vger.kernel.org>
Date: Thu, 17 Feb 2011 20:10:38 +0530
Subject: RE: BUG in Mobile initiated pairing
Message-ID: <23B1B83C3513ED4B8E8B2B9029CDE8EFC938867886@INDXM3113.dir.svc.accenture.com>
References: <23B1B83C3513ED4B8E8B2B9029CDE8EFC9388671C2@INDXM3113.dir.svc.accenture.com>
 <20110217130322.GA10543@joana>
In-Reply-To: <20110217130322.GA10543@joana>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,
Many thanks for the response.

The property changed event "Paired" is not generated when the mobile initiated pairing is successful. So I am not able get an acknowledgement for successful completion of pairing process.

Thanks
Sachin

-----Original Message-----
From: Gustavo F. Padovan [mailto:pao@profusion.mobi] On Behalf Of Gustavo F. Padovan
Sent: Thursday, February 17, 2011 6:33 PM
To: Athanikar, Sachin
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: BUG in Mobile initiated pairing

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


This message is for the designated recipient only and may contain privileged, proprietary, or otherwise private information.  If you have received it in error, please notify the sender immediately and delete the original.  Any other use of the email by you is prohibited.
