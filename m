Return-Path: <cyrus@holtmann.org>
Date: Tue, 9 Sep 2014 17:29:54 -0700
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ v1 4/7] shared/gatt-client: Handle incoming not/ind
 PDUs.
Message-ID: <20140910002954.GA7572@t440s>
References: <1410282249-22004-1-git-send-email-armansito@chromium.org>
 <1410282249-22004-5-git-send-email-armansito@chromium.org>
 <B3B84C22-937B-4880-B59F-0CFA680192D1@holtmann.org>
 <CAHrH25SVxPLYdjAGNHSwOKLx60wUOSRTzBTHDJfmvpFkiFhRPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAHrH25SVxPLYdjAGNHSwOKLx60wUOSRTzBTHDJfmvpFkiFhRPA@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Tue, Sep 09, 2014, Arman Uguray wrote:
> >> +     unsigned int notify_id, indic_id;
> >
> > I have never seen indication shorted into indic. I have to say that
> > I do not like it that much. However I do not have any good
> > suggestion either.
> >
> 
> Perhaps "indicn_id"? I could just spell out "indication_id" :P.

What's wrong with "ind"? It's used in many places in the tree as a
shorthand for indication and even shared/att.c uses it. On the other
hand if you want to match the grammatical form of notify_id you should
use indicate_id (which feels much worse to me). Third option that comes
to mind if we want short versions of both is "ind" and "nfy", but not
sure how decipherable the latter is.

Johan
