Return-Path: <cyrus@holtmann.org>
Message-Id: <3D8E1963-54E4-4974-98B3-6E9095046D30@gmail.com>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <ac8af0be0812221733j262e8077re27476f18772079e@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [patch] fix the bug of obex_object_resume(), obex_server() in openobex
Date: Wed, 24 Dec 2008 03:23:26 +0200
References: <ac8af0be0812221733j262e8077re27476f18772079e@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Forrest,

On Dec 23, 2008, at 3:33, Zhao Forrest wrote:
> When developing the PBAP server in obexd we found that
> obex_object_resume() can't work as expected. After debugging openobex
> we post this patch to fix the bug. We did the internal test with PBAP
> server/client. The below patch fixes the bug in obex_object_resume()
> and obex_server().

The patch seems fine and has been pushed upstream, thanks! Btw, in the  
future please use the openobex-users mailing list for openobex  
specific patches.

Johan
