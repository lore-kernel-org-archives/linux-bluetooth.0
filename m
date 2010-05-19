Return-Path: <cyrus@holtmann.org>
Date: Wed, 19 May 2010 16:10:26 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v3] Bluetooth: Add blacklist support for incoming
 connections
Message-ID: <20100519141026.GA7161@jh-x301>
References: <1274181632-29873-1-git-send-email-johan.hedberg@gmail.com>
 <20100519081037.GE6219@vigoh>
 <20100519082205.GA18772@jh-x301>
 <20100519084715.GA11110@vigoh>
 <AANLkTimdw00tjbCHK52SNF9FGJjLVHR35f44dX_bzj__@mail.gmail.com>
 <20100519140503.GA6822@jh-x301>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100519140503.GA6822@jh-x301>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, May 19, 2010, Johan Hedberg wrote:
> What also happens when you set Blocked to False is that all the device
> drivers are unloaded for that device. When Blocked goes back to true
> the drivers get probed again.

I mixed up True/False there, but you probably realized that :)

Johan
