Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1345040407-17767-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1345040407-17767-1-git-send-email-claudio.takahasi@openbossa.org>
Date: Thu, 16 Aug 2012 09:53:48 -0300
Message-ID: <CAKT1EBfp+iJfRSodDfoqtDB4X90BNR1wEJh_zXvw0t6JvnaWuA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v0 00/10] GAP Plugin
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan:

On Wed, Aug 15, 2012 at 11:19 AM, Claudio Takahasi
<claudio.takahasi@openbossa.org> wrote:
> This patch series adds a new GATT based plugin for GAP service. The
> objective is cleanup: moving some GATT related operations from the
> device(core) to a GATT based plugin.

Ignore this patch series. As discussed in the IRC, a new GATT plugin
will be created to handle GAP and GATT services characteristics.
The term "GAP" for a GAP characteristics plug-in is not suitable since
it may create misinterpretation with GAP BR/EDR.

BR,
Claudio
