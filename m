Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110601133921.GB6226@dell.ger.corp.intel.com>
References: <1306933529-4270-1-git-send-email-lkslawek@gmail.com>
	<BANLkTik6c0N8Oy9CZZak+Zn5JQ3F636CLQ@mail.gmail.com>
	<20110601133921.GB6226@dell.ger.corp.intel.com>
Date: Wed, 1 Jun 2011 15:42:43 +0200
Message-ID: <BANLkTim-kQt-_6ME-2Ju6SiiEv1bSYUBAQ@mail.gmail.com>
Subject: Re: [PATCH] Adjust parameters in obexd.service.in
From: Slawomir Bochenski <lkslawek@gmail.com>
To: Slawomir Bochenski <lkslawek@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> Aren't most/all plugins compiled as built-in and all built-in plugins
> loaded by default? Then you shouldn't need to provide any -p option to
> get everything loaded. If this is the case could you update your patch
> to simply remove the --ftp and --opp options without adding the --plugin
> option.
>
> Johan
>

This was specifically made for retaining original behaviour. Simply
removing --ftp and --opp would make obexd load all available plugins,
which isn't how this worked until now.

-- 
Slawomir Bochenski
