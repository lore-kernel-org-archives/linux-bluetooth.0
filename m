Return-Path: <cyrus@holtmann.org>
Date: Mon, 16 Aug 2010 14:23:21 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] Fix not storing tty id on pnatd plugin
Message-ID: <20100816112321.GB14417@jh-x301>
References: <1281957191-6964-1-git-send-email-luiz.dentz@gmail.com>
 <1281957191-6964-2-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1281957191-6964-2-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Mon, Aug 16, 2010, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>
> 
> The code used to create the port stored the id in a local variable
> instead of storing it in the client data which is used to release the
> port once disconnected.

Nice catch. The patch is now upstream.

Johan
