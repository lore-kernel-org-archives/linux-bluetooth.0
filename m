Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1292341274.3050.15.camel@novo.hadess.net>
References: <1291989348-3911-1-git-send-email-michalski.raf@gmail.com>
	<AANLkTinVMvv9KG0oG1C=_wA6t7LhcYcCunuYGTWyn1Hs@mail.gmail.com>
	<AANLkTi=jaKy=o0MhzV6xRwyk00OxOhk302-DHXM7fEgE@mail.gmail.com>
	<20101214153405.GA11741@jh-x301>
	<1292341274.3050.15.camel@novo.hadess.net>
Date: Tue, 14 Dec 2010 19:20:26 +0100
Message-ID: <AANLkTimMOeuyUj5CRMsm7QpoumgHRMmOsby2E6GoSHrd@mail.gmail.com>
Subject: Re: [PATCH] Fix crash while reading from mapped file
From: Lukasz Pawlik <lucas.pawlik@gmail.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> If somebody can explain what that code is supposed to do, then writing a
> glib-ish version should be trivial, without having to duplicate the
> contents again. Then again, using something like:
> g_mapped_file_new ();
> g_strsplit ();
> g_mapped_file_unref ();

That won't fix anything since g_mapped_file_new uses mmap function so
contents may not be zero-terminated and we want use string function
next.

Lukasz Pawlik
