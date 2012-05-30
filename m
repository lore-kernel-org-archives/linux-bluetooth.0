Return-Path: <cyrus@holtmann.org>
Date: Wed, 30 May 2012 10:50:08 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Arik Nemtsov <arik@wizery.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] attrib-server: allow SDP records for secondary GATT
 services
Message-ID: <20120530075008.GH6539@x220>
References: <1338237948-6141-1-git-send-email-arik@wizery.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1338237948-6141-1-git-send-email-arik@wizery.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arik,

On Mon, May 28, 2012, Arik Nemtsov wrote:
> It seems this is the correct way to discover such services that work
> over BR/EDR (according to section 4.4 in the GATT specification).
> ---
>  src/attrib-server.c |    9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Applied. Thanks.

Johan
