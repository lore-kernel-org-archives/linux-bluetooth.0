Return-Path: <cyrus@holtmann.org>
Date: Wed, 1 Jun 2011 16:53:22 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Slawomir Bochenski <lkslawek@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Adjust parameters in obexd.service.in
Message-ID: <20110601135322.GA7132@dell.ger.corp.intel.com>
References: <1306933529-4270-1-git-send-email-lkslawek@gmail.com>
 <BANLkTik6c0N8Oy9CZZak+Zn5JQ3F636CLQ@mail.gmail.com>
 <20110601133921.GB6226@dell.ger.corp.intel.com>
 <BANLkTim-kQt-_6ME-2Ju6SiiEv1bSYUBAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BANLkTim-kQt-_6ME-2Ju6SiiEv1bSYUBAQ@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Slawek,

On Wed, Jun 01, 2011, Slawomir Bochenski wrote:
> > Aren't most/all plugins compiled as built-in and all built-in plugins
> > loaded by default? Then you shouldn't need to provide any -p option to
> > get everything loaded. If this is the case could you update your patch
> > to simply remove the --ftp and --opp options without adding the --plugin
> > option.
> >
> > Johan
> >
> 
> This was specifically made for retaining original behaviour. Simply
> removing --ftp and --opp would make obexd load all available plugins,
> which isn't how this worked until now.

I don't think the content of the default .service file has been thought
out so deeply, so I wouldn't put too much effort into retaining the
*exact* same behavior as before. Distros will typically customize it
anyway for their needs. What does make sense though is to have some kind
of sensible defaults there. Aren't all plugins a sensible default? Do we
have something inherently unstable/experimental that could mess up
systems? If so then that should probably be disabled by default already
at configure time, and if you really want to have something in the
service file it's probably easier to use -P instead of -p since the
"bad" plugins are in the minority.

Johan
