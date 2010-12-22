Return-Path: <cyrus@holtmann.org>
Date: Thu, 23 Dec 2010 00:50:54 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 07/18] Add support for creating devices from stored
 primary services
Message-ID: <20101222225054.GD10702@jh-x301>
References: <1292966800-6264-1-git-send-email-vinicius.gomes@openbossa.org>
 <1292966800-6264-8-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1292966800-6264-8-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Tue, Dec 21, 2010, Vinicius Costa Gomes wrote:
> From what we can retrieve from storage we are able to create the devices
> and probe the device drivers.
> ---
>  src/adapter.c |   77 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 77 insertions(+), 0 deletions(-)

Patches 5 and 6 have been pushed upstream, but this one doesn't compile:

src/adapter.c: In function 'string_to_primary_list':
src/adapter.c:1958: error: implicit declaration of function 'att_primary_free'
src/adapter.c: In function 'create_stored_device_from_primary':
src/adapter.c:2003: error: 'att_primary_free' undeclared (first use in this function)
src/adapter.c:2003: error: (Each undeclared identifier is reported only once
src/adapter.c:2003: error: for each function it appears in.)
make[1]: *** [src/adapter.o] Error 1

Please fix and resubmit.

Johan
