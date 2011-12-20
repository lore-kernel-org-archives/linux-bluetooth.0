Return-Path: <cyrus@holtmann.org>
Message-ID: <1324400033.1965.123.camel@aeonflux>
Subject: Re: [PATCH hcidump] Restore --verbose/-V option
From: Marcel Holtmann <marcel@holtmann.org>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 20 Dec 2011 08:53:53 -0800
In-Reply-To: <1324388833-28015-1-git-send-email-szymon.janc@tieto.com>
References: <1324388833-28015-1-git-send-email-szymon.janc@tieto.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

> Ignore --verbose and -V options instead of printing usage info. This
> is for compatibility with hcidump 1.x to not break scripts.

it is a new major version and scripts will break eventually. You are
just trying to delay this. And when I make 3.x and then the same patch
will come up again. You might wanna look into a tool called sed ;)

Regards

Marcel


