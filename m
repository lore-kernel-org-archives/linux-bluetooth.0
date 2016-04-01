Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1459443653.22297.7.camel@intelfx.name>
References: <1459443653.22297.7.camel@intelfx.name>
Date: Fri, 1 Apr 2016 12:31:03 +0300
Message-ID: <CABBYNZJe5FhhUqQTX89Soaig12ybWv90q7849jqVj2hrgxv5qw@mail.gmail.com>
Subject: Re: Fallout from commit 70fdb77 "audio/avrcp: Fix not always
 requesting capabilities"
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: intelfx@intelfx.name
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ivan,

On Thu, Mar 31, 2016 at 8:00 PM, Ivan Shapovalov <intelfx@intelfx.name> wrote:
> Hello,
>
> The commit 70fdb7 "audio/avrcp: Fix not always requesting capabilities"
> introduced a series of bugs where the code thinks that session-
>>controller->player cannot be NULL, but in fact it can be so. The first
> one was fixed in 177d27 "audio/avrcp: Fix crash when connecting to controllers", but there remain multiple code pathes via avrcp_register_notification() -> callback -> avrcp_handle_event() -> avrcp_{status,track,playback_pos,settings,uids}_changed() where session->controller->player may be dereferenced.
>
> I'm unsure how to fix that properly (either not register notifications,
> or ignore specific callbacks if s->c->player is NULL), so I'm just
> reporting this.
>
> Ref.: https://bugs.archlinux.org/task/48644

Ive just sent a patch to prevent the above to happen, it is very
uncommon that those event would be supported for a controller that
does not have player capabilities but indeed it could cause crashes.

-- 
Luiz Augusto von Dentz
