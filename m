Return-Path: <cyrus@holtmann.org>
Date: Tue, 24 Jan 2012 12:46:23 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] Fix memory leak when loading keys
Message-ID: <20120124104623.GA26322@x220>
References: <20120123132915.GA2879@samus>
 <1327364511-6348-1-git-send-email-vinicius.gomes@openbossa.org>
 <CAJdJm_N+FXcJfXm_1eEmjJUp0c4Ek2OL3gJrSnRyfjmoCPNG5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAJdJm_N+FXcJfXm_1eEmjJUp0c4Ek2OL3gJrSnRyfjmoCPNG5A@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Tue, Jan 24, 2012, Anderson Lizardo wrote:
> On Mon, Jan 23, 2012 at 8:21 PM, Vinicius Costa Gomes
> <vinicius.gomes@openbossa.org> wrote:
> > @@ -3570,7 +3571,16 @@ static int hciops_load_keys(int index, GSList *keys, gboolean debug_keys)
> >        if (dev->keys != NULL)
> >                return -EEXIST;
> >
> > -       dev->keys = keys;
> > +       for (l = keys; l; l = l->next) {
> > +               struct link_key_info *orig, *dup;
> > +
> > +               orig = l->data;
> > +
> > +               dup = g_memdup(orig, sizeof(*orig));
> > +
> > +               dev->keys = g_slist_prepend(dev->keys, dup);
> > +       }
> > +
> 
> No need to cleanup dev->keys first?

Take a look at the first two lines of context. The function bails out if
dev->keys is anything else than NULL.

Johan
