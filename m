Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Fix parallel build
From: Marcel Holtmann <marcel@holtmann.org>
To: Adam =?UTF-8?Q?Go=C5=82=C4=99biowski?= <adamg@pld-linux.org>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1253645194-85628-1-git-send-email-adamg@pld-linux.org>
References: <1253645194-85628-1-git-send-email-adamg@pld-linux.org>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 22 Sep 2009 14:51:09 -0700
Message-Id: <1253656269.2931.4.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Adam,

> Since src/bluetoothd needs libbluetooth, add it to its dependencies.
> Parallel build tested with make -j16.

patch has been applied. Thanks.

> Signed-off-by: Adam Gołębiowski <adamg@pld-linux.org>

The signed-off-by lines are not used within BlueZ.

Regards

Marcel


