Return-Path: <cyrus@holtmann.org>
Date: Mon, 23 Jan 2012 10:29:15 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v2 3/4] Fix memory leak when loading keys
Message-ID: <20120123132915.GA2879@samus>
References: <1326928412-25910-1-git-send-email-vinicius.gomes@openbossa.org>
 <1326928412-25910-3-git-send-email-vinicius.gomes@openbossa.org>
 <20120123111205.GE13100@x220>
MIME-Version: 1.0
In-Reply-To: <20120123111205.GE13100@x220>
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On 13:12 Mon 23 Jan, Johan Hedberg wrote:
> Hi Vinicius,
> 
> On Wed, Jan 18, 2012, Vinicius Costa Gomes wrote:
> > If we need a copy of those keys we should copy them.
> > ---
> >  plugins/hciops.c |   13 ++++++++++++-
> >  1 files changed, 12 insertions(+), 1 deletions(-)
> 
> The two first patches have been applied but this one had some issues:
> 
> > diff --git a/plugins/hciops.c b/plugins/hciops.c
> > index d4d219c..4e0729e 100644
> > --- a/plugins/hciops.c
> > +++ b/plugins/hciops.c
> > @@ -3563,6 +3563,7 @@ static int hciops_restore_powered(int index)
> >  static int hciops_load_keys(int index, GSList *keys, gboolean debug_keys)
> >  {
> >  	struct dev_info *dev = &devs[index];
> > +	GSList *l, *new;
> >  
> >  	DBG("hci%d keys %d debug_keys %d", index, g_slist_length(keys),
> >  								debug_keys);
> > @@ -3570,7 +3571,17 @@ static int hciops_load_keys(int index, GSList *keys, gboolean debug_keys)
> >  	if (dev->keys != NULL)
> >  		return -EEXIST;
> >  
> > -	dev->keys = keys;
> > +	for (new = NULL, l = keys; l; l = l->next) {
> > +		struct link_key_info *orig, *dup;
> > +
> > +		orig = l->data;
> > +
> > +		dup = g_memdup(orig, sizeof(*orig));
> > +
> > +		new = g_slist_prepend(new, dup);
> > +	}
> > +
> > +	dev->keys = new;
> >  	dev->debug_keys = debug_keys;
> 
> 
> In general I'm always a bit on guard with usage of C++ keywords like new
> and class, but in this case instead of renaming you could just prepend
> directly to dev->keys, i.e. there's no need for this temporary variable.

Will fix. Thanks.

> 
> Johan

Cheers,
-- 
Vinicius
