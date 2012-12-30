Return-Path: <cyrus@holtmann.org>
Message-ID: <1356826885.19248.79.camel@aeonflux>
Subject: Re: inconsistency in configure.ac for BlueZ 5.0 : GLib 2.32 required
From: Marcel Holtmann <marcel@holtmann.org>
To: Giovanni Gherdovich <g.gherdovich@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Sat, 29 Dec 2012 16:21:25 -0800
In-Reply-To: <CAJN7YmO4th=T2u0s9ya6fEwjO5RdEiVZCfyhTHRLb94u9Q2KeA@mail.gmail.com>
References: <CAJN7YmO4th=T2u0s9ya6fEwjO5RdEiVZCfyhTHRLb94u9Q2KeA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Giovanni,

> I believe there is a little inconsistency in configure.ac
> of BlueZ 5.0:
> 
> it requires GLib 2.28, but actually the files

I prefer to keep it at GLib 2.28 for now. So please send a patch to
workaround that issue for the missing g_queue_free_full.

Regards

Marcel


