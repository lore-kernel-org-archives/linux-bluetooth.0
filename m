Return-Path: <cyrus@holtmann.org>
Date: Tue, 28 Jun 2011 11:03:31 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Slawomir Bochenski <lkslawek@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd v2] Fix parameters in obexd.service.in
Message-ID: <20110628080331.GF18047@dell.ger.corp.intel.com>
References: <1308651896-21524-1-git-send-email-lkslawek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1308651896-21524-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Slawek,

On Tue, Jun 21, 2011, Slawomir Bochenski wrote:
> This adjusts obexd.service.in to changes introduced in commit
> e7792642accead1de0016bd7f78c74d9b6cad38a, making obexd use all built-in
> plugins when activated by D-Bus.
> ---
>  src/obexd.service.in |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Applied. Thanks.

Johan
