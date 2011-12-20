Return-Path: <cyrus@holtmann.org>
Date: Tue, 20 Dec 2011 13:47:26 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH hcidump] Restore --verbose/-V option
Message-ID: <20111220154726.GA18981@joana>
References: <1324388833-28015-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1324388833-28015-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

* Szymon Janc <szymon.janc@tieto.com> [2011-12-20 14:47:13 +0100]:

> Ignore --verbose and -V options instead of printing usage info. This
> is for compatibility with hcidump 1.x to not break scripts.

Why do we need to keep compatibility between major versions?
If the -V option means nothing we should inform the user about that and show
hem the help.

	Gustavo
