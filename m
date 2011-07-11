Return-Path: <cyrus@holtmann.org>
Date: Mon, 11 Jul 2011 15:27:43 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Slawomir Bochenski <lkslawek@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd v2] Do not send empty vCard attributes
Message-ID: <20110711122743.GA11809@dell.ger.corp.intel.com>
References: <1310373431-6614-1-git-send-email-lkslawek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1310373431-6614-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Slawek,

On Mon, Jul 11, 2011, Slawomir Bochenski wrote:
> PBAP specification v1.1, chap. 5.1.4.1 and 5.4.4.1 states that
> non-mandatory attributes shall be sent only when their value is not NULL.
> In case of vCards this can be simply understood as non-empty, therefore
> the patch makes phonebook_add_contact add only mandatory attributes for
> specified vCard version as well as those for which values are of non-zero
> length.
> ---
> v2: Fix conflicts coming from 1666935c5ae68bf645ca10b18303378adf77f599

Applied. Thanks.

Johan
