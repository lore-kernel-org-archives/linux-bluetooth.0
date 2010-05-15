Return-Path: <cyrus@holtmann.org>
Date: Sat, 15 May 2010 07:42:30 +0100 (BST)
To: Lorenzo Brito Morales <lorenzo.brito@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: configure the range of the scanning of a dongle
In-Reply-To: <AANLkTiktTYVQoG6NfaGfosltKuYi1ANNIgWtfZQiRWq2@mail.gmail.com>
References: <AANLkTiktTYVQoG6NfaGfosltKuYi1ANNIgWtfZQiRWq2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Message-Id: <1273905750.194080.7421.nullmailer@galant.ukfsn.org>
From: Iain Hibbert <plunky@rya-online.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sat, 15 May 2010, Lorenzo Brito Morales wrote:

> i want to know if its possible to configure the range of the scanning
> of a dongle

Not really, but you could interpret the RSSI result field and pretend that
signal strength had a bearing on distance.

iain


