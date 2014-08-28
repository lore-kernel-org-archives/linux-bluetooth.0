Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <000001cfc2a0$0032aa30$0097fe90$@samsung.com>
References: <1409204803-3705-1-git-send-email-gowtham.ab@samsung.com>
	<CABBYNZJaruAHM3sAg6msQyvgGj=_+CehXmEmGzOt4gjE_b+10w@mail.gmail.com>
	<000001cfc2a0$0032aa30$0097fe90$@samsung.com>
Date: Thu, 28 Aug 2014 12:46:07 +0300
Message-ID: <CABBYNZLZj-+et7M7eXncm=YdkCx7H_GfYKuLBc49OFKHm6JP4Q@mail.gmail.com>
Subject: Re: [MAP] obexd/client: Handle MAP event types
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Gowtham Anandha Babu <gowtham.ab@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Aug 28, 2014 at 12:11 PM, Gowtham Anandha Babu
<gowtham.ab@samsung.com> wrote:
> Hi Luiz,
>     But in the obexd/client/mns.c
>     Inside parse_event_report_type() function, event types are assigned with the values MAP_ET_MEMORY_FULL and MAP_ET_MEMORY_AVAILABLE.
>     It should be handled in the map_handle_notification() inside map.c.

Please do not top post in the mailing list, use inline posting.
Regarding the parsing, yes it does have proper handling of those event
but there is no mapping to the D-Bus API therefore we ignore those
memory event. As I mentioned the they are not per message so they
cannot be set as a status of a message, anyway it would not make
sense, and having it on the MessageAccess interface has not been
considered but first I need to have a proper user case where it makes
sense to expose those events.

Luiz Augusto von Dentz
