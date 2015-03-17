Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH v4 6/7] Bluetooth: Set HCI_QUIRK_SIMULTANEOUS_DISCOVERY for BTUSB_INTEL
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1426556254-1480-6-git-send-email-jpawlowski@google.com>
Date: Mon, 16 Mar 2015 19:19:34 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <4AB8AD46-826F-4DD4-A3F9-04705594A773@holtmann.org>
References: <1426556254-1480-1-git-send-email-jpawlowski@google.com> <1426556254-1480-6-git-send-email-jpawlowski@google.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

> Intel controllers can do both LE and classic scan at once.

please name it LE scanning and BR/EDR inquiry. The classic term is not really defined.

Regards

Marcel

