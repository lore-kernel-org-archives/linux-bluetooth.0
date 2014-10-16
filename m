Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: 'Luiz Augusto von Dentz' <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	'Dmitry Kasatkin' <d.kasatkin@samsung.com>,
	'Bharat Panda' <bharat.panda@samsung.com>, cpgs@samsung.com
References: <1413382102-4049-1-git-send-email-gowtham.ab@samsung.com>
 <CABBYNZKe1=awjhj2XttF+7gyHaw8f5zWftL=p1wrf+HWMUefMQ@mail.gmail.com>
In-reply-to: <CABBYNZKe1=awjhj2XttF+7gyHaw8f5zWftL=p1wrf+HWMUefMQ@mail.gmail.com>
Subject: RE: [PATCH 1/4] tools/csr_usb : Fix Resource leak: file
Date: Thu, 16 Oct 2014 14:27:56 +0530
Message-id: <000601cfe91f$4894c100$d9be4300$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> -----Original Message-----
> From: Luiz Augusto von Dentz [mailto:luiz.dentz@gmail.com]
> Sent: Thursday, October 16, 2014 1:48 PM
> To: Gowtham Anandha Babu
> Cc: linux-bluetooth@vger.kernel.org; Dmitry Kasatkin; Bharat Panda;
> cpgs@samsung.com
> Subject: Re: [PATCH 1/4] tools/csr_usb : Fix Resource leak: file
> 
> Hi,
> 
> On Wed, Oct 15, 2014 at 5:08 PM, Gowtham Anandha Babu
> <gowtham.ab@samsung.com> wrote:
> > Handles resource leak.
> > ---
> >  tools/csr_usb.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/csr_usb.c b/tools/csr_usb.c index 5fb6bdc..a1d7324
> > 100644
> > --- a/tools/csr_usb.c
> > +++ b/tools/csr_usb.c
> > @@ -80,9 +80,12 @@ static int read_value(const char *name, const char
> *attr, const char *format)
> >                 return -1;
> >
> >         n = fscanf(file, format, &value);
> > -       if (n != 1)
> > +       if (n != 1) {
> > +               fclose(file);
> >                 return -1;
> > +       }
> >
> > +       fclose(file);
> >         return value;
> >  }
> >
> > --
> > 1.9.1
> 
> Applied 1-3, but note that I did some changes in the commit message, please
> be consistent and don't include things like space before ':'
> etc, it is always a good practice got look how previous commit have been
> formatted and follow the HACKING document.
> 
> 
> --
> Luiz Augusto von Dentz

Sorry for the formatting errors and 50/72 format. I will follow the HACKING documents here after.
Thanks !

Regards, 
Gowtham Anandha Babu

