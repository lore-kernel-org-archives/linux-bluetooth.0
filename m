Return-Path: <cyrus@holtmann.org>
Date: Mon, 3 Oct 2011 19:43:54 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 2/2] Fix possible crash when player is destroyed
Message-ID: <20111003164354.GB3369@fusion.localdomain>
References: <1317653871-14689-1-git-send-email-luiz.dentz@gmail.com>
 <1317653871-14689-2-git-send-email-luiz.dentz@gmail.com>
 <CABBYNZ+hOfQu95QHv9khAj4gO6T584m=WWuiLbG3j6frS8vyJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CABBYNZ+hOfQu95QHv9khAj4gO6T584m=WWuiLbG3j6frS8vyJw@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Mon, Oct 03, 2011, Luiz Augusto von Dentz wrote:
> On Mon, Oct 3, 2011 at 5:57 PM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >
> > When player is unregistered/destroyed its pdu handler should also be
> > removed.
> > ---
> >  audio/avrcp.c |    3 +++
> >  1 files changed, 3 insertions(+), 0 deletions(-)
> >
> > diff --git a/audio/avrcp.c b/audio/avrcp.c
> > index 5aa8dc5..9a73ff4 100644
> > --- a/audio/avrcp.c
> > +++ b/audio/avrcp.c
> > @@ -1101,6 +1101,9 @@ static void player_destroy(gpointer data)
> >        if (player->destroy)
> >                player->destroy(player->user_data);
> >
> > +       if (player->handler)
> > +               avctp_unregister_pdu_handler(player->handler);
> > +
> >        g_free(player);
> >  }
> >
> > --
> > 1.7.6.2
> 
> Please skip this since player_destroy is not even upstream yet.

Ok. The first patch has anyway been pushed upstream.

Johan
