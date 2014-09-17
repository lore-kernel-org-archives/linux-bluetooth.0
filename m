Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <001101cfd264$1c5a3470$550e9d50$@samsung.com>
References: <1410871803-31373-1-git-send-email-gowtham.ab@samsung.com>
	<CABBYNZLNfm+z_GyPnHvxiUG+pZmpY6QoBrm62LFYENiKx9B=Sg@mail.gmail.com>
	<001101cfd264$1c5a3470$550e9d50$@samsung.com>
Date: Wed, 17 Sep 2014 16:28:23 +0300
Message-ID: <CABBYNZKTGtxy8nzWU6xWiggpmymBNURyRJ+KXUjqey9Aw3O8Mw@mail.gmail.com>
Subject: Re: [MAP v4] obexd/client : Handle the MAP Event Report 1.1
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Gowtham Anandha Babu <gowtham.ab@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Dmitry Kasatkin <d.kasatkin@samsung.com>,
	Bharat Panda <bharat.panda@samsung.com>, cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Sep 17, 2014 at 1:42 PM, Gowtham Anandha Babu
<gowtham.ab@samsung.com> wrote:
> Regarding the implementation of the ReadStatusChanged event:
>
> As per the specification: Pg.no : 35 on MAP 1.2 spec
> "ReadStatusChanged: indicates that the 'read' status of a message (see 3.1.6) has been changed on the MSE. "
>
> But the actual Event Report which was provided as test case in PTS tool was:
>
> <MAP-event-report version = "1.1">
> <event type = "ReadStatusChanged" handle = "12345678" folder = "TELECOM/MSG/INBOX" msg_type = "SMS_CDMA" subject = "Hello" datetime = "20110221T130510" sender_name = "Jamie" priority = "yes" />
> </MAP-event-report>
>
> From the above event report 1.1, we cannot retrieve the read status of a message. But we need update the read status in MCE.
>
> For SMS,MMS - Only way the read status can change is from unread to read.
> For Email - Here the read status can change from read to unread and vice versa.
> So, we need to  toggle the read status, whenever we get the ReadstatusChanged event.
> Implementation of the ReadStatusChanged event handler in "obexd/client/map" is shown below:
>
> static void map_handle_read_status_changed(struct map_data *map, struct  map_event *event)
>  {
>         struct map_msg *msg;
>         msg = g_hash_table_lookup(map->messages, &event->handle);
>         if (msg == NULL)
>                 return;
>         if(msg->flags & MAP_MSG_FLAG_READ)
>                 parse_read(msg,"no");
>         else
>                 parse_read(msg,"yes");
>  }
>
> What is your suggestion?

I think this is the case of filing an issue to PTS to get the
information, if the read status can change back and forth the event
should contain the current value or they should clarify in the spec
that this event works by toggling, in fact none of the attributes it
is sending would change but the one that is actually changing is
omitted so perhaps that is not really the intention.

You can file the issue here (requires login):
https://www.bluetooth.org/pts/issues/add_issue.cfm

-- 
Luiz Augusto von Dentz
