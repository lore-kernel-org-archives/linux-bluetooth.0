Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <7a0f70a33f68c7a654e9d0d00ea9c9569fda5d7f.camel@hadess.net>
Subject: Re: Fixing potential unwanted pairings
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Date: Tue, 24 Jul 2018 13:01:04 +0200
In-Reply-To: <c26a02c4df73953ae486cf207036980f8263d3ae.camel@hadess.net>
References: <c26a02c4df73953ae486cf207036980f8263d3ae.camel@hadess.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 2018-07-20 at 13:23 +0200, Bastien Nocera wrote:
> 
<snip>
> This means that a combination of a hard-to-use API for
> Discoverable[3],
> and the kernel's default policy, will allow devices such as iPhones
> to
> pair without any interaction on the computer/BlueZ side.

This particular problem has been assigned a CVE: CVE-2018-10910

Would be great if I could have some feedback on this.
