Return-Path: <cyrus@holtmann.org>
Date: Tue, 4 Sep 2012 10:47:21 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: chen.ganir@ti.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v7] gatt: Translate Characteristic names
Message-ID: <20120904074721.GA4286@x220>
References: <1346733990-23351-1-git-send-email-chen.ganir@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1346733990-23351-1-git-send-email-chen.ganir@ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chen,

On Tue, Sep 04, 2012, chen.ganir@ti.com wrote:
> From: Chen Ganir <chen.ganir@ti.com>
> 
> Translate Characteristic UUID's to name. This list was taken from
> the Bluetooth SIG developer site.
> ---
>  attrib/client.c |   76 ++++++++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 73 insertions(+), 3 deletions(-)

Applied after removing one last issue with the empty element at the end
of the list. Thanks.

Johan
