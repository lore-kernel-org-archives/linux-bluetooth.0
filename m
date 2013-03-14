Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1363214780-23043-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1363214780-23043-1-git-send-email-vinicius.gomes@openbossa.org>
Date: Thu, 14 Mar 2013 16:59:56 +0100
Message-ID: <CA+QXtDs=Nrc8rUgMuEd9Nkv3ZbTak5ENecW849ghybveiYa13w@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Fix not closing SCO sockets in the BT_CONNECT2 state
From: "Dalleau, Frederic" <frederic.dalleau@intel.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Wed, Mar 13, 2013 at 11:46 PM, Vinicius Costa Gomes
<vinicius.gomes@openbossa.org> wrote:
> With deferred setup for SCO, it is possible that userspace closes the
> socket when it is in the BT_CONNECT2 state, after the Connect Request is
> received but before the Accept Synchonous Connection is sent.

This issue was in my pipe, so I took some time to test the patch and
it works fine, thanks!

Frédéric
