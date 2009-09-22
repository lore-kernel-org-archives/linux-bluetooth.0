Return-Path: <cyrus@holtmann.org>
Date: Tue, 22 Sep 2009 21:31:22 +0100 (BST)
To: bluezprofile kernel <bluezprofile@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: LLMNR request
In-Reply-To: <ba5648fa0909221034p79063400t92033fedcf052762@mail.gmail.com>
References: <ba5648fa0909221034p79063400t92033fedcf052762@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Message-Id: <1253651482.664376.8022.nullmailer@galant.ukfsn.org>
From: Iain Hibbert <plunky@rya-online.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 22 Sep 2009, bluezprofile kernel wrote:

> Is it possible to send LLMNR request over bnep interface?.

I see no reason to believe otherwise.

> How to send?

It would be no different sending it on any other transport since LLMNR is
(according to Wikipedia) an application layer protocol using UDP/TCP and
BNEP is a link layer protocol.

> Please provide me some guide lines regarding this.

Just use the normal method. (whatever that is)

iain


