Return-Path: <cyrus@holtmann.org>
Date: Fri, 2 Dec 2011 13:29:57 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Santiago Carot-Nemesio <sancane@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Provide return status in gatt_service_add function
Message-ID: <20111202112957.GC17203@x220.ger.corp.intel.com>
References: <1322129290-10767-1-git-send-email-sancane@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1322129290-10767-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Santiago,

On Thu, Nov 24, 2011, Santiago Carot-Nemesio wrote:
> Service plugins using the new GATT API may need to know if their attributes
> were successfuly retgistered. In this way, plugins might abort loading
> operation if they weren't registered.
> ---
>  attrib/gatt-service.c |   15 +++++++++------
>  attrib/gatt-service.h |    2 +-
>  2 files changed, 10 insertions(+), 7 deletions(-)

Both patches applied after fixing typos in your commit messages. Thanks.

Johan
