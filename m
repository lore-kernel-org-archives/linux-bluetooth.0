Return-Path: <cyrus@holtmann.org>
Date: Mon, 22 Aug 2011 10:58:16 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Slawomir Bochenski <lkslawek@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd 1/3] MAP: Add MIME drivers
Message-ID: <20110822075816.GD31673@dell>
References: <1313157643-5387-1-git-send-email-lkslawek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1313157643-5387-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Slawek,

On Fri, Aug 12, 2011, Slawomir Bochenski wrote:
> This adds drivers for MIME types needed in Message Access Profile. The
> target-default driver is also kept to prevent MIME driver selection
> mechanism to get to default driver from filesystem.c which would result
> in allowing putting files in arbitrary locations when connected to MAP
> target.
> 
> The any_open() bindings in MIME drivers are going to be successfully
> replaced by appropriate calls for specific functionality.
> ---
>  plugins/mas.c |  101 ++++++++++++++++++++++++++++++++++++++++++++++++++-------
>  1 files changed, 89 insertions(+), 12 deletions(-)

All three patches have been applied. Thanks.

Johan
