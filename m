Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Subject: Re: [PATCH] tools: make parse_companies.pl more forgiving of weird HTML
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20160319034848.GO22136@lacklustre.net>
Date: Sat, 19 Mar 2016 20:18:15 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <282D49E3-1332-4A5D-B4C3-97F75E3E0184@holtmann.org>
References: <20160319034848.GO22136@lacklustre.net>
To: Mike Ryan <mikeryan@lacklustre.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mike,

> Several company identifier lines do not end in a </td> but rather <br/>
> followed by newline followed by </td>. This dirty hack is more forgiving
> of HTML weirdnesses in the SIGs company identifiers page.
> ---
> tools/parse_companies.pl | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied.

Regards

Marcel

