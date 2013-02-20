Return-Path: <cyrus@holtmann.org>
Date: Wed, 20 Feb 2013 14:20:57 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Timo Mueller <mail@timomueller.eu>
Cc: linux-bluetooth@vger.kernel.org,
	Timo Mueller <timo.mueller@bmw-carit.de>
Subject: Re: [PATCH] tools: btmgmt: Fix return value to return request id
Message-ID: <20130220172057.GA28920@samus>
References: <d8a09e5d342194afb476c780f800943bc2e2f210.1361377269.git.timo.mueller@bmw-carit.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d8a09e5d342194afb476c780f800943bc2e2f210.1361377269.git.timo.mueller@bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Timo,

On 17:26 Wed 20 Feb, Timo Mueller wrote:
> From: Timo Mueller <timo.mueller@bmw-carit.de>
> 
> Commit 947a7477d2a2ab6a61e5a7de44fd5b7cd2ab8d9c introduced the method
> send_cmd which returned the index of the adapter instead of the
> request id. As a result no mgmt command could be sent to hci0, as 0
> marks an invalid request id.
> ---

Ack.


Cheers,
-- 
Vinicius
