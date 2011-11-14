Return-Path: <cyrus@holtmann.org>
Date: Mon, 14 Nov 2011 17:33:38 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Slawomir Bochenski <lkslawek@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 obexd] phonebook-tracker: Seek for contact name deeper
Message-ID: <20111114153338.GA6994@fusion.localdomain>
References: <20111114141752.GA3457@fusion.localdomain>
 <1321281112-26363-1-git-send-email-lkslawek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1321281112-26363-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Slawek,

On Mon, Nov 14, 2011, Slawomir Bochenski wrote:
> Some contacts in Tracker can have no name fields set nor nickname. This
> patch enhances the way the contact name is obtained:
> 
> 1) If there is no nco:nickname set for contact, use nco:imNickname from
> its related IM data.
> 2) As the N field is mandatory in both vCard 2.1 and 3.0 and it's the
> most useful field for PBAP clients, if its components are not present
> in Tracker, use nco:fullname (thus promote FN to N) or if nco:fullname
> is also not present, then use previously obtained nickname for N field.
> ---
> 
> v2: changed 0 to '\0' in char type comparisons
> 
>  plugins/phonebook-tracker.c |   91 ++++++++++++++++++++++++++++++++++++++-----
>  1 files changed, 81 insertions(+), 10 deletions(-)

Applied. Thanks.

Johan
