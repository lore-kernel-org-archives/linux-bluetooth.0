Return-Path: <cyrus@holtmann.org>
Date: Wed, 4 Apr 2012 11:56:54 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: Mat Martineau <mathewm@codeaurora.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"padovan@profusion.mobi" <padovan@profusion.mobi>,
	"pkrystad@codeaurora.org" <pkrystad@codeaurora.org>,
	"marcel@holtmann.org" <marcel@holtmann.org>
Subject: Re: [PATCHv3 1/2] Bluetooth: Add the l2cap_seq_list structure for
 tracking frames
Message-ID: <20120404085653.GB17251@aemeltch-MOBL1>
References: <1333493332-24623-1-git-send-email-mathewm@codeaurora.org>
 <1333493332-24623-2-git-send-email-mathewm@codeaurora.org>
 <201204041044.19530.szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201204041044.19530.szymon.janc@tieto.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Wed, Apr 04, 2012 at 10:44:19AM +0200, Szymon Janc wrote:
> > +	seq_list->list = kzalloc(sizeof(u16) * alloc_size, GFP_KERNEL);
> > +	if (!seq_list->list)
> > +		return -ENOMEM;
> > +
> > +	seq_list->mask = alloc_size - 1;
> > +	seq_list->head = L2CAP_SEQ_LIST_CLEAR;
> > +	seq_list->tail = L2CAP_SEQ_LIST_CLEAR;
> > +	for (i = 0; i < alloc_size; i++)
> > +		seq_list->list[i] = L2CAP_SEQ_LIST_CLEAR;
> 
> Could use memset for this instead of loop, and maybe use kcalloc instead of
> kzalloc to allocate array?

memset is implemented trough the loop anyway and would take 2x more
iterations.

void *memset(void *s, int c, size_t count)
{
	char *xs = s;
	while (count--)
		*xs++ = c;
	return s;
}



Best regards 
Andrei Emeltchenko 
