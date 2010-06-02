Return-Path: <cyrus@holtmann.org>
Date: Wed, 2 Jun 2010 17:48:48 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 00/32] Health device profile (HDP)
Message-ID: <20100602204632.GA18001@vigoh>
References: <1275484768-25838-1-git-send-email-santoscadenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1275484768-25838-1-git-send-email-santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jose,

* Jose Antonio Santos Cadenas <santoscadenas@gmail.com> [2010-06-02 15:18:56 +0200]:

> Next patches are aplied over the MCAP patches sended to thie mailing list by
> Santiago Carot. This a first patches manage the creation of links beetween 
> instances and begins the support for creating data chanels, but doesn't 
> finish it yet.

For debug use the DBG() function instead of debug(). Change your patches
to match this and use the new dynamic debug feature.

-- 
Gustavo F. Padovan
http://padovan.org
