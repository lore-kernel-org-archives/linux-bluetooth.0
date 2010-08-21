Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Makefile.am fixes
From: Marcel Holtmann <marcel@holtmann.org>
To: Marcel Mol <marcel@mesa.nl>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <201008201635.o7KGZLs1009991@joshua.mesa.nl>
References: <201008201635.o7KGZLs1009991@joshua.mesa.nl>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 21 Aug 2010 10:39:24 +0200
Message-ID: <1282379964.23399.223.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

> phonebook.h should not be under _nodist.

yes it should. It is auto-generated.

> vcard.[ch] is not related to pbap, but to phonebook backend
> ---
>  Makefile.am |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)

Did you verify that "fakeroot make distcheck" still works properly after
your changes?

Regards

Marcel


