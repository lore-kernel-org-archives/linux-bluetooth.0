Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120405225446.GA19517@samus>
References: <1333665653-30266-1-git-send-email-scott@netsplit.com>
	<1333665653-30266-3-git-send-email-scott@netsplit.com>
	<20120405225446.GA19517@samus>
Date: Fri, 6 Apr 2012 12:37:01 -0700
Message-ID: <CA+bD78hqiYahExdvsxnFB9mjZNz4Vh104=2_wN4=6TBxGvMRow@mail.gmail.com>
Subject: Re: [PATCHv3 2/4] plugin: Add bonding callback support for plugins
From: Scott James Remnant <scott@netsplit.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org, keybuk@chromium.org, marcel@holtmann.org,
	hadess@hadess.net
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Apr 5, 2012 at 3:54 PM, Vinicius Costa Gomes
<vinicius.gomes@openbossa.org> wrote:

> Hi Scott,
>
>> =A0 =A0 =A0 att_cleanup(device);
>>
>> + =A0 =A0 g_attrib_unref(device->attrib);
>> +
>
> This seems unrelated to your series.
>

Ah, good catch, looks like a rebase error; corrected patch to follow this m=
ail.

Scott
--=20
Have you ever, ever felt like this?
Had strange things happen? =A0Are you going round the twist?
