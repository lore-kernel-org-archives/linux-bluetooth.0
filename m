Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1299083684-5062-1-git-send-email-bruna.moreira@openbossa.org>
References: <1298583454-18227-1-git-send-email-bruna.moreira@openbossa.org>
	<1299083684-5062-1-git-send-email-bruna.moreira@openbossa.org>
Date: Fri, 4 Mar 2011 15:32:11 -0400
Message-ID: <AANLkTin6_iXpnzefS3duPz0n8PV804CVE0LjPmDfF4+Y@mail.gmail.com>
Subject: Re: [PATCHv2 1/2] Use CID to infer transport type
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 3/2/11, Bruna Moreira <bruna.moreira@openbossa.org> wrote:
> Instead of comparing GIOChannel pointers, use the CID returned by
> bt_io_get() to infer the transport type. LE uses the fixed CID for GATT.
> ---
>  src/attrib-server.c |    7 ++++---
>  1 files changed, 4 insertions(+), 3 deletions(-)
>

Please ignore this series, I will send a fixed one (I found a bug
after running more tests).

BR,
-- 
Bruna Moreira
Instituto Nokia de Tecnologia (INdT)
Manaus - Brazil
