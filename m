Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAHZ1yCk593aNDzLAjb3RjoTehYaZgm5BxAnKQQwSY_9Md76+8g@mail.gmail.com>
References: <1399472233-19056-1-git-send-email-lukasz.rymanowski@tieto.com>
	<1399472233-19056-2-git-send-email-lukasz.rymanowski@tieto.com>
	<CAHZ1yCk593aNDzLAjb3RjoTehYaZgm5BxAnKQQwSY_9Md76+8g@mail.gmail.com>
Date: Thu, 8 May 2014 12:16:14 +0200
Message-ID: <CAN_7+Yb9=do88XBg9Cw0sUHceQ2b=q9VtAjAqvzJ9NSE17AqOw@mail.gmail.com>
Subject: Re: [PATCH 2/2] doc: Introduce Start/Stop Connection Monitor
From: Lukasz Rymanowski <lukasz.rymanowski@gmail.com>
To: Scott James Remnant <keybuk@google.com>
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Szymon Janc <szymon.janc@tieto.com>,
	Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Scott,

On Wed, May 7, 2014 at 8:15 PM, Scott James Remnant <keybuk@google.com> wrote:
> On Wed, May 7, 2014 at 7:17 AM, Lukasz Rymanowski
> <lukasz.rymanowski@tieto.com> wrote:
>> This patch introduce device method to start and stop connection monitor
>> and two new device properties ConnectionRSSI and ConnectionTXPower which
>> are tracked when monitor is active
>
> Does a polling API like this make more sense than just an "Update
> Connection Properties" method call?
>

IMHO DBus is to heavy for polling methods.
I planned to have interval value for this Monitor in config file so
user can adjust it depends on needs.

> Why make new properties? The existing RSSI property could be re-used
> without confusion, likewise the TXPower property could be called just
> that - which would then give a place to fill in the TX Power if
> present in AD as well.
>
TXPower for AD is different than TXPower on the connection. Same thing
with RSSI  - so I would keep separate properties for that.

> Scott
> --
> Scott James Remnant | Chrome OS Systems | keybuk@google.com | Google
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

BR
Lukasz
