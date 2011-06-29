Return-Path: <cyrus@holtmann.org>
Date: Wed, 29 Jun 2011 23:18:33 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/6] Make use of g_slist_free_full when elements
 are dynamically-allocated
Message-ID: <20110629201833.GA11241@dell.ger.corp.intel.com>
References: <1309337573-8295-1-git-send-email-luiz.dentz@gmail.com>
 <BANLkTika3jp4Y2vyU-PWpgf+oDBX_xgN_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BANLkTika3jp4Y2vyU-PWpgf+oDBX_xgN_Q@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Wed, Jun 29, 2011, Lucas De Marchi wrote:
> Another thing that I think it'd be nice to use is
> g_io_channel_set_close_on_unref() instead of unref() + shutdown() in
> several places. What do you think?

You need to be careful with that since those two methods are not
identical: unref() + shutdown() will close the link immediately, whereas
close_on_unref() + unref() will not do anything (except the unref) if
there are any other references around. E.g. all IO callbacks own a
reference to the GIOChannel so doing a simple unref() on the GIOChannel
elsewhere will not actually close the link even if close_on_unref is
TRUE.

There are several places which expect the IO callback to check for
G_IO_NVAL and return FALSE if set (thereby removing the IO callback and
its GIOChannel reference). The only way you'd be able to convert such
cases is to change the unref() + shutdown() to a unref() +
g_source_remove(). However, this would eliminate most/some of the
simplification gain you're trying to accomplish.

Johan
