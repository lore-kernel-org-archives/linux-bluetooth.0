Return-Path: <cyrus@holtmann.org>
Date: Thu, 27 Sep 2012 10:43:38 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Jo=E3o?= Paulo Rechi Vita <jprvita@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org,
	Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: Re: [PATCH BlueZ v7 2/9] mgmt: Add LE scanning callback
Message-ID: <20120927074338.GC9610@x220>
References: <1348594686-26221-1-git-send-email-jprvita@openbossa.org>
 <1348594686-26221-2-git-send-email-jprvita@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1348594686-26221-2-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Sep 25, 2012, João Paulo Rechi Vita wrote:
> +int mgmt_start_scanning(int index)

Firstly I don't think the name is good since BR/EDR also has the concept
of scanning (page scan & inquiry scan). Secondly, maybe it'd be simpler
to reuse mgmt_start_discovery and simply add a new parameter which
provides the value for info->discov_type?

Johan
