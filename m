Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <2722972.0T73ov4ygU@uw000953>
References: <1424355399-10015-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
	<1424355399-10015-3-git-send-email-grzegorz.kolodziejczyk@tieto.com>
	<2722972.0T73ov4ygU@uw000953>
Date: Thu, 26 Feb 2015 10:39:12 +0100
Message-ID: <CAMv5GbdhBtTdDGq5o9PM=xBBU6Ki_Xp6p52MP1p13D9RsscP7w@mail.gmail.com>
Subject: Re: [PATCH 3/6] profiles/network: Use send ctrl rsp to unknown BNEP
 ctrl cmd
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On 26 February 2015 at 10:37, Szymon Janc <szymon.janc@tieto.com> wrote:
>
> Hi Grzegorz,
>
> On Thursday 19 of February 2015 15:16:36 Grzegorz Kolodziejczyk wrote:
> > Use dedicated control response function instead of assembling and
> > sending raw packet over socket.
> > ---
> >  profiles/network/server.c | 12 ++++--------
> >  1 file changed, 4 insertions(+), 8 deletions(-)
> >
> > diff --git a/profiles/network/server.c b/profiles/network/server.c
> > index ebbe056..37bfba4 100644
> > --- a/profiles/network/server.c
> > +++ b/profiles/network/server.c
> > @@ -307,14 +307,10 @@ static gboolean bnep_setup(GIOChannel *chan,
> >       /* Highest known Control command ID
> >        * is BNEP_FILTER_MULT_ADDR_RSP = 0x06 */
> >       if (req->type == BNEP_CONTROL &&
> > -                             req->ctrl > BNEP_FILTER_MULT_ADDR_RSP) {
> > -             uint8_t pkt[3];
> > -
> > -             pkt[0] = BNEP_CONTROL;
> > -             pkt[1] = BNEP_CMD_NOT_UNDERSTOOD;
> > -             pkt[2] = req->ctrl;
> > -
> > -             send(sk, pkt, sizeof(pkt), 0);
> > +                                     req->ctrl > BNEP_FILTER_MULT_ADDR_RSP) {
> > +             error("cmd not understood");
> > +             bnep_send_ctrl_rsp(sk, BNEP_CONTROL, BNEP_CMD_NOT_UNDERSTOOD,
> > +                                                             req->ctrl);
> >
> >               return FALSE;
> >       }
>
> As discussed offline, this is not correct since we need to handle
> BNEP_CMD_NOT_UNDERSTOOD special case in bnep_send_ctrl_rsp.
>
Yes, I've prepared a patch since there is similar issue in pan android
profile code. Will rebase it.
>
> --
> Best regards,
> Szymon Janc

Best regards,
Grzegorz Kołodziejczyk
