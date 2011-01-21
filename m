Return-Path: <cyrus@holtmann.org>
Date: Fri, 21 Jan 2011 12:16:02 +0530
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bruna Moreira <bruna.moreira@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix duplicate characteristics
Message-ID: <20110121064602.GA1789@jh-x301>
References: <1295530067-6022-1-git-send-email-bruna.moreira@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1295530067-6022-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bruna,

On Thu, Jan 20, 2011, Bruna Moreira wrote:
> The Discover() operation (from DBus API) was registering the same
> characteristics after running several times. This can be checked using
> test-attrib.
> ---
>  attrib/client.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)

Pushed upstream. Thanks.

Johan
