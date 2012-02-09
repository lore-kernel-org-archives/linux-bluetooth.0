Return-Path: <cyrus@holtmann.org>
Message-ID: <1328795351.28848.17.camel@aeonflux>
Subject: Re: [PATCH 0/3] Advertising cache locking code refactoring
From: Marcel Holtmann <marcel@holtmann.org>
To: Andre Guedes <aguedespe@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, andre.guedes@openbossa.org
Date: Thu, 09 Feb 2012 14:49:11 +0100
In-Reply-To: <1328588997-25029-1-git-send-email-aguedespe@gmail.com>
References: <1328588997-25029-1-git-send-email-aguedespe@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> This patch series does some code refactoring in advertising cache locking
> related code. This work is a small effort to improve locking usage in
> Bluetooth subsystem.
> 
> BR,
> 
> Andre
> 
> Andre Guedes (3):
>   Bluetooth: Add prefix "__" to advertising cache functions
>   Bluetooth: Create thread-safe advertising cache functions
>   Bluetooth: Use advertising cache thread-safe functions
> 
>  include/net/bluetooth/hci_core.h |    4 +++
>  net/bluetooth/hci_conn.c         |    2 +-
>  net/bluetooth/hci_core.c         |   51 +++++++++++++++++++++++++++++++------
>  net/bluetooth/hci_event.c        |    6 +---
>  4 files changed, 48 insertions(+), 15 deletions(-)

so I looked through this patch series and the only useful patch is 1/3
and even that one is kinda questionable. However if people in general
find this a bit clearer that we prefix unlocked hdev functions with __,
then I would be fine is it. Opinions anybody?

Regards

Marcel


