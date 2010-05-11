Return-Path: <cyrus@holtmann.org>
Date: Tue, 11 May 2010 09:47:45 +0200 (CEST)
From: Jiri Kosina <jkosina@suse.cz>
To: "Justin P. Mattock" <justinmattock@gmail.com>
Cc: Michael Poole <mdpoole@troilus.org>,
	linux-bluetooth@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: magicmouse: claimed by neither input, hiddev nor hidraw
In-Reply-To: <4BE8C7CD.7030206@gmail.com>
Message-ID: <alpine.LNX.2.00.1005110946520.28092@pobox.suse.cz>
References: <j2idd18b0c31005101341o43b652c1zf8729f5f9a60e0d3@mail.gmail.com> <alpine.LRH.2.00.1005102334140.14809@twin.jikos.cz> <s2odd18b0c31005101439v22d03bfdw4e65d7c4b8315b6a@mail.gmail.com> <alpine.LNX.2.00.1005102351220.28092@pobox.suse.cz>
 <4BE8859E.3090305@gmail.com> <87mxw7i33j.fsf@troilus.org> <4BE8C7CD.7030206@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 10 May 2010, Justin P. Mattock wrote:

> The only other thing that I remember when adding hidraw was adding 
> BT_HCIUART_LL=m (not sure if it matters or not).
> 
> here is dmesg:
> http://fpaste.org/OiDf/

Please include the dmesg directly in the mail next time.

Anyway, I don't see the dmesg you provided containing neither the "claimed
by neither input, hiddev nor hidraw" nor "hw start failed" messages.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
