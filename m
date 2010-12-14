Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTinVMvv9KG0oG1C=_wA6t7LhcYcCunuYGTWyn1Hs@mail.gmail.com>
References: <1291989348-3911-1-git-send-email-michalski.raf@gmail.com>
	<AANLkTinVMvv9KG0oG1C=_wA6t7LhcYcCunuYGTWyn1Hs@mail.gmail.com>
Date: Tue, 14 Dec 2010 16:10:41 +0100
Message-ID: <AANLkTi=jaKy=o0MhzV6xRwyk00OxOhk302-DHXM7fEgE@mail.gmail.com>
Subject: Re: [PATCH] Fix crash while reading from mapped file
From: Lukasz Pawlik <lucas.pawlik@gmail.com>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> I also wonder why we didn't use g_strsplit for this, it seems it would
> actually do the same, there is a little performance impact since we
> would have to iterate on the vector generated to call the callback
> while the current code do it in-place.

Marcel, Johan any thoughts about this ? Should we reimplement this
code using glib functions ?

Lukasz Pawlik
