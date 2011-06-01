Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110601135322.GA7132@dell.ger.corp.intel.com>
References: <1306933529-4270-1-git-send-email-lkslawek@gmail.com>
	<BANLkTik6c0N8Oy9CZZak+Zn5JQ3F636CLQ@mail.gmail.com>
	<20110601133921.GB6226@dell.ger.corp.intel.com>
	<BANLkTim-kQt-_6ME-2Ju6SiiEv1bSYUBAQ@mail.gmail.com>
	<20110601135322.GA7132@dell.ger.corp.intel.com>
Date: Wed, 1 Jun 2011 16:41:55 +0200
Message-ID: <BANLkTimMo0Hbt2KQ13Xm1Rb5kTNLMiCNXA@mail.gmail.com>
Subject: Re: [PATCH] Adjust parameters in obexd.service.in
From: Slawomir Bochenski <lkslawek@gmail.com>
To: Slawomir Bochenski <lkslawek@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> I don't think the content of the default .service file has been thought
> out so deeply, so I wouldn't put too much effort into retaining the
> *exact* same behavior as before. Distros will typically customize it
> anyway for their needs. What does make sense though is to have some kind
> of sensible defaults there. Aren't all plugins a sensible default? Do we
> have something inherently unstable/experimental that could mess up
> systems? If so then that should probably be disabled by default already
> at configure time, and if you really want to have something in the
> service file it's probably easier to use -P instead of -p since the
> "bad" plugins are in the minority.

Well, in fact when this file was committed originally, there was
nothing more to choose vyt OPP and FTP. Those two however looked like
sensible defaults for a desktop setup. I suppose that for example PBAP
and MAP don't seem to be the most wanted plugins in this case. Don't
know about IrMC or SyncML.

-- 
Slawomir Bochenski
