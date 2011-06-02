Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <BANLkTimMo0Hbt2KQ13Xm1Rb5kTNLMiCNXA@mail.gmail.com>
References: <1306933529-4270-1-git-send-email-lkslawek@gmail.com>
	<BANLkTik6c0N8Oy9CZZak+Zn5JQ3F636CLQ@mail.gmail.com>
	<20110601133921.GB6226@dell.ger.corp.intel.com>
	<BANLkTim-kQt-_6ME-2Ju6SiiEv1bSYUBAQ@mail.gmail.com>
	<20110601135322.GA7132@dell.ger.corp.intel.com>
	<BANLkTimMo0Hbt2KQ13Xm1Rb5kTNLMiCNXA@mail.gmail.com>
Date: Thu, 2 Jun 2011 09:32:57 +0300
Message-ID: <BANLkTi=_dXMTD5uiM8FW91BarxGw+F35JA@mail.gmail.com>
Subject: Re: [PATCH] Adjust parameters in obexd.service.in
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Slawomir Bochenski <lkslawek@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Jun 1, 2011 at 5:41 PM, Slawomir Bochenski <lkslawek@gmail.com> wrote:
>> I don't think the content of the default .service file has been thought
>> out so deeply, so I wouldn't put too much effort into retaining the
>> *exact* same behavior as before. Distros will typically customize it
>> anyway for their needs. What does make sense though is to have some kind
>> of sensible defaults there. Aren't all plugins a sensible default? Do we
>> have something inherently unstable/experimental that could mess up
>> systems? If so then that should probably be disabled by default already
>> at configure time, and if you really want to have something in the
>> service file it's probably easier to use -P instead of -p since the
>> "bad" plugins are in the minority.
>
> Well, in fact when this file was committed originally, there was
> nothing more to choose vyt OPP and FTP. Those two however looked like
> sensible defaults for a desktop setup. I suppose that for example PBAP
> and MAP don't seem to be the most wanted plugins in this case. Don't
> know about IrMC or SyncML.

But it doesn' t mean that this file will be installed as it is, so
just remove the invalid options and load all plugins as Johan
suggested should be fine. As for unstable plugins we can have it done
similarly to pcsuite which needs to be enabled during build time.

-- 
Luiz Augusto von Dentz
Computer Engineer
