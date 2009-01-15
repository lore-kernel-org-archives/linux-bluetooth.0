Return-Path: <cyrus@holtmann.org>
Message-ID: <d89ddf300901142127x41a70f99iddf9d77988ec883e@mail.gmail.com>
Date: Wed, 14 Jan 2009 22:27:43 -0700
From: "Brad Midgley" <bmidgley@gmail.com>
To: "Dhinakaran K" <Dhinakaran.K@lntemsys.com>
Subject: Re: Bringing A2DP over embedded platforms.
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <OF57D96ADE.BC0A6ACE-ON6525753F.001CC16B-6525753F.001CCA71@lntemsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <OF57D96ADE.BC0A6ACE-ON6525753F.001CC16B-6525753F.001CCA71@lntemsys.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Dhinakaran

> Platform    : ARM i.MX27 eval board.
> OS        : linux 2.6.22 kernel
> BlueZ         : 3.36

I'd suggest you try 4.26. A lot has changed in the encoder to improve
quality and you may see improvements in performance as well.

Some embedded systems have suffered from the problem of low bit rates
between the cpu and bluetooth radio. You should have at least 920kbps
link for a uart-connected module.

-- 
Brad Midgley
