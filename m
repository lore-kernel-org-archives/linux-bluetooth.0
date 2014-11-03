Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: 'Luiz Augusto von Dentz' <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	'Dmitry Kasatkin' <d.kasatkin@samsung.com>,
	'Bharat Panda' <bharat.panda@samsung.com>, cpgs@samsung.com
References: <1414768114-3775-1-git-send-email-gowtham.ab@samsung.com>
 <1414768114-3775-8-git-send-email-gowtham.ab@samsung.com>
 <CABBYNZJOur6QU0rzFQN8qWXC-T0iEBDQ7La9rOdrpb-c0Sz5Vw@mail.gmail.com>
 <000e01cff747$99350080$cb9f0180$@samsung.com>
 <CABBYNZ+N=2ZFWs_kKTzxDWo9OjjRPBgGXGqkwJK1akbYE0Fu3Q@mail.gmail.com>
In-reply-to: <CABBYNZ+N=2ZFWs_kKTzxDWo9OjjRPBgGXGqkwJK1akbYE0Fu3Q@mail.gmail.com>
Subject: RE: [PATCH v1 7/7] monitor/rfcomm: Add rfcomm file in Android.mk
Date: Mon, 03 Nov 2014 16:17:09 +0530
Message-id: <000f01cff753$9cde8a10$d69b9e30$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> -----Original Message-----
> From: Luiz Augusto von Dentz [mailto:luiz.dentz@gmail.com]
> Sent: Monday, November 03, 2014 3:41 PM
> To: Gowtham Anandha Babu
> Cc: linux-bluetooth@vger.kernel.org; Dmitry Kasatkin; Bharat Panda;
> cpgs@samsung.com
> Subject: Re: [PATCH v1 7/7] monitor/rfcomm: Add rfcomm file in Android.mk
> 
> Hi,
> 
> On Mon, Nov 3, 2014 at 11:21 AM, Gowtham Anandha Babu
> <gowtham.ab@samsung.com> wrote:
> > Hi,
> >
> >> -----Original Message-----
> >> From: Luiz Augusto von Dentz [mailto:luiz.dentz@gmail.com]
> >> Sent: Monday, November 03, 2014 2:35 PM
> >> To: Gowtham Anandha Babu
> >> Cc: linux-bluetooth@vger.kernel.org; Dmitry Kasatkin; Bharat Panda;
> >> cpgs@samsung.com
> >> Subject: Re: [PATCH v1 7/7] monitor/rfcomm: Add rfcomm file in
> >> Android.mk
> >>
> >> Hi,
> >>
> >> On Fri, Oct 31, 2014 at 5:08 PM, Gowtham Anandha Babu
> >> <gowtham.ab@samsung.com> wrote:
> >> > ---
> >> >  android/Android.mk | 1 +
> >> >  1 file changed, 1 insertion(+)
> >> >
> >> > diff --git a/android/Android.mk b/android/Android.mk index
> >> > aefe41c..eebd863 100644
> >> > --- a/android/Android.mk
> >> > +++ b/android/Android.mk
> >> > @@ -289,6 +289,7 @@ LOCAL_SRC_FILES := \
> >> >         bluez/monitor/packet.c \
> >> >         bluez/monitor/l2cap.c \
> >> >         bluez/monitor/avctp.c \
> >> > +       bluez/monitor/rfcomm.c \
> >> >         bluez/monitor/uuid.c \
> >> >         bluez/monitor/sdp.c \
> >> >         bluez/monitor/vendor.c \
> >> > --
> >> > 1.9.1
> >>
> >> Usually we try very hard to avoid breaking the build even within the
> >> same patch-set, so if possible please squash this change.
> >>
> >>
> >> --
> >> Luiz Augusto von Dentz
> >
> >
> > Do you want me to send this one(Android.mk) as a separate patch (out of
> this patch-set) or merge this one to first patch ?
> 
> Please merge, you can use git commit --squash/--fixup=<patch> and then git
> rebase --autosquash, there are actually many ways to do it.
> 
> --
> Luiz Augusto von Dentz

I have done the squash and git rebase and submitted the v1 for the same.

Regards,
Gowtham Anandha Babu

