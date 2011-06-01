Return-Path: <cyrus@holtmann.org>
Date: Wed, 1 Jun 2011 16:39:21 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Slawomir Bochenski <lkslawek@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Adjust parameters in obexd.service.in
Message-ID: <20110601133921.GB6226@dell.ger.corp.intel.com>
References: <1306933529-4270-1-git-send-email-lkslawek@gmail.com>
 <BANLkTik6c0N8Oy9CZZak+Zn5JQ3F636CLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BANLkTik6c0N8Oy9CZZak+Zn5JQ3F636CLQ@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Slawek,

On Wed, Jun 01, 2011, Slawomir Bochenski wrote:
> I'm not sure however if ignoring transport plugins when --plugin is
> used is a good idea at all. There is no hint in --help text what user
> would have to load to make obexd work. Also no list of available
> plugins, thus this all is a bit confusing now.

Aren't most/all plugins compiled as built-in and all built-in plugins
loaded by default? Then you shouldn't need to provide any -p option to
get everything loaded. If this is the case could you update your patch
to simply remove the --ftp and --opp options without adding the --plugin
option.

Johan
