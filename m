Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 2/2] Resolve parallel build builtin.h
From: Marcel Holtmann <marcel@holtmann.org>
To: Alon Bar-Lev <alon.barlev@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Sun, 13 Nov 2011 08:26:22 +0900
In-Reply-To: <CAOazyz3eNUvJ_ft9-+E05mFScT7S-t2=PirZ++x9O--q3ehAtg@mail.gmail.com>
References: <CAOazyz3eNUvJ_ft9-+E05mFScT7S-t2=PirZ++x9O--q3ehAtg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1321140385.15441.439.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alon,

> builtin.h is generated source, the priority of build should
> be unconditional.
> 
> The dependency in plugin.$(OBJEXT) cannot be trusted also it
> does not work for me.
> 
> Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>
> ---

see my comments from the other emails on how to submit patches.

For this one, I fixed this anyway, since the change was simple.

Regards

Marcel


