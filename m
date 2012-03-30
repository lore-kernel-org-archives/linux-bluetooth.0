Return-Path: <cyrus@holtmann.org>
Date: Fri, 30 Mar 2012 14:35:56 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bruna Moreira <bruna.moreira@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 BlueZ 3/4] device: Appearance characteristic from GAP
 service
Message-ID: <20120330113556.GA13864@x220>
References: <1332854978-26072-1-git-send-email-bruna.moreira@openbossa.org>
 <1333031882-15644-1-git-send-email-bruna.moreira@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1333031882-15644-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bruna,

On Thu, Mar 29, 2012, Bruna Moreira wrote:
> After searching for primary services, the appearance characteristic is
> read from GAP service and saved in "appearance" file. Running
> GetProperty in device interface, will show the respective icon based in
> "appearance" value.
> ---
>  src/device.c |   70 ++++++++++++++++++++++++++++++++++++++++++++++++++++-----
>  1 files changed, 63 insertions(+), 7 deletions(-)

All four patches in this set have been applied. Thanks.

Johan
