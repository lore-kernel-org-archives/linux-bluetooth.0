Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1300277421-8053-2-git-send-email-waldemar.rymarkiewicz@tieto.com>
References: <1300277421-8053-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
	<1300277421-8053-2-git-send-email-waldemar.rymarkiewicz@tieto.com>
Date: Wed, 16 Mar 2011 23:06:59 +0100
Message-ID: <AANLkTinF695CSLoSgxCn1LOiZ=jF-Z8OjAsEeY52K8GG@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] Add support for SAP protocol
From: "ANGUS.H" <hombre71@gmail.com>
To: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

2011/3/16 Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>:
> Add new protocol features:
>        * transfer APDu request/response
>        * get ATR request/response
>        * power sim of/on request/response
>        * card reader status
>        * set transport protocol
> ---
>  sap/server.c |  415 +++++++++++++++++++++++++++++++++++++++++++++++++++++++---
>  1 files changed, 399 insertions(+), 16 deletions(-)


Hi

A lot of code could be refactored.
Quite a few repeatable (logically) blocks in every
"...._req()" and "..._rsp()" handlers.

/A.H
