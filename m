Return-Path: <cyrus@holtmann.org>
Date: Fri, 18 Sep 2015 11:02:41 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 1/2] gdbus: add method for immediate property update
Message-ID: <20150918080241.GA368@t440s.lan>
References: <1442562403-5176-1-git-send-email-jpawlowski@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1442562403-5176-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Fri, Sep 18, 2015, Jakub Pawlowski wrote:
> +void g_dbus_emit_property_changed_full(DBusConnection *connection,
> +				const char *path, const char *interface,
> +				const char *name, gboolean flush);

I can't say I'm a fan of boolean parameters like this where it's
essentially impossible to say when looking at the calling code what the
parameter does (in this case the completely generic "full" in the
function name doesn't even give any hints about what exactly the
parameter might be). Instead, using a flags parameter + enum would be
one way to keep the calling code understandable.

Johan
