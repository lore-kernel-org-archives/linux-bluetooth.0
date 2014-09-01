Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: 'Luiz Augusto von Dentz' <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, bharat.panda@samsung.com
References: <000001cfb169$e4d01bc0$ae705340$@samsung.com>
 <CABBYNZKTc7DYz5OSJOYm8uTDRzOOzfLMaOPGg-U7TTneaRiH_A@mail.gmail.com>
 <002101cfb550$afb1f400$0f15dc00$@samsung.com>
 <CABBYNZL5OBA6iNhzTkpKTmSEj+5R_oU5KLOAsFcK0ZDHvridMw@mail.gmail.com>
In-reply-to: <CABBYNZL5OBA6iNhzTkpKTmSEj+5R_oU5KLOAsFcK0ZDHvridMw@mail.gmail.com>
Subject: RE: Query regarding MAP 1.2 implementation
Date: Mon, 01 Sep 2014 17:59:15 +0530
Message-id: <006d01cfc5e0$6b4df110$41e9d330$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> -----Original Message-----
> From: Luiz Augusto von Dentz [mailto:luiz.dentz@gmail.com]
> Sent: Monday, August 11, 2014 4:39 PM
> To: Gowtham Anandha Babu
> Subject: Re: Query regarding MAP 1.2 implementation
> 
> Hi,
> 
> Well you can start over a new implementation, in fact that was what I suggest
> but first we need to agree on the D-Bus API which I expect you guys have
> something in mind since Tizen backend did use D-Bus in its backend if Im not
> mistaken, I have no idea about the Tizen solution really so I guess you will
> need to figure it out if you want to reuse its code or not but there will be
> changes to the interface thus my suggestion to start with the API definition.
> 
> On Mon, Aug 11, 2014 at 1:40 PM, Gowtham Anandha Babu
> <gowtham.ab@samsung.com> wrote:
> > Hi Luiz,
> > Backend implementation for message database in tizen is showing so many
> dependencies while setting up.
> > When I am trying to install/Make map-agent, its is giving me "package vconf
> not found" error.
> > When I am trying to install/Make vconf, its giving me some other packages
> not found error.
> > It goes on.
> >  Is there any other way/procedure to implement the backend message
> database for MAS?
> >
> > -----Original Message-----
> > From: linux-bluetooth-owner@vger.kernel.org
> > [mailto:linux-bluetooth-owner@vger.kernel.org] On Behalf Of Luiz
> > Augusto von Dentz
> > Sent: Wednesday, August 06, 2014 5:33 PM
> > To: Gowtham Anandha Babu
> > Cc: linux-bluetooth@vger.kernel.org; Bharat Panda
> > Subject: Re: Query regarding MAP 1.2 implementation
> >
> > Hi,
> >
> > On Wed, Aug 6, 2014 at 2:30 PM, Gowtham Anandha Babu
> <gowtham.ab@samsung.com> wrote:
> >> Hi All,
> >>
> >> I am currently working on MAP implementation in BlueZ.
> >> I am trying below things to make MAS connect with remote MCE client.
> >>
> >> Below are the steps we followed;
> >>
> >> On MCE device:
> >> --> MAS search
> >> --> MAS connect
> >> --> SET PATH (/)
> >>
> >> On Bluez, obexd:
> >> --> Run "bluetoothd"
> >> --> Run "obexd"
> >> --> On SET_PATH command it sends the obex session value as NULL.
> >>
> >>
> >> obexd[32713]: obexd/plugins/bluetooth.c:profile_new_connection()
> >> device /org/bluez/hci0/dev_00_1B_DC_07_33_4E
> >> obexd[32713]: obexd/src/obex.c:obex_session_start()
> >> obexd[32713]: obexd/src/obex.c:cmd_connect()
> >> obexd[32713]: CONNECT(0x0), (null)(0xffffffff)
> >> obexd[32713]: obexd/src/obex.c:cmd_connect() Selected driver:
> Message
> >> Access server
> >> obexd[32713]: obexd/plugins/mas.c:mas_connect()
> >> obexd[32713]: CONNECT(0x0), (null)(0x0)
> >> obexd[32713]: obexd/src/obex.c:cmd_setpath()
> >> obexd[32713]: obexd/src/obex.c:cmd_setpath() (null)
> >> obexd[32713]: SETPATH(0x5), (null)(0xffffffff)
> >> obexd[32713]: obexd/src/obex.c:parse_name() NAME:
> >> obexd[32713]: obexd/plugins/mas.c:mas_setpath() SETPATH: name
> nonhdr
> >> 0x20
> >> obexd[32713]: SETPATH(0x5), NOT_FOUND(0x44)
> >>
> >> Do we need to configure or run anything else before starting up obexd?
> >
> > You are probably missing a backend implementation for your message
> database, currently we are building with dummy as backend but the idea is
> that we switch to a runtime solution probably we a D-Bus agent interface to
> interact with these requests using a file descriptor to optimize the data
> transfer. iirc samsung has done a D-Bus backend for BlueZ 4 in Tizen perhaps
> you can star by looking what kind of interface is there.
> >
> >
> > --
> > Luiz Augusto von Dentz
> > --
> > To unsubscribe from this list: send the line "unsubscribe
> > linux-bluetooth" in the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> 
> 
> 
> --
> Luiz Augusto von Dentz

The current message-dummy.c looks like, it is creating a virtual folder in the system (Ex. Home/PC-NAME/map-messages/). 
So, I created the map-messages directory in home/PC-NAME/. Then I tried SETPATH (mentioned in the previous thread).
The output is...

 obexd[29146]: obexd/src/obex.c:cmd_setpath() 
obexd[29146]: SETPATH(0x5), (null)(0xffffffff)
obexd[29146]: obexd/src/obex.c:parse_name() NAME: 
obexd[29146]: obexd/plugins/mas.c:mas_setpath() SETPATH: name  nonhdr 0x20
obexd[29146]: SETPATH(0x5), SUCCESS(0x20)

But When I tried to call GetFolderListing()
The output is...

obexd[29146]: obexd/src/obex.c:cmd_get() session 0x1008c40
obexd[29146]: GET(0x3), (null)(0xffffffff)
obexd[29146]: obexd/src/obex.c:parse_type() TYPE: x-obex/folder-listing
obexd[29146]: obexd/plugins/mas.c:mas_get() GET: name (null) type x-obex/folder-listing mas 0x1015c00
obexd[29146]: obexd/plugins/mas.c:get_params() Error when parsing parameters!
obexd[29146]: GET(0x3), BAD_REQUEST(0x40) 

But I had few folders created inside the map-messages. 

Regards,
Gowtham Anandha Babu

