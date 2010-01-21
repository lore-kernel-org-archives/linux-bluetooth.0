Return-Path: <cyrus@holtmann.org>
From: Denis Kenzior <denis.kenzior@intel.com>
To: Zhao Forrest <forrest.zhao@gmail.com>
Subject: Re: [RFC] HFP support into oFono and BlueZ
Date: Wed, 20 Jan 2010 20:56:33 -0600
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>,
	"linux-bluetooth" <linux-bluetooth@vger.kernel.org>,
	ofono@ofono.org, zhenhua.zhang@intel.com
References: <fbf08281001110908s2c3412m456b3aa980b8ca10@mail.gmail.com> <fbf08281001201158q23d13d9bj930a66271c527b43@mail.gmail.com> <ac8af0be1001202354i7f1a98dbw55c56fc65f878358@mail.gmail.com>
In-Reply-To: <ac8af0be1001202354i7f1a98dbw55c56fc65f878358@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201001202056.33659.denis.kenzior@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Forrest,

> Your patch removes many DBus APIs provided by audio/gateway.c, which
> was originally designed to provide a set of DBus functions/signals for
> ease of application development. In other words, your patch is too
> oFono-specific, and is not a general support for HFP HF unit role in
> BlueZ IMO. The DBus interface provided by your patch is not easy to
> develop the application because the application developer has to parse
> the AT commands by himself. I know that oFono could parse AT commands.

That is actually the point :)

> But I don't think it a common case for other application developers.
> Why not extend audio/gateway.c instead of removing its DBus APIs or
> create a new file to support HFP for oFono in blueZ?

If we were to extend the current BlueZ API we'd be duplicating all of what 
oFono has already solved (particularly 3-way calls, multiparty and other 
advanced features) and force the developers to support yet-another DBus API.  
This makes no sense and oFono already supports the full HFP protocol along 
with most of the nasty corner cases.  This in fact simplifies things quite a 
bit...

Regards,
-Denis
