Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <BANLkTim-kQt-_6ME-2Ju6SiiEv1bSYUBAQ@mail.gmail.com>
References: <1306933529-4270-1-git-send-email-lkslawek@gmail.com>
	<BANLkTik6c0N8Oy9CZZak+Zn5JQ3F636CLQ@mail.gmail.com>
	<20110601133921.GB6226@dell.ger.corp.intel.com>
	<BANLkTim-kQt-_6ME-2Ju6SiiEv1bSYUBAQ@mail.gmail.com>
Date: Wed, 1 Jun 2011 15:50:02 +0200
Message-ID: <BANLkTi=cLFKD8CHjkv-iioeOfZ-Nc6Vddw@mail.gmail.com>
Subject: Re: [PATCH] Adjust parameters in obexd.service.in
From: Slawomir Bochenski <lkslawek@gmail.com>
To: Slawomir Bochenski <lkslawek@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Jun 1, 2011 at 3:42 PM, Slawomir Bochenski <lkslawek@gmail.com> wrote:
> This was specifically made for retaining original behaviour. Simply
> removing --ftp and --opp would make obexd load all available plugins,
> which isn't how this worked until now.

Or, to be specific - it worked that way. That is all plugins loaded,
but not every server initialized and started. Only those explicitly
given on command line.

-- 
Slawomir Bochenski
