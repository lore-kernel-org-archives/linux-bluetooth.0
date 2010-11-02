Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] bluetooth: bnep: fix information leak to userland
From: Marcel Holtmann <marcel@holtmann.org>
To: Vasiliy Kulikov <segooon@gmail.com>
Cc: kernel-janitors@vger.kernel.org,
	"Gustavo F. Padovan" <padovan@profusion.mobi>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <eric.dumazet@gmail.com>,
	Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>,
	Tejun Heo <tj@kernel.org>, Jiri Kosina <jkosina@suse.cz>,
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
In-Reply-To: <1288448782-5582-1-git-send-email-segooon@gmail.com>
References: <1288448782-5582-1-git-send-email-segooon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 02 Nov 2010 16:35:31 +0100
Message-ID: <1288712131.3322.178.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vasiiy,

> Structure bnep_conninfo is copied to userland with the field "device"
> that has the last elements unitialized.  It leads to leaking of
> contents of kernel stack memory.
> 
> Signed-off-by: Vasiliy Kulikov <segooon@gmail.com>

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


