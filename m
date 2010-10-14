Return-Path: <cyrus@holtmann.org>
Date: Thu, 14 Oct 2010 14:15:01 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Pull request git://gitorious.org/bluez-mcap-hdp/mcap-hdp.git
 for_upstream
Message-ID: <20101014111501.GA32530@jh-x301>
References: <AANLkTimBnzJzW_YLjW+NJq-MJ_aEMtSFNy_eKS5v70N4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <AANLkTimBnzJzW_YLjW+NJq-MJ_aEMtSFNy_eKS5v70N4@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jose,

On Thu, Oct 14, 2010, Jose Antonio Santos Cadenas wrote:
> The following changes since commit 6b9deca15d0824ad5b3c38f8c0dd3a3c482572ea:
> 
>   TODO: Device Name Characteristic for Low Energy (2010-10-13 22:26:59 +0300)
> 
> are available in the git repository at:
>   git://gitorious.org/bluez-mcap-hdp/mcap-hdp.git for_upstream
> 
> José Antonio Santos Cadenas (7):
>       Connect echo channel
>       Initial steps to send echo data
>       Generate random echo packet
>       Create a function for closing mcl correctly
>       Notify channel deletion correctly
>       Separate private echo data from data channels
>       Add initial support for deleting an echo channel
> 
> Santiago Carot-Nemesio (8):
>       Add support to initiate echo
>       Remove unnecessary variable
>       Set watcher to check echo response
>       Check echo response
>       Add timeout to wait for echo reply
>       Abort echo channel if connection was not successful
>       Remove MDL when delete operation fails with INVALID_MDLID error
>       Remove unnecessary function
> 
>  health/hdp.c       |  431 +++++++++++++++++++++++++++++++++++++++++-----------
>  health/hdp_types.h |    5 +-
>  health/mcap.c      |   14 ++-
>  3 files changed, 361 insertions(+), 89 deletions(-)

Pushed upstream. Thanks.

Johan
