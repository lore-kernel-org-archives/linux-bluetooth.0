Return-Path: <cyrus@holtmann.org>
Date: Thu, 16 Aug 2012 12:21:16 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Jo=E3o?= Paulo Rechi Vita <jprvita@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v2 04/14] core: Add a list of LE devices to connect
Message-ID: <20120816092116.GB31761@x220>
References: <1345042253-15053-1-git-send-email-jprvita@openbossa.org>
 <1345042253-15053-5-git-send-email-jprvita@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1345042253-15053-5-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Aug 15, 2012, João Paulo Rechi Vita wrote:
> +void adapter_connect_list_add(struct btd_adapter *adapter, struct btd_device *device);
> +void adapter_connect_list_remove(struct btd_adapter *adapter, struct btd_device *device);

These are breaking the "less than 80 chars" rule.

Johan
