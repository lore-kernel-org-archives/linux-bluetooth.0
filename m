Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: 'Luiz Augusto von Dentz' <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	'Dmitry Kasatkin' <d.kasatkin@samsung.com>,
	'Bharat Panda' <bharat.panda@samsung.com>, cpgs@samsung.com
References: <1412654816-14971-1-git-send-email-gowtham.ab@samsung.com>
 <CABBYNZ+GQ7ffqVnpTKVBZ02_5bqQoPhjz7Ue+ELpfCKGLZF0kg@mail.gmail.com>
In-reply-to: <CABBYNZ+GQ7ffqVnpTKVBZ02_5bqQoPhjz7Ue+ELpfCKGLZF0kg@mail.gmail.com>
Subject: RE: [PATCH 0/6] Add support for MAP MASInstance feature
Date: Wed, 08 Oct 2014 17:38:41 +0530
Message-id: <001801cfe2f0$a04fda90$e0ef8fb0$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> -----Original Message-----
> From: Luiz Augusto von Dentz [mailto:luiz.dentz@gmail.com]
> Sent: Wednesday, October 08, 2014 4:09 PM
> To: Gowtham Anandha Babu
> Cc: linux-bluetooth@vger.kernel.org; Dmitry Kasatkin; Bharat Panda;
> cpgs@samsung.com
> Subject: Re: [PATCH 0/6] Add support for MAP MASInstance feature
> 
> Hi,
> 
> On Tue, Oct 7, 2014 at 7:06 AM, Gowtham Anandha Babu
> <gowtham.ab@samsung.com> wrote:
> > This patch-set implements MAP 1.2 MAS Instance feature.
> >
> > The patch 1,2,3 will handle the Client part(MCE). It passes the PTS
> > 5.3 test case:TC_MCE_MMI_BV_01_I.
> >
> > The patch 4,5,6 will handle the Server part(MSE). It passes the PTS
> > 5.3 test case:TC_MSE_MMI_BV_02_I.
> >
> > Gowtham Anandha Babu (6):
> >   doc/obex-api: Add description about MASInstance request
> >   test/map-client: Add D-Bus API support to make MASInstance request
> >   obexd/client/map: Add API Calls for request and handlers for response
> >   obexd/mas: Add support for providing MASInstance Info as response
> >   obexd/messages: Add prototypes for MASInstance response
> >   obexd/message-dummy: Add MAS Instance description to response
> >
> >  doc/obex-api.txt               |  6 +++
> >  obexd/client/map.c             | 88
> ++++++++++++++++++++++++++++++++++++++++++
> >  obexd/plugins/mas.c            | 62 +++++++++++++++++++++++++++++
> >  obexd/plugins/messages-dummy.c | 18 +++++++++
> >  obexd/plugins/messages.h       | 16 ++++++++
> >  test/map-client                |  9 +++++
> >  6 files changed, 199 insertions(+)
> >
> > --
> > 1.9.1
> 
> My plan is to actually do this as the name of the folder for each instance:
> 
> <MAS 1 info>/telecom/...
> <MAS 2 info>/telecom/...
> 
> If there is no info, due to version or lack of support, then we fallback to
> record description or something like that so we can support multiple
> instances.
> 
> 
> --
> Luiz Augusto von Dentz

I could not understand the first part of your explanation. 
Do we need to create any folders internally and store the MAS info?
Or do we need to append the below info to MAS Info? 
<MAS 1 info>/telecom/...
<MAS 2 info>/telecom/... 

Let me know if I am wrong. 
And then do we need to follow any predefined structure for storing the MAS Instance Info?
I think right now bluez supports single MAS instance. This patch will work for single instance. For supporting multiple MAS instances, we need to discuss upon the how this can be implemented?

Regards,
Gowtham Anandha Babu


