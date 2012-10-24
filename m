Return-Path: <cyrus@holtmann.org>
Message-ID: <1351115627.1785.77.camel@aeonflux>
Subject: Re: [PATCH 0/6] Bluetooth: Some fixes and full peripheral role
 support
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 24 Oct 2012 14:53:47 -0700
In-Reply-To: <1351112996-9597-1-git-send-email-johan.hedberg@gmail.com>
References: <1351112996-9597-1-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This set of patches contains some basic fixes to SSP and LE enablement
> HCI commands as well as the two missing patches from my previous set,
> i.e. implementation of mgmt_set_le for peripheral mode as well as the
> writing of advertising data.

patches 1-4 look good to me. With 5-6, I would hold off a little bit
until we get this all figured out.

However we might should merge some of the basic HCI constants and
structs you need for advertisement handling. So that Aloisio's and your
patches do not conflict that much.

Regards

Marcel


