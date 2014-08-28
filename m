Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: 'Luiz Augusto von Dentz' <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
References: <1409204803-3705-1-git-send-email-gowtham.ab@samsung.com>
 <CABBYNZJaruAHM3sAg6msQyvgGj=_+CehXmEmGzOt4gjE_b+10w@mail.gmail.com>
 <000001cfc2a0$0032aa30$0097fe90$@samsung.com>
 <CABBYNZLZj-+et7M7eXncm=YdkCx7H_GfYKuLBc49OFKHm6JP4Q@mail.gmail.com>
In-reply-to: <CABBYNZLZj-+et7M7eXncm=YdkCx7H_GfYKuLBc49OFKHm6JP4Q@mail.gmail.com>
Subject: RE: [MAP] obexd/client: Handle MAP event types
Date: Thu, 28 Aug 2014 19:02:37 +0530
Message-id: <000401cfc2c4$98e75630$cab60290$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> -----Original Message-----
> From: Luiz Augusto von Dentz [mailto:luiz.dentz@gmail.com]
> Sent: Thursday, August 28, 2014 3:16 PM
> To: Gowtham Anandha Babu
> Cc: linux-bluetooth@vger.kernel.org
> Subject: Re: [MAP] obexd/client: Handle MAP event types
> 
> Hi,
> 
> On Thu, Aug 28, 2014 at 12:11 PM, Gowtham Anandha Babu
> <gowtham.ab@samsung.com> wrote:
> > Hi Luiz,
> >     But in the obexd/client/mns.c
> >     Inside parse_event_report_type() function, event types are assigned
> with the values MAP_ET_MEMORY_FULL and
> MAP_ET_MEMORY_AVAILABLE.
> >     It should be handled in the map_handle_notification() inside map.c.
> 
> Please do not top post in the mailing list, use inline posting.
> Regarding the parsing, yes it does have proper handling of those event but
> there is no mapping to the D-Bus API therefore we ignore those memory
> event. As I mentioned the they are not per message so they cannot be set as
> a status of a message, anyway it would not make sense, and having it on the
> MessageAccess interface has not been considered but first I need to have a
> proper user case where it makes sense to expose those events.
> 
> Luiz Augusto von Dentz


The use cases are:
1) What if one tries to push a message, but the space available in the MSE device is not enough. So MCE will receive Memory Full Event.
2) Once the user cleared some memory in the MSE device, MCE should be notified with Memory Available Event.
As you mentioned earlier, these cannot be set as a status of a message. But MCE device needs to be get notified about this events. 

If the MCE receives Memory Full event, it will set the status as "delivery-failure". 
Once MSE device(server)  deletes some messages and send Memory Available event then MCE will push the pending message. 
Can it be done like this?

Regards,
Gowtham


