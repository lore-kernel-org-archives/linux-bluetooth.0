Return-Path: <cyrus@holtmann.org>
Date: Wed, 24 Apr 2013 17:02:45 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jefferson Delfes <jefferson.delfes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Subject: Re: [PATCH BlueZ v3 06/16] attrib: Change
 g_attrib_set_destroy_function return type
Message-ID: <20130424140245.GB18679@x220>
References: <1366207399-29536-1-git-send-email-jefferson.delfes@openbossa.org>
 <1366207399-29536-7-git-send-email-jefferson.delfes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1366207399-29536-7-git-send-email-jefferson.delfes@openbossa.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jefferson,

On Wed, Apr 17, 2013, Jefferson Delfes wrote:
> -gboolean g_attrib_set_destroy_function(GAttrib *attrib,
> -		GDestroyNotify destroy, gpointer user_data)
> +bool g_attrib_set_destroy_function(GAttrib *attrib, GDestroyNotify destroy,
> +							gpointer user_data)

I've applied patches 1-5 but stopped there since I'm still not sure that
we want to change this for an API which tries to follow GLib conventions
(after all that's why the GAttrib API has G and g_ prefixes). Marcel, do
you have any opinion about this one way or another?

Johan
