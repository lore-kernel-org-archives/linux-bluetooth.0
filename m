Return-Path: <cyrus@holtmann.org>
Subject: Re: [RFC 2/2] Bluetooth: Add support for returning the encryption
 key size
From: Marcel Holtmann <marcel@holtmann.org>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org, johan.hedberg@gmail.com
In-Reply-To: <1302915440.2503.26.camel@aeonflux>
References: <1302825888-5359-1-git-send-email-vinicius.gomes@openbossa.org>
	 <1302825888-5359-3-git-send-email-vinicius.gomes@openbossa.org>
	 <1302915440.2503.26.camel@aeonflux>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 15 Apr 2011 22:24:25 -0700
Message-ID: <1302931465.2503.33.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

> And of course the same now applies for PIN code length. Even if with
> Simple Pairing this does not matter anymore. For Legacy Pairing this is
> still relevant.

forget about this comment. It is actually bogus since the HIGH vs MEDIUM
security for Legacy Pairing implies the PIN length requirement already.

We just need to make sure to enforce it properly via the new in-kernel
handling of pairing.

Regards

Marcel


