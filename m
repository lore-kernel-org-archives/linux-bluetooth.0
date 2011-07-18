Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH obexd 1/6] Make use of g_slist_free_full when elements
 are dynamically-allocated
From: Marcel Holtmann <marcel@holtmann.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 18 Jul 2011 12:39:28 +0200
In-Reply-To: <1310985316-2197-1-git-send-email-luiz.dentz@gmail.com>
References: <1310985316-2197-1-git-send-email-luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1310985570.21109.157.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luis,

> This avoid having to iterate twice in the list to free its elements.

please make sure we have the same workaround for older GLib versions
without this function. At this point of time, I wanna allow building it
with older GLib versions. We can revisit that at some point in the
future and remove that cruft, but for now it seems reasonable.

Regards

Marcel


