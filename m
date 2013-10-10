Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH v4 2/2] Bluetooth: Refactor hci_connect_le
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1381231278-20534-2-git-send-email-andre.guedes@openbossa.org>
Date: Thu, 10 Oct 2013 10:31:56 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <1EC7A162-46E7-4BCA-96EE-E4D01265FB9A@holtmann.org>
References: <1381231278-20534-1-git-send-email-andre.guedes@openbossa.org> <1381231278-20534-2-git-send-email-andre.guedes@openbossa.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> This patch does some code refactoring in hci_connect_le() by moving
> the exception code into if statements and letting the main flow in
> first level of function scope. It also adds extra comments to improve
> the code readability.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
> net/bluetooth/hci_conn.c | 51 +++++++++++++++++++++++++++++++-----------------
> 1 file changed, 33 insertions(+), 18 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

