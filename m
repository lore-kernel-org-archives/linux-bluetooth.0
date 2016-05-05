Return-Path: <linux-crypto-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] Bluetooth: convert smp module to crypto kpp API
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1462440166-94042-1-git-send-email-salvatore.benedetto@intel.com>
Date: Thu, 5 May 2016 08:51:00 -0700
Cc: herbert@gondor.apana.org.au,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	linux-bluetooth@vger.kernel.org, linux-crypto@vger.kernel.org,
	Johan Hedberg <johan.hedberg@gmail.com>
Message-Id: <0CBA8F3F-333C-4E22-B1B9-6FC8734513A7@holtmann.org>
References: <1462440166-94042-1-git-send-email-salvatore.benedetto@intel.com>
To: Salvatore Benedetto <salvatore.benedetto@intel.com>
Sender: linux-crypto-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Salvatore,

> This patch has *not* been tested as I don't have the hardware.
> It's purpose is to show how to use the kpp API.
> 
> Based on https://patchwork.kernel.org/patch/9022371/

actually you should be able to verify this without hardware. The BlueZ userspace package contains tools/mgmt-tester and tools/smp-tester which should both exercise most of the Bluetooth Security Manager (SMP) pieces.

Regards

Marcel

