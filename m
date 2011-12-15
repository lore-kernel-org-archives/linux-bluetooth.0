Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAKT1EBf+YPUggU6FX1EJjCtF7_C3zXCpwq=hG6Q+6DKyEo0=_A@mail.gmail.com>
References: <CACj007n47KuT4uzJMDnHc2KKy_Mog469QvvrRm5mAE54Q6Y7Ug@mail.gmail.com>
	<CAJdJm_OnyeExrgvainhqPMUgV9C2QU08PafyXZa9-oJxgkEaEg@mail.gmail.com>
	<CAKT1EBf+YPUggU6FX1EJjCtF7_C3zXCpwq=hG6Q+6DKyEo0=_A@mail.gmail.com>
Date: Thu, 15 Dec 2011 10:40:02 -0400
Message-ID: <CAJdJm_M1VCjHpyZXAPmLH6VDxLdDOUjZj9_SGhfUNNdrKDih3Q@mail.gmail.com>
Subject: Re: [RFC BlueZ]Proximity Monitor: Immediate Alert Timeout
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: Hemant Gupta <hemantgupta.ste@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Wed, Dec 14, 2011 at 12:46 PM, Claudio Takahasi
<claudio.takahasi@openbossa.org> wrote:
> Removing the timeout and write to "none" has a side effect: the remote
> and the local value can have different values if the remote changes
> the value. Alert Level characteristic doesn't support read,
> notification or indication. Probably, all devices disable the alert
> after some seconds to avoid drain the battery or be annoying.
> The main problem is consistency: show to the user the correct value.

In this case, I think the ImmediateAlertLevel should be write only
(not readable). This forces applications to always write the level
they want the peer device to alert. It means some spurious ATT write
commands, but I think the spec assumes this is the case (otherwise it
would allow read or notify).

The problem is: is there such thing as "write only property" in BlueZ?

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
