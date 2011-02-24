Return-Path: <cyrus@holtmann.org>
Date: Thu, 24 Feb 2011 17:47:20 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/3] gatttool: Remove extra reference to the connection
 IO Channel
Message-ID: <20110224204720.GC30774@jh-x301>
References: <1298579668-3143-1-git-send-email-vinicius.gomes@openbossa.org>
 <1298579668-3143-3-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1298579668-3143-3-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Thu, Feb 24, 2011, Vinicius Costa Gomes wrote:
> As we want the connection to be closed when the last GAttrib
> reference is dropped, we don't need to keep this reference.
> ---
>  attrib/gatttool.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

All three patches have been pushed upstream. Thanks.

Johan
