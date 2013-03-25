Return-Path: <cyrus@holtmann.org>
Date: Mon, 25 Mar 2013 14:29:52 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jefferson Delfes <jefferson.delfes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 0/6] attrib: Remove glib basic data types usage
Message-ID: <20130325122952.GB21794@x220.ger.corp.intel.com>
References: <1362430730-19580-1-git-send-email-jefferson.delfes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1362430730-19580-1-git-send-email-jefferson.delfes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jefferson,

On Mon, Mar 04, 2013, Jefferson Delfes wrote:
> This patch series do a cleanup of glib basic data types usage. Types as
> gpointer, guint, gint, gchar and gsize were replaced by standard types without
> any extra effort. The only exception was gboolean which needs stdbool.h.
> Some variables were mainted as gboolean, because are passed as parameter to
> glib functions.

For code directly interacting with GLib APIs I thought the convention is
to use the same data types as in the APIs (meaning the GLib ones). Have
you seen major differences to this principle somewhere in the source
tree?

Johan
