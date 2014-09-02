Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: 'Luiz Augusto von Dentz' <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
References: <000001cfb169$e4d01bc0$ae705340$@samsung.com>
 <CABBYNZKTc7DYz5OSJOYm8uTDRzOOzfLMaOPGg-U7TTneaRiH_A@mail.gmail.com>
 <002101cfb550$afb1f400$0f15dc00$@samsung.com>
 <CABBYNZL5OBA6iNhzTkpKTmSEj+5R_oU5KLOAsFcK0ZDHvridMw@mail.gmail.com>
 <006d01cfc5e0$6b4df110$41e9d330$@samsung.com>
 <CABBYNZJnyVNyw2-odAPV621k-aiw8x83WNju7FZXW0=_5VUotw@mail.gmail.com>
In-reply-to: <CABBYNZJnyVNyw2-odAPV621k-aiw8x83WNju7FZXW0=_5VUotw@mail.gmail.com>
Subject: RE: Query regarding MAP 1.2 implementation
Date: Tue, 02 Sep 2014 10:52:52 +0530
Message-id: <000101cfc66e$00719660$0154c320$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Hi Luiz,

> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of Luiz Augusto von Dentz
> Sent: Monday, September 01, 2014 6:37 PM
> To: Gowtham Anandha Babu
> Cc: linux-bluetooth@vger.kernel.org; Bharat Panda
> Subject: Re: Query regarding MAP 1.2 implementation
> 
> Hi,
> 
> On Mon, Sep 1, 2014 at 3:29 PM, Gowtham Anandha Babu
> <gowtham.ab@samsung.com> wrote:
> 
> > The current message-dummy.c looks like, it is creating a virtual folder in the
> system (Ex. Home/PC-NAME/map-messages/).
> > So, I created the map-messages directory in home/PC-NAME/. Then I tried
> SETPATH (mentioned in the previous thread).
> > The output is...
> >
> >  obexd[29146]: obexd/src/obex.c:cmd_setpath()
> > obexd[29146]: SETPATH(0x5), (null)(0xffffffff)
> > obexd[29146]: obexd/src/obex.c:parse_name() NAME:
> > obexd[29146]: obexd/plugins/mas.c:mas_setpath() SETPATH: name
> nonhdr
> > 0x20
> > obexd[29146]: SETPATH(0x5), SUCCESS(0x20)
> >
> > But When I tried to call GetFolderListing() The output is...
> >
> > obexd[29146]: obexd/src/obex.c:cmd_get() session 0x1008c40
> > obexd[29146]: GET(0x3), (null)(0xffffffff)
> > obexd[29146]: obexd/src/obex.c:parse_type() TYPE:
> > x-obex/folder-listing
> > obexd[29146]: obexd/plugins/mas.c:mas_get() GET: name (null) type
> > x-obex/folder-listing mas 0x1015c00
> > obexd[29146]: obexd/plugins/mas.c:get_params() Error when parsing
> parameters!
> > obexd[29146]: GET(0x3), BAD_REQUEST(0x40)
> >
> > But I had few folders created inside the map-messages.
> 
> Bad request is normally when there is something wrong with the command
> itself, the error comes from here:
> 
> mas->inparams = g_obex_apparam_decode(buffer, size);
> if (mas->inparams == NULL) {
>     DBG("Error when parsing parameters!");
>     return -EBADR;
> }
> 
> I suspect the problem is that there is no application parameters set which is
> fine since all the parameters of GetFolderListing are optional, please try with
> the attached patch I will send it shortly as a proper patch to the mailing list.
> 
> 
> --
> Luiz Augusto von Dentz


I applied the patch which was attached in the previous reply. Still I am getting the same error. 
I tried printing the "size" inside the get_params function. Its value is '0' for GetFolderListing request.
If size=0, then g_obex_apparam_decode()  function always return NULL, which leads to "Error when parsing parameters!".

Regards,
Gowtham

