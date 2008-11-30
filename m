Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 4/5] drivers/bluetooth: change simple_strtol to
 simple_strtoul
From: Marcel Holtmann <marcel@holtmann.org>
To: Julia Lawall <julia@diku.dk>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0811251414330.11897@pc-004.diku.dk>
References: <Pine.LNX.4.64.0811251414330.11897@pc-004.diku.dk>
Content-Type: text/plain
Date: Sun, 30 Nov 2008 09:53:13 +0100
Message-Id: <1228035193.9176.3.camel@violet.holtmann.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Julia,

> From: Julia Lawall <julia@diku.dk>
> 
> Since size, addr, fcs, and tmp are unsigned, it would seem better to use
> simple_strtoul that simple_strtol.
> 
> A simplified version of the semantic patch that makes this change is as
> follows: (http://www.emn.fr/x-info/coccinelle/)

patch has been applied to my tree. Thanks.

Regards

Marcel


