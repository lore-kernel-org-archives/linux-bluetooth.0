Return-Path: <cyrus@holtmann.org>
Subject: Re: How to build gatttool
From: Bastien Nocera <hadess@hadess.net>
To: mike tsai <mikeyhtsai@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 30 Jun 2011 23:37:37 +0100
In-Reply-To: <BANLkTinaWe5A1T1zqkbKrSD-bLRUMwPr8A@mail.gmail.com>
References: <BANLkTinaWe5A1T1zqkbKrSD-bLRUMwPr8A@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Message-ID: <1309473458.5023.88.camel@novo.hadess.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 2011-06-30 at 15:16 -0700, mike tsai wrote:
> Hi,
> 
>    Adding --enable-attrib in bootstrap-configure does not work any
> more. Is there a new way to build gatttool?

It's now an automagic dependency, as some people call it. Install
readline-devel (or whatever your distro calls it).

