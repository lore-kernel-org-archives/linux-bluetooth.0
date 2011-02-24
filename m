Return-Path: <cyrus@holtmann.org>
Date: Wed, 23 Feb 2011 23:54:37 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] hcitool: add discovery procedure to lescan command
Message-ID: <20110224025437.GA6189@jh-x301>
References: <1298495788-22273-1-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1298495788-22273-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi André,

On Wed, Feb 23, 2011, Andre Guedes wrote:
> +	"\tlescan [--discovery=g|l] enable general or limited discovery"

To make this consistent with the other options please default to general
and have a --limited switch to enable limited discovery.

Johan
