Return-Path: <cyrus@holtmann.org>
Date: Wed, 24 Apr 2013 15:19:53 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [RFC 1/2] gdbus: Add g_dbus_flush_properties()
Message-ID: <20130424181953.GA20988@samus>
References: <1366307424-19825-1-git-send-email-vinicius.gomes@openbossa.org>
 <CABBYNZJFT18e172brOH1QR2WCrZWEkxUsw3vwp8YDKCsYvRPQw@mail.gmail.com>
 <20130419133459.GA7044@echo>
 <20130424135855.GA18679@x220>
 <CAMOw1v5ef6Uwx5t32pMhzzb4gurLuf+K9-iXJmgfdyCAGH+Wjg@mail.gmail.com>
 <20130424175650.GD11434@samus>
 <CAMOw1v5jGPnmukDOjdGGUZ3k=aJqvyx97mw4Uk0owt=5K3ApfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAMOw1v5jGPnmukDOjdGGUZ3k=aJqvyx97mw4Uk0owt=5K3ApfA@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On 15:09 Wed 24 Apr, Lucas De Marchi wrote:

[snip]


> 
> if "Paired" is marked as IMMEDIATE, this would work fine:
> 
> g_dbus_emit_property_changed(conn, path, iface, "Paired");
> dbus_message_send_with_reply(conn, msg, &pending, -1);
> 
> 
> All properties set until now would be sent, and then the call to
> NewConnection().

Ah, I see. I was thinking that only that property would be send at that point,
if all the pending properties are sent, I am fine with this.

> 
> Lucas De Marchi

Cheers,
-- 
Vinicius
