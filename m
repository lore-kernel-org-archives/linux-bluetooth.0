Return-Path: <cyrus@holtmann.org>
Date: Mon, 20 Dec 2010 16:54:22 -0200
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Bruna Moreira <bruna.moreira@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Move EIR flags definitions to adapter.c
Message-ID: <20101220185421.GA553@vigoh>
References: <1292869005-12391-1-git-send-email-bruna.moreira@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1292869005-12391-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bruna,

* Bruna Moreira <bruna.moreira@openbossa.org> [2010-12-20 14:16:44 -0400]:

> ---
>  src/adapter.c |    9 +++++++++
>  src/sdpd.h    |    9 ---------
>  2 files changed, 9 insertions(+), 9 deletions(-)

What's the point on moving this? I supposed you were using these macros in the
following patch but you're not.

-- 
Gustavo F. Padovan
http://profusion.mobi
