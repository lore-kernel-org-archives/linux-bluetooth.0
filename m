Return-Path: <cyrus@holtmann.org>
Message-ID: <1349344029.27233.6.camel@aeonflux>
Subject: Re: [PATCH 1/5] bt tool: initial tool handling
From: Marcel Holtmann <marcel@holtmann.org>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org, travis.reitter@collabora.co.uk,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Date: Thu, 04 Oct 2012 11:47:09 +0200
In-Reply-To: <1349285669-20464-2-git-send-email-gustavo@padovan.org>
References: <1349285669-20464-1-git-send-email-gustavo@padovan.org>
	 <1349285669-20464-2-git-send-email-gustavo@padovan.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> All core code to using this tool is here, the nexts steps will add
> commands like 'discover' 'pair' 'agent', etc.
> ---
>  Makefile.tools  |   7 +-
>  tools/bt-tool.c | 421 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 427 insertions(+), 1 deletion(-)
>  create mode 100644 tools/bt-tool.c

use client/main.c for this. Similar to how we do that inside ConnMan.
The tools directory is full of files by now.

Regards

Marcel


