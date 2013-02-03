Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20130203185107.0dcdfc4271d63c9e5403d697@studenti.unina.it>
References: <1359908071-15024-1-git-send-email-ospite@studenti.unina.it>
	<1359908071-15024-3-git-send-email-ospite@studenti.unina.it>
	<CAJdJm_OFBu_gtgBz8+RFSS8cDVbtVH9DfuRtnimOd8auh8zDgw@mail.gmail.com>
	<20130203185107.0dcdfc4271d63c9e5403d697@studenti.unina.it>
Date: Sun, 3 Feb 2013 14:27:26 -0400
Message-ID: <CAJdJm_N-XocJ6Pj1zo5Duk+NaC3VH3jvHC1XTf+wcb2bS183pw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/2] device: use device_set_trusted() in set_trust()
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Antonio,

On Sun, Feb 3, 2013 at 1:51 PM, Antonio Ospite <ospite@studenti.unina.it> wrote:
> The logic is equivalent to the previous one, as device_set_trusted()
> returns without doing anything when (device->trusted == trusted), and
> the previous implementation was already calling
> g_dbus_pending_property_success() just before returning in any exit
> path. Or was it meant to be g_dbus_pending_property_error() in the
> first exit path? I don't know about that.

My mistake. I incorrectly read the diff. And I think the _success()
function is correct as it is.

>
> The previous set_trust() code didn't consider the !device case so we
> should be OK if this function assumes the device is always defined.
>
> If the code is OK I can improve the commit message, yes.

Having more text on the commit message is always better than less text
:). But in this case, the commit is quite simple, so it is up to
you/Johan/Marcel.

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
